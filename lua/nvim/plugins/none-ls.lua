return {
    {
        'nvimtools/none-ls.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
            local null_ls = require 'null-ls'

            null_ls.setup {

                sources = {
                    null_ls.builtins.formatting.prettierd,
                    -- python
                    null_ls.builtins.formatting.black.with {
                        -- extra_args = { "--line-length=120" }
                    },
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.stylua,
                },
            }
        end,
    },
}
