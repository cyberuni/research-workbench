#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: bash scripts/new-topic.sh \"Topic Title\"" >&2
  exit 1
fi

TITLE="$1"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATES_DIR="$ROOT_DIR/assets/templates"
RESEARCH_DIR="$ROOT_DIR/docs/research"

SLUG="$(printf '%s' "$TITLE" \
  | tr '[:upper:]' '[:lower:]' \
  | sed 's/[^a-z0-9 ]//g' \
  | sed 's/ \+/-/g' \
  | sed 's/^-//; s/-$//')"

if [[ -z "$SLUG" ]]; then
  echo "Error: could not derive a slug from title: $TITLE" >&2
  exit 1
fi

TOPIC_DIR="$RESEARCH_DIR/$SLUG"

if [[ -e "$TOPIC_DIR" ]]; then
  echo "Error: topic already exists: $TOPIC_DIR" >&2
  exit 1
fi

mkdir -p "$TOPIC_DIR"
cp "$TEMPLATES_DIR/topic.md" "$TOPIC_DIR/topic.md"
cp "$TEMPLATES_DIR/synthesis.md" "$TOPIC_DIR/synthesis.md"
cp "$TEMPLATES_DIR/evidence.md" "$TOPIC_DIR/evidence.md"
cp "$TEMPLATES_DIR/changes.md" "$TOPIC_DIR/changes.md"

python3 - "$TOPIC_DIR" "$TITLE" <<'PY'
from pathlib import Path
import sys

topic_dir = Path(sys.argv[1])
title = sys.argv[2]

replacements = {
    "<Topic>": title,
    "<Topic Title>": title,
}

for path in topic_dir.iterdir():
    if path.suffix != ".md":
        continue
    content = path.read_text()
    for needle, replacement in replacements.items():
        content = content.replace(needle, replacement)
    path.write_text(content)
PY

echo "$TOPIC_DIR"
