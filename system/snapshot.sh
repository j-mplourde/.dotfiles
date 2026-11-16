#!/usr/bin/env bash
# snapshot.sh — list the tools installed on this machine, one plain-text
# manifest per package manager, so they can be reinstalled on a new one.
# Writes to $MANIFEST_DIR (default: manifests/ next to this script).
set -euo pipefail

# Locale-independent sort order keeps manifests stable between machines.
export LC_ALL=C

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST_DIR="${MANIFEST_DIR:-$SCRIPT_DIR/manifests}"

info()    { echo "[info]  $*"; }
success() { echo "[ok]    $*"; }

has() { command -v "$1" > /dev/null; }

dnf_packages()   { dnf repoquery --userinstalled --qf '%{name}\n' | sort; }
enabled_repos()  { dnf repo list --enabled | tail -n +2 | awk '{print $1}'; }
flatpaks()       { flatpak list --app --columns=application | sort; }
brew_packages()  { brew leaves; }
uv_tools()       { uv tool list | awk '!/^-/ {print $1}'; }
node_version()   { node --version; }

# npm ships inside Node.js; reinstalling it globally would pin an old version.
npm_globals() {
    npm ls -g --depth=0 --parseable \
        | sed -n 's|.*/node_modules/||p' \
        | awk '$0 != "npm" && $0 != "corepack"' \
        | sort
}

# record <manifest> <tool> <producer>: write the producer's output to the
# manifest, or skip it when the tool isn't installed on this machine.
record() {
    local manifest="$1" tool="$2" producer="$3"
    if ! has "$tool"; then
        info "Skipped $manifest: $tool is not installed"
        return
    fi
    "$producer" > "$MANIFEST_DIR/$manifest"
    success "Recorded $manifest"
}

# ── Main ─────────────────────────────────────────────────────────────────────
mkdir -p "$MANIFEST_DIR"

record dnf-packages.txt  dnf     dnf_packages
record enabled-repos.txt dnf     enabled_repos
record flatpaks.txt      flatpak flatpaks
record brew-packages.txt brew    brew_packages
record uv-tools.txt      uv      uv_tools
record npm-globals.txt   npm     npm_globals
record node-version.txt  node    node_version

echo ""
info "Done. Manifests written to $MANIFEST_DIR"
