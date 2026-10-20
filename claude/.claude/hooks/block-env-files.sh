#!/usr/bin/env bash
# Blocks Bash commands that touch .env files (secrets). Example/sample/template files stay allowed.
cmd=$(jq -r '.tool_input.command // empty')
stripped=$(printf '%s' "$cmd" | sed -E 's/\.env\.(example|sample|template)//g')
if printf '%s' "$stripped" | grep -Eq '(^|[[:space:]/"'"'"'=<>(:])\.env([.][A-Za-z0-9_-]+)*($|[[:space:]"'"'"';|&)>*])'; then
  jq -n '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:".env files hold secrets and are off limits. Ask the user to read or change the value instead."}}'
fi
exit 0
