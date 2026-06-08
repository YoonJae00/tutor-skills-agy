#!/bin/bash
set -e

SKILLS=("tutor-setup" "tutor")

for skill in "${SKILLS[@]}"; do
  # Uninstall from Claude Code
  CLAUDE_DIR="$HOME/.claude/skills/$skill"
  if [ -d "$CLAUDE_DIR" ]; then
    rm -rf "$CLAUDE_DIR"
    echo "Removed $skill from Claude Code ($CLAUDE_DIR)"
  fi

  # Uninstall from Antigravity CLI (agy)
  AGY_DIR="$HOME/.gemini/antigravity-cli/skills/$skill"
  if [ -d "$AGY_DIR" ]; then
    rm -rf "$AGY_DIR"
    echo "Removed $skill from Antigravity CLI ($AGY_DIR)"
  fi
done
