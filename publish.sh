#!/usr/bin/env bash
set -euo pipefail

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Not inside a git repository." >&2
  exit 1
fi

message="${1:-}"
if [[ -z "${message}" ]]; then
  message="chore: publish $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
fi

if [[ -z "$(git status --porcelain)" ]]; then
  echo "No changes to commit."
  exit 0
fi

git add -A
git commit -m "${message}"
git push
