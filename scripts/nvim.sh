#!/bin/bash
#
# Setup Neovim

set -euo pipefail

# Link ~/.config/nvim to this repo's config, backing up any existing one first
# Assumes this script is invoked from the repo root (e.g. via Makefile)
REPO_ROOT="$(pwd)"
SRC="${REPO_ROOT}/.config/nvim"
DEST="${HOME}/.config/nvim"

echo "Repo root: ${REPO_ROOT}"
echo "Source  : ${SRC}"
echo "Dest    : ${DEST}"
echo

# Source exists?
if [ ! -d "${SRC}" ]; then
  echo "ERROR: Source directory not found: ${SRC}" >&2
  exit 1
fi

# Ensure ~/.config exists
mkdir -p "${HOME}/.config"

# If dest is already the correct symlink, do nothing
if [ -L "${DEST}" ]; then
  # Resolve symlink target (portable enough for mac/linux with readlink)
  TARGET="$(readlink "${DEST}" || true)"
  if [ "${TARGET}" = "${SRC}" ]; then
    echo "OK: Already linked."
    exit 0
  fi
fi

# If destination exists (file/dir/symlink), back it up
if [ -e "${DEST}" ] || [ -L "${DEST}" ]; then
  TS="$(date +%Y%m%d-%H%M%S)"
  BACKUP="${DEST}.backup.${TS}"
  echo "Backing up existing ${DEST} -> ${BACKUP}"
  mv "${DEST}" "${BACKUP}"
fi

# Create the symlink
rm -rf "$DEST"
ln -s "$SRC" "$DEST"
echo "Linked $DEST -> $SRC"
