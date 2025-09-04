# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a modern Neovim configuration written in Lua, using the lazy.nvim plugin manager for modular plugin loading. The configuration follows a structured approach:

### Core Structure
- `init.lua` - Entry point that loads the main configuration from `lua/nvim/`
- `lua/nvim/init.lua` - Main configuration loader that sets up platform-specific paths, loads core settings, keymaps, and initializes plugin management
- `lua/nvim/lazy_init.lua` - Lazy.nvim bootstrap and setup
- `lua/nvim/set.lua` - Core Vim settings and options
- `lua/nvim/remap.lua` - Global keymaps and key bindings
- `lua/nvim/lazy/` - Modular plugin configurations

### Plugin Architecture
Each plugin or group of related plugins has its own file in `lua/nvim/lazy/`:
- `lsp.lua` - LSP configuration with Mason for automatic language server management
- `telescope.lua` - Fuzzy finder with custom pickers and keymaps
- `treesitter.lua` - Syntax highlighting and code understanding
- `ai.lua` - AI assistance plugins (Copilot, Avante)
- `colors.lua` - Color scheme and appearance
- `visuals.lua` - UI enhancements (statusline, scrollbar, etc.)
- `init.lua` - Basic utility plugins (autopairs, surround, etc.)

### Key Features
- Uses lazy.nvim for plugin management with lazy loading
- LSP setup with Mason for automatic language server installation
- Telescope for fuzzy finding with custom configurations
- AI integration via Copilot and Avante
- Custom keymaps optimized for productivity (Space as leader key)
- Platform-specific configurations (Windows/Unix)

## Common Commands

### Development and Maintenance
- **Format Lua code**: `stylua .` (uses `.stylua.toml` configuration)
- **Check Lua syntax**: The Lua Language Server is configured via `.luarc.json`

### Plugin Management (via lazy.nvim)
- **Update plugins**: `:Lazy update`
- **Install plugins**: `:Lazy install`
- **Plugin status**: `:Lazy`
- **Profile startup time**: `:Lazy profile`

### LSP Management (via Mason)
- **Install language servers**: `:Mason`
- **LSP info for current buffer**: `:LspInfo`
- **Restart LSP**: `:LspRestart`

### Key Configuration Details

#### Custom Keymaps
- Leader key: `<Space>`
- `<Enter>` in normal mode: Format and save file
- `K` in normal mode: Close current buffer
- `gn`/`gN`: Navigate quickfix list
- Custom window navigation with `<C-hjkl>`
- SQL formatting with `<leader>s`

#### File Structure Patterns
- Filetype-specific configs in `ftplugin/` directory
- Plugin specs return tables from `lua/nvim/lazy/` files
- Core Neovim settings separated from plugin configurations
- Auto-commands for file handling (trailing whitespace removal, fold management)

#### Important Settings
- Uses 4-space indentation by default
- Line wrapping disabled
- Color column at 80 characters
- Persistent undo enabled
- Case-insensitive search with smart case
- System clipboard integration enabled