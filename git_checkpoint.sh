#!/usr/bin/env bash
set -e

msg="${1:-checkpoint}"
git add -A
git commit -m "$msg"
git push
