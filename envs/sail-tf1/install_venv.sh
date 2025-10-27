#!/usr/bin/env bash
set -euo pipefail
TARGET="${1:-$HOME/.venvs/sail-tf1}"

python3 -m venv "$TARGET"
source "$TARGET/bin/activate"
python -m pip install --upgrade pip

# Prefer local wheels (offline), fall back to network if needed
if [ -d "$(dirname "$0")/wheels" ]; then
  pip install --no-index --find-links "$(dirname "$0")/wheels" -r "$(dirname "$0")/requirements.txt" \
  || pip install -r "$(dirname "$0")/requirements.txt"
else
  pip install -r "$(dirname "$0")/requirements.txt"
fi

python -V
pip list | wc -l
echo "Venv ready at: $TARGET"
