#!/usr/bin/env bash
set -euo pipefail

REPO="${CLAUDE_INIT_REPO:-forestwow/claude-code-boilerplate}"
INSTALL_DIR="${CLAUDE_INIT_INSTALL_DIR:-$HOME/.local/bin}"
BIN_NAME="claude-init"
RAW_URL="https://raw.githubusercontent.com/${REPO}/main/bin/${BIN_NAME}"

echo "Installing ${BIN_NAME}..."

mkdir -p "$INSTALL_DIR"

if command -v curl &>/dev/null; then
  curl -fsSL "$RAW_URL" -o "${INSTALL_DIR}/${BIN_NAME}"
elif command -v wget &>/dev/null; then
  wget -qO "${INSTALL_DIR}/${BIN_NAME}" "$RAW_URL"
else
  echo "Error: curl or wget is required."
  exit 1
fi

# Verify we got a valid script
if ! head -1 "${INSTALL_DIR}/${BIN_NAME}" | grep -q "^#!/"; then
  rm -f "${INSTALL_DIR}/${BIN_NAME}"
  echo "Error: download failed — not a valid script."
  exit 1
fi

chmod +x "${INSTALL_DIR}/${BIN_NAME}"

# Check if install dir is in PATH
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$INSTALL_DIR"; then
  echo ""
  echo "Warning: ${INSTALL_DIR} is not in your PATH."
  echo "Add it by running:"
  echo ""
  shell_name=$(basename "${SHELL:-/bin/bash}")
  case "$shell_name" in
    zsh)  rc_file="~/.zshrc" ;;
    bash) rc_file="~/.bashrc" ;;
    fish) rc_file="~/.config/fish/config.fish" ;;
    *)    rc_file="~/.profile" ;;
  esac
  if [[ "$shell_name" == "fish" ]]; then
    echo "  echo 'set -gx PATH ${INSTALL_DIR} \$PATH' >> ${rc_file}"
  else
    echo "  echo 'export PATH=\"${INSTALL_DIR}:\$PATH\"' >> ${rc_file}"
  fi
  echo ""
fi

version=$("${INSTALL_DIR}/${BIN_NAME}" version 2>/dev/null || echo "installed")
echo "${BIN_NAME} ${version} → ${INSTALL_DIR}/${BIN_NAME}"
echo ""
echo "Usage:"
echo "  claude-init my-project    # scaffold a new project"
echo "  claude-init update        # update to latest version"
