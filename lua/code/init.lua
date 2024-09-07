vim.o.shadafile = "NONE"

vim.g.mapleader = ','
vim.g.maplocalleader = ','

require("code.lazy")
require("code.map")
require("code.set")

local augroup = vim.api.nvim_create_augroup
-- local ThePrimeagenGroup = augroup('ThePrimeagen', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 150,
        })
    end,
})

autocmd({"BufWritePre"}, {
    -- group = ThePrimeagenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.cmd([[

function! FindInFiles(args)
  call VSCodeNotify('workbench.action.findInFiles', { 'query': a:args })
  call VSCodeNotify('search.action.focusSearchList')
endfunction

command! -nargs=* RG call FindInFiles(<q-args>)

highlight CurSearch guibg=#eeeeee

]])
