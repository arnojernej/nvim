vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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
vim.o.completeopt = 'menuone,noselect,popup'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
-- vim.o.cursorline = true

vim.o.scrolloff = 2
vim.o.sidescrolloff = 3

vim.opt.colorcolumn = '80'
vim.opt.pumheight = 10
vim.o.pumborder = 'rounded'

-- Default border for every floating window (nvim 0.11+). Plugins that don't
-- hardcode a border (blink.cmp, lsp hover, diagnostic floats, ...) inherit it,
-- so it only needs to be set once.
vim.o.winborder = 'rounded'

vim.opt.statuscolumn = ' %=%l %s'

vim.opt.modeline = true

--vim.cmd 'language en_US'

vim.o.swapfile = false
vim.o.foldmethod = 'marker'

-- Only real, on-disk file buffers get a saved view. Without this guard nvim
-- writes view files for gitcommit/oil/help/... buffers, which is noise at best
-- and restores stale state at worst.
local function viewable(buf)
   return vim.bo[buf].buftype == ''
      and vim.bo[buf].modifiable
      and vim.api.nvim_buf_get_name(buf) ~= ''
      and not vim.tbl_contains({ 'gitcommit', 'gitrebase', 'hgcommit', 'svn', 'oil', 'help' }, vim.bo[buf].filetype)
end

local view_group = vim.api.nvim_create_augroup('remember_folds', { clear = true })

vim.api.nvim_create_autocmd('BufWinLeave', {
   group = view_group,
   pattern = '?*',
   callback = function(args)
      if args.buf == vim.api.nvim_get_current_buf() and viewable(args.buf) then
         vim.cmd 'silent! mkview 1'
      end
   end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
   group = view_group,
   pattern = '?*',
   callback = function(args)
      if viewable(args.buf) then
         vim.cmd 'silent! loadview 1'
      end
   end,
})

-- Restore the last cursor position for files without a saved view.
-- (Replaces nvim-lastplace, unmaintained since 2023.)
vim.api.nvim_create_autocmd('BufReadPost', {
   group = view_group,
   callback = function(args)
      if not viewable(args.buf) then
         return
      end
      local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
      if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
         pcall(vim.api.nvim_win_set_cursor, 0, mark)
         vim.cmd 'silent! normal! zv'
      end
   end,
})

vim.opt.fillchars:append { fold = ' ' }

-- local function paste()
--   return {
--     vim.fn.split(vim.fn.getreg '', '\n'),
--     vim.fn.getregtype '',
--   }
-- end
--
-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = require('vim.ui.clipboard.osc52').copy '+',
--     ['*'] = require('vim.ui.clipboard.osc52').copy '*',
--   },
--   paste = {
--     ['+'] = paste,
--     ['*'] = paste,
--   },
-- }
--return
