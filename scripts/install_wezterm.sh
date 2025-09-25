#!/bin/bash
#
# Setup terminal emulator (wezterm)

set -euo pipefail

# Link ~/.config/wezterm to this repo's config, backing up any existing one first
# Assumes this script is invoked from the repo root (via Makefile)
REPO_ROOT="$(pwd)"
SRC="$REPO_ROOT/.config/wezterm"
DEST="$HOME/.config/wezterm"

if [ ! -d "$SRC" ]; then
  echo "Source directory not found: $SRC" >&2
  exit 1
fi

mkdir -p "$HOME/.config"

# Backup existing config if present (file/dir/symlink)
if [ -e "$DEST" ] || [ -L "$DEST" ]; then
  TS="$(date +%Y%m%d-%H%M%S)"
  BACKUP="$HOME/.config/wezterm.backup-$TS"
  echo "Backing up existing $DEST to $BACKUP"
  mv "$DEST" "$BACKUP"
fi

# Create the symlink
rm -rf "$DEST"
ln -s "$SRC" "$DEST"
echo "Linked $DEST -> $SRC"
