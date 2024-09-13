vim.keymap.set('n', '<leader>x', ":w<cr>:term dbt run --select %<cr>", { silent = false })
