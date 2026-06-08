#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS=("tutor-setup" "tutor")

# Helper function to install a skill to a target directory
install_skill_to_dir() {
  local skill="$1"
  local target_dir="$2"
  local platform_name="$3"

  if [ -d "$target_dir" ]; then
    echo "$skill skill already exists in $platform_name at $target_dir"
    printf "Overwrite? (y/N): "
    read -r answer
    if [ "$answer" != "y" ] && [ "$answer" != "Y" ]; then
      echo "Skipping $skill in $platform_name."
      return
    fi
  fi

  mkdir -p "$target_dir/references"
  cp "$SCRIPT_DIR/skills/$skill/SKILL.md" "$target_dir/"
  cp "$SCRIPT_DIR/skills/$skill/references/"* "$target_dir/references/"
  echo "Installed $skill to $platform_name ($target_dir)"
}

for skill in "${SKILLS[@]}"; do
  # Claude Code Skill Directory
  CLAUDE_DIR="$HOME/.claude/skills/$skill"
  install_skill_to_dir "$skill" "$CLAUDE_DIR" "Claude Code"

  # Antigravity CLI (agy) Skill Directory
  AGY_DIR="$HOME/.gemini/antigravity-cli/skills/$skill"
  install_skill_to_dir "$skill" "$AGY_DIR" "Antigravity CLI (agy)"
done

echo ""
echo "Done! Usage:"
echo "  In Claude Code:"
echo "    /tutor-setup  — Generate a StudyVault from documents or code"
echo "    /tutor        — Start an interactive quiz session"
echo "  In Antigravity CLI (agy):"
echo "    /tutor-setup  — Generate a StudyVault from documents or code"
echo "    /tutor        — Start an interactive quiz session"
