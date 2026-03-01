#!/bin/bash

# ==============================================================================
# Usage: ./setup_nvim.sh [TARGET_HOME_PATH]
# Example: ./setup_nvim.sh /home/custom_user
# WSL Example: ./setup_nvim.sh ~  (resolves to /home/your_user)
# ==============================================================================

# 1. Handle Arguments & Paths
# Use provided argument OR default to the current user's $HOME
TARGET_HOME=${1:-$HOME}
NVIM_CONFIG_DIR="$TARGET_HOME/.config/nvim"
INIT_PATH="$NVIM_CONFIG_DIR/init.lua"
REPO_INIT_FILE="init.lua"

echo "-----------------------------------------------"
echo "🔍 Starting Neovim Configuration Setup..."
echo "Targeting: $NVIM_CONFIG_DIR"
echo "-----------------------------------------------"

# 2. Check if Neovim is installed
if command -v nvim >/dev/null 2>&1; then
    echo "✅ Neovim found at: $(command -v nvim)"
else
    echo "❌ Error: Neovim is not installed. Please install it before running this script."
    exit 1
fi

# 3. Create directory if it doesn't exist
if [ ! -d "$NVIM_CONFIG_DIR" ]; then
    echo "📂 Creating directory: $NVIM_CONFIG_DIR"
    mkdir -p "$NVIM_CONFIG_DIR"
else
    echo "ℹ️  Directory already exists."
fi

# 4. Backup existing init.lua if it exists
if [ -f "$INIT_PATH" ]; then
    BACKUP_NAME="$INIT_PATH.bak.$(date +%Y%m%d_%H%M%S)"
    echo "🛡️  Existing config found. Creating backup: $BACKUP_NAME"
    mv "$INIT_PATH" "$BACKUP_NAME"
fi

# 5. Move/Copy the new init.lua
if [ -f "$REPO_INIT_FILE" ]; then
    cp "$REPO_INIT_FILE" "$INIT_PATH"
    echo "📝 Successfully deployed new $REPO_INIT_FILE"
else
    echo "⚠️  Error: Could not find '$REPO_INIT_FILE' in current directory to copy!"
    exit 1
fi

echo "-----------------------------------------------"
echo "🎉 SETUP COMPLETE!"
echo "-----------------------------------------------"
echo "Summary of actions:"
echo "  - Config Path:  $NVIM_CONFIG_DIR"
echo "  - WSL Context:  Mapped to your Linux home (not Windows /mnt/c/)"
echo "  - Backup:       Created if an old init.lua existed"
echo ""
echo "🚀 Quickstart Neovim:"
echo "  1. Run 'nvim'"
echo "  2. Lazy.nvim will auto-download plugins (Treesitter, Mason, etc.)"
echo "  3. Once finished, restart nvim to apply all changes"
echo "-----------------------------------------------"