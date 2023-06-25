vim.g.mapleader = ','
vim.g.maplocalleader = ','

require("jernejar.lazy")
require("jernejar.map")
require("jernejar.set")

-- local augroup = vim.api.nvim_create_augroup
-- local ThePrimeagenGroup = augroup('ThePrimeagen', {})

local autocmd = vim.api.nvim_create_autocmd
-- local yank_group = augroup('HighlightYank', {})

-- autocmd('TextYankPost', {
--     group = yank_group,
--     pattern = '*',
--     callback = function()
--         vim.highlight.on_yank({
--             higroup = 'IncSearch',
--             timeout = 40,
--         })
--     end,
-- })

autocmd({"BufWritePre"}, {
    -- group = ThePrimeagenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

