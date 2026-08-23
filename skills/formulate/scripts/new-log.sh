#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: bash scripts/new-log.sh \"Topic Title\"" >&2
  exit 1
fi

TITLE="$1"
SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ROOT_DIR="$(git -C "$SKILL_DIR" rev-parse --show-toplevel)"
TEMPLATES_DIR="$SKILL_DIR/assets/templates"
DEFAULT_RESEARCH_ROOT=".research"

resolve_research_root() {
  if [[ -n "${RESEARCH_ROOT:-}" ]]; then
    printf '%s\n' "${RESEARCH_ROOT%/}"
    return
  fi

  local local_skill="$SKILL_DIR/SKILL.local.md"
  if [[ -f "$local_skill" ]]; then
    local configured_root
    configured_root="$(sed -nE "s/^[[:space:]]*research_root:[[:space:]]*['\"]?([^'\"]+)['\"]?[[:space:]]*$/\\1/p" "$local_skill" | head -n 1)"
    if [[ -n "$configured_root" ]]; then
      printf '%s\n' "${configured_root%/}"
      return
    fi
  fi

  printf '%s\n' "$DEFAULT_RESEARCH_ROOT"
}

RESEARCH_ROOT="$(resolve_research_root)"

if [[ "$RESEARCH_ROOT" = /* ]]; then
  echo "Error: research root must be repo-relative: $RESEARCH_ROOT" >&2
  exit 1
fi

RESEARCH_DIR="$ROOT_DIR/$RESEARCH_ROOT"

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
cp "$TEMPLATES_DIR/log.md" "$TOPIC_DIR/log.md"
cp "$TEMPLATES_DIR/changes.md" "$TOPIC_DIR/changes.md"

python3 - "$TOPIC_DIR" "$TITLE" "$SLUG" "$RESEARCH_ROOT" <<'PY'
from pathlib import Path
import datetime
import json
import sys

topic_dir = Path(sys.argv[1])
title, slug, root = sys.argv[2], sys.argv[3], sys.argv[4]

replacements = {
    "<Topic>": title,
    "<Topic Title>": title,
    "<YYYY-MM-DD>": datetime.date.today().isoformat(),
}

for path in sorted(topic_dir.iterdir()):
    if path.suffix != ".md":
        continue
    content = path.read_text()
    for needle, replacement in replacements.items():
        content = content.replace(needle, replacement)
    path.write_text(content)

sys.stdout.write(json.dumps({
    "slug": slug,
    "topic_dir": f"{root}/{slug}",
    "files": {
        "topic": f"{root}/{slug}/topic.md",
        "log": f"{root}/{slug}/log.md",
        "changes": f"{root}/{slug}/changes.md",
    },
}) + "\n")
PY
