# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Personal Neovim config in Lua, managed by lazy.nvim. It targets **Neovim 0.12+**: it relies on `vim.lsp.config`/`vim.lsp.enable`, `vim.lsp.inline_completion`, `vim.lsp.linked_editing_range`, `'winborder'`, `vim.diagnostic.jump`, and the nvim-treesitter `main` branch rewrite. Don't reintroduce pre-0.11 APIs such as `require('lspconfig').X.setup`, `nvim-treesitter.configs`, `vim.diagnostic.goto_*`, `vim.loop` or `vim.highlight`.

## Commands

There is no test suite. To check a change:

- **Startup errors**: `nvim --headless +qa` (any error output means something broke at load time)
- **Sync plugins to the lockfile**: `nvim --headless "+Lazy! restore" +qa`. Use `"+Lazy! sync"` to update instead.
- **Format Lua**: `stylua .`. Mason installs stylua to `~/.local/share/nvim/mason/bin/`, which may not be on `PATH`.
- **Health**: `:checkhealth vim.lsp`, `:checkhealth nvim-treesitter`, `:lsp`, `:ConformInfo`, `:Lazy`, `:Mason`

`lazy-lock.json` is committed. Plugin updates go in their own commit (`chore: update plugin dependencies via lazy.nvim`). Commits follow Conventional Commits (`feat:`, `fix(scope):`, `refactor(lsp):`).

### External requirements

- **tree-sitter CLI ≥ 0.26.1** on `PATH` (plus a C compiler, `tar`, `curl`): the nvim-treesitter `main` branch compiles parsers itself. Without it, existing parsers keep working but installing or updating them fails. Ubuntu's `apt install tree-sitter-cli` is too old on every release up to 26.04. Use the release binary or `cargo install tree-sitter-cli`, not npm:

  ```sh
  curl -L https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz \
    | gunzip > ~/.local/bin/tree-sitter && chmod +x ~/.local/bin/tree-sitter
  ```

- **fd**: telescope's `find_files` uses `fd`, falling back to `fdfind` (the Debian/Ubuntu binary name).

## Code style

`.stylua.toml` uses **3-space indent**, 160 columns, single quotes, and no parentheses on single-string/table calls (`require 'x'`, `setup { }`). The 4-space `tabstop`/`shiftwidth` in `set.lua` applies to files you edit in Neovim, not to this repo's Lua.

## Architecture

Load order: `init.lua` → `lua/nvim/init.lua` (Windows shada path) → `set.lua` (options, leader = Space) → `remap.lua` (global keymaps) → `lazy_init.lua`. Then `lua/nvim/init.lua` adds the trailing-whitespace-strip `BufWritePre` autocmd (skips markdown and non-modifiable buffers) and the diagnostic config (`virtual_lines` for the current line only).

- **Plugin specs**: `lazy.setup { spec = 'nvim.lazy' }` imports every file in `lua/nvim/lazy/`. To add a plugin, drop in a new file that returns a spec table; no registration needed. Several files (`recent.lua`, `sql.lua`, `ai.lua`) are fully commented out and kept as a parking lot.
- **Keymaps are scattered**: global ones live in `remap.lua`, but plugin keymaps sit inside each plugin's `config`/`init`, and LSP keymaps sit in the `LspAttach` autocmd in `lsp.lua`. Later definitions win. For example, `<leader>e` is nvim-tree (`tree-view.lua`), the diagnostic float is `<leader>d` (`lsp.lua`), and oil is `-` (`oil.lua`). Grep the whole tree before adding or changing a mapping.
- **LSP** (`lsp.lua`): Mason installs servers, and `mason-lspconfig` v2 auto-enables every installed server with nvim-lspconfig defaults. Only servers that need overrides go in the `servers` table. That table, plus a few extra tools (stylua, isort, copilot-language-server), is passed to `mason-tool-installer`'s `ensure_installed`. Shared capabilities come from blink.cmp through `vim.lsp.config('*', …)`. The `LspAttach` handler also turns on `linked_editing_range` (replaces nvim-ts-autotag) and inline completion.
- **Copilot**: not a plugin. `copilot-language-server` (Mason) is enabled with `vim.lsp.enable 'copilot'` in `lsp.lua`, and suggestions are drawn by `vim.lsp.inline_completion`. Insert-mode `<Tab>` accepts, `<M-]>`/`<M-[>` cycle. Auth is shared with `~/.config/github-copilot`; `:LspCopilotSignIn` if needed. It is not a blink source.
- **Formatting**: `<Enter>` in normal mode runs `require('conform').format` (LSP fallback, 4s timeout) and then `:w`. Formatters are set per filetype in `conform.lua` (stylua, isort+black, prettierd), so the binary must be installed through Mason or on `PATH`. SQL is excluded: `<leader>s` in visual mode pipes through `sqlfmt` (`remap.lua`).
- **Completion**: blink.cmp (`default` keymap preset) for LSP, path and buffer.
- **Borders**: `vim.o.winborder = 'rounded'` in `set.lua` covers blink, hover and diagnostic floats. Don't add per-plugin border config unless the plugin hardcodes its own.
- **Treesitter** (`treesitter.lua`): on the `main` branch, highlighting and indentation are started by hand in a `FileType` autocmd (`vim.treesitter.start` plus `indentexpr`). Textobject select/move/swap keymaps are bound explicitly. Add new parsers to the `ts.install { … }` list.
- **Telescope**: the `<CR>` override in insert mode sends results to the quickfix list *and* opens the selection, so `gn`/`gN` (`:cnext`/`:cprev`) walk the results afterwards. Other code also calls telescope directly: `remap.lua` (insert-mode `<C-f>` path insert) and `ftplugin/markdown.lua` (`@` file picker).
- **Colors**: `colors.lua` defines a global `ColorMyPencils()` that applies `juliana` and then overrides highlight groups. Highlight tweaks go there.
- **Folds/views**: `foldmethod=marker`, plus `mkview`/`loadview` autocmds in `set.lua` that persist folds and cursor per file. They are guarded to real on-disk file buffers (no gitcommit/oil/help).
- **ftplugin/**: per-filetype overrides. `<leader>x` means "run this file": `python3 %` for Python, `dbt run --select <model>` from the nearest `dbt_project.yml` for SQL, and disabled for TS/TSX. In markdown, `<Space>` is remapped buffer-locally to toggle a `- [ ]` checkbox, and `@` opens a file picker (`@@` types a literal `@`).
- **Platform branches**: `vim.fn.has 'win32'` checks set the shada path under `stdpath('data')` (`lua/nvim/init.lua`) and the stderr redirect for `sqlfmt` (`remap.lua`). telescope-fzf-native builds with `--target install` so MSVC puts the DLL where it's loaded from.

`stuff/` holds unrelated dotfiles (tmux, WezTerm, Vrapper, AutoHotkey). Neovim never loads them.
