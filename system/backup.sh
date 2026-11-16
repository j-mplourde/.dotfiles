#!/usr/bin/env bash
# backup.sh — archive the files worth keeping, plus the list of installed
# tools, onto a USB key so they can be moved to a new laptop.
#
# Usage:   backup.sh /run/media/$USER/<usb-key>
# Restore: tar --zstd -xf /run/media/$USER/<usb-key>/laptop-backup/home.tar.zst -C ~
#
# A single archive keeps permissions, executable bits and symlinks even on an
# exFAT key, which cannot store them as loose files.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Folders to archive, relative to $HOME.
BACKUP_PATHS=(
    Documents/projects
    orca/workspaces
    .config/orca
)

# Rebuildable from a lockfile or by the app itself, or tied to the Orca
# instance running right now. tar matches a pattern containing "/" against
# the end of a path, so a project's own logs folder is kept.
EXCLUDES=(
    node_modules
    .venv
    __pycache__
    ".config/orca/Cache"
    ".config/orca/Code Cache"
    ".config/orca/GPUCache"
    ".config/orca/logs"
    ".config/orca/Singleton*"
)

# GNU tar exits 1 when a file changed while it was read, which is expected
# for Orca's databases while Orca is running; 2 and above are real failures.
TAR_FILES_CHANGED=1

info()  { echo "[info]  $*"; }
warn()  { echo "[warn]  $*" >&2; }
error() { echo "[error] $*" >&2; }

usage() {
    error "Usage: $(basename "$0") /run/media/\$USER/<usb-key>"
    exit 1
}

existing_paths() {
    local path
    for path in "${BACKUP_PATHS[@]}"; do
        if [[ ! -e "$HOME/$path" ]]; then
            warn "Skipped ~/$path: not found"
            continue
        fi
        echo "$path"
    done
}

check_usb() {
    local usb="$1"
    if [[ ! -d "$usb" ]]; then
        error "USB key not found at $usb. Is it plugged in and mounted?"
        exit 1
    fi
}

archive() {
    local archive="$1"; shift
    local status=0
    tar --zstd -cf "$archive" -C "$HOME" "${EXCLUDES[@]/#/--exclude=}" "$@" || status=$?
    if [[ $status -eq $TAR_FILES_CHANGED ]]; then
        warn "Some files changed while being archived (is Orca running?); they were saved as they were at that moment."
        return 0
    fi
    return "$status"
}

# ── Main ─────────────────────────────────────────────────────────────────────
[[ $# -eq 1 ]] || usage
check_usb "$1"

TARGET="$1/laptop-backup"
mkdir -p "$TARGET"

MANIFEST_DIR="$TARGET/tools" bash "$SCRIPT_DIR/snapshot.sh"

mapfile -t PATHS < <(existing_paths)
if [[ ${#PATHS[@]} -gt 0 ]]; then
    info "Archiving ${PATHS[*]}"
    archive "$TARGET/home.tar.zst" "${PATHS[@]}"
fi

echo ""
info "Done. Backup written to $TARGET"
info "Restore on the new laptop with: tar --zstd -xf $TARGET/home.tar.zst -C ~"
