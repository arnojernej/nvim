vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.keymap.set('n', '<enter>', ':w<cr>')
vim.keymap.set('n', '<esc><esc>', ':nohlsearch<cr>')
vim.keymap.set('n', '*', '*N')

vim.keymap.set('n', '<leader>b', ':b#<cr>')
vim.keymap.set('n', 'K', ':bd<cr>')

vim.keymap.set('n', '.', '.`[')
vim.keymap.set('x', '.', ":'<,'>normal .<cr>")

vim.keymap.set('n', 'Q', '@q')
vim.keymap.set('x', 'Q', ":'<,'>normal @q<cr>")
