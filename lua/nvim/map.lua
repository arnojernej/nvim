-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<enter>', ':w<cr>', { silent = true })
vim.keymap.set('x', '<enter>', '<esc>:w<cr>', { silent = true })
-- Remap Enter in Quickfix window to open the selected entry
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<CR>", { noremap = true, silent = true })
    end
})
vim.keymap.set('n', '<esc>', ':nohlsearch<cr>', { silent = true })
vim.keymap.set('n', '*', '*N', { silent = true })

vim.keymap.set('n', '<leader>b', ':b#<cr>', { silent = true })
vim.keymap.set('n', 'K', ':bd<cr>', { silent = true })

vim.keymap.set('n', '.', '.`[', { silent = true })
vim.keymap.set('x', '.', ":'<,'>normal .<cr>", { silent = true })

vim.keymap.set('n', 'Q', '@q', { silent = true })
vim.keymap.set('x', 'Q', ":'<,'>normal @q<cr>", { silent = true })

-- quickfix jumping
vim.keymap.set('n', 'gn', ':cnext<cr>', { silent = true })
vim.keymap.set('n', 'gN', ':cprev<cr>', { silent = true })

-- Tap indent in visual mode
vim.cmd([[
   autocmd VimEnter * xmap <tab> >gv
   autocmd VimEnter * xmap <s-tab> <gv

   " toggle comments
   nmap <leader>/ gcc
   vmap <leader>/ gc
]]
)

-- Exit fugitive window with K
vim.api.nvim_create_autocmd("FileType", {
   pattern = {"fugitiveblame", "fugitive"},
   callback = function()
      vim.api.nvim_buf_set_keymap(0, 'n', 'K', 'gq', { silent = true })
   end
})

-- Extract mails
vim.keymap.set('n', '<leader>x', 'V:s/; /;\\r/g<cr>^MggVG:sort<cr>', { silent = true })

-- Open file explorer
-- vim.keymap.set('n', '<leader>e', ':Explore<cr>', { silent = true })
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })

-- Toggle fold
vim.keymap.set('n', '<space>', 'za', { silent = true })

-- NvimTree
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    -- Close nvim-tree with ESC
    vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", ":NvimTreeClose<CR>", { noremap = true, silent = true })

  end
})
