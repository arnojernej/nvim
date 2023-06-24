vim.cmd([[

augroup nord-theme-overrides
  autocmd!
  " Use 'nord7' as foreground color for Vim comment titles.
  autocmd ColorScheme nord highlight Comment gui=italic
augroup END

]])

require("jernejar")

-- [[ PLAYGROUND ]]

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ps', function()
	local search = vim.fn.input("Grep: ")
	builtin.live_grep({ search = search })
	-- vim.cmd([[normal: /test]])
end)

--  TODO: folds and foldmaker
