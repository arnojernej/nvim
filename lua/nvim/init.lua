vim.g.mapleader = ','
vim.g.maplocalleader = ','

require("nvim.lazy")
require("nvim.map")
require("nvim.set")

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
