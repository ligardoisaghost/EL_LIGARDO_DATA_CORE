#!/bin/zsh
set -euo pipefail

cd "$HOME/EL_LIGARDO_DATA_CORE"

# stage everything
git add -A

# only commit if there are changes
if ! git diff --cached --quiet; then
  TS=$(date +"%Y-%m-%d_%H-%M")
  git commit -m "auto-checkpoint ${TS}"
fi
