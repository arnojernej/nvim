require("jernejar")

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ml', 'V:s/; /;\r/g<cr>^MggVG:sort<cr>')

vim.keymap.set('n', '<leader>ps', function()
	local search = vim.fn.input("Grep: ")
	builtin.live_grep({ search = search })
	vim.cmd("/"+search)
end)

--  TODO: folds and foldmaker
