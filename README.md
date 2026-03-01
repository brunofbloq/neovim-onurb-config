# 🚀 ONURB's Neovim Configuration

A robust, Lua-based Neovim environment tailored for software development. This configuration balances performance with a curated set of tools for LSP management, fast completion, and refined visual feedback.

## 📦 Included Plugins

This setup uses [lazy.nvim](https://github.com/folke/lazy.nvim) to manage the following core development tools:

| Category | Plugin | Description |
| :--- | :--- | :--- |
| **Theme** | `monokai.nvim` | The primary aesthetic for the editor. |
| **LSP Management** | `mason.nvim` | Automatically manages LSP servers, linters, and formatters. |
| **LSP Bridge** | `mason-lspconfig.nvim` | Seamlessly bridges Mason with `nvim-lspconfig`. |
| **Completion** | `coq_nvim` | High-speed, non-blocking autocompletion engine. |
| **Completion 3P** | `coq.thirdparty` | Adds external snippets and sources to COQ. |
| **Core LSP** | `nvim-lspconfig` | Standard configurations for the Nvim LSP client. |
| **Editing** | `nvim-surround` | Manipulate surrounding delimiters (quotes, parentheses, tags). |
| **Utilities** | `carbon-now.nvim` | Generate beautiful code screenshots directly from Nvim. |

## ✨ Custom Features
* **Visual Whitespace**: Configured to show tabs and trailing non-breaking spaces using `listchars`.
* **Custom Highlighting**: Features a manual highlight rule (`ExtraWhitespace`) that paints trailing spaces with a dark red background (`#3c1f1f`) for cleaner code maintenance.
* **Pre-configured LSP**: Includes specific optimizations for `lua_ls` (recognizing the `vim` global), `pyright` (Python), and `ts_ls

## 🛠 Installation & Setup

You can deploy this configuration automatically using the provided bash script. This script is fully compatible with Linux and **WSL**.

### 1. Run the Setup Script
The script will check for Neovim, create the `~/.config/nvim` directory, backup any existing `init.lua`, and deploy this configuration.

**Standard Installation:**
```bash
chmod +x setup_nvim.sh
./setup_nvim.sh