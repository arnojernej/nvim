vim.keymap.set("n", "<leader>x", ":w<cr>:cd .<cr>:term dbt run --select %<cr>", { silent = false })
