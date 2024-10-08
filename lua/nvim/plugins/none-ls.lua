return {
   {
      'nvimtools/none-ls.nvim',
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()

         local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
         local null_ls = require("null-ls")

         null_ls.setup({

            sources = {
               null_ls.builtins.formatting.prettierd,
               -- python
               null_ls.builtins.formatting.black.with({
                  -- extra_args = { "--line-length=120" }
               }),
               --null_ls.builtins.formatting.isort,
            },

            on_attach = function(client, bufnr)
               if client.supports_method("textDocument/formatting") then
                  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                  vim.api.nvim_create_autocmd("BufWritePre", {
                     group = augroup,
                     buffer = bufnr,
                     callback = function()
                        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                        -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                        -- vim.lsp.buf.formatting_sync()
                        vim.lsp.buf.format({ async = false })
                     end,
                  })
               end
            end,

         })

      end

   },
}
