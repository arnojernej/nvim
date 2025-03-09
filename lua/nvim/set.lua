vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.timeoutlen = 1500

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- disable for nvimtree
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.o.hlsearch = true
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true

vim.o.wrap = false

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
-- vim.o.updatetime = 50
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
-- vim.o.cursorline = true

vim.o.scrolloff = 2
vim.o.sidescrolloff = 3

vim.opt.colorcolumn = '80'
vim.opt.pumheight = 10

vim.opt.statuscolumn = '%=%l %s'

vim.opt.modeline = true

vim.cmd 'language en_US'

vim.cmd [[

set foldmethod=marker

augroup remember_folds
  autocmd!
  au BufWinLeave ?* mkview 1
  au BufWinEnter ?* silent! loadview 1
augroup END

]]
vim.opt.fillchars:append { fold = ' ' }
