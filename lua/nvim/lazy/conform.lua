return {
   {
      -- Formatting. Replaces none-ls: same binaries (installed by mason), but
      -- conform runs them directly instead of pretending to be a language server.
      -- Invoked by <enter> in normal mode (see lua/nvim/remap.lua).
      'stevearc/conform.nvim',
      event = 'BufWritePre',
      cmd = 'ConformInfo',
      opts = {
         formatters_by_ft = {
            lua = { 'stylua' },
            python = { 'isort', 'black' },

            javascript = { 'prettierd' },
            javascriptreact = { 'prettierd' },
            typescript = { 'prettierd' },
            typescriptreact = { 'prettierd' },
            css = { 'prettierd' },
            scss = { 'prettierd' },
            html = { 'prettierd' },
            json = { 'prettierd' },
            jsonc = { 'prettierd' },
            yaml = { 'prettierd' },
            markdown = { 'prettierd' },

            -- sql is deliberately absent: sqlfmt is run on demand with <leader>s.
         },
         -- Fall back to the LSP formatter for filetypes with no formatter above.
         -- 1s (conform's default) isn't enough for a cold `black`.
         default_format_opts = { lsp_format = 'fallback', timeout_ms = 4000 },
      },
   },
}
