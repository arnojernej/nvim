if vim.g.vscode then

  vim.cmd([[
    set shadafile=NONE
  ]])

end

if vim.g.vscode then
  require("vscode")
else

  if vim.fn.has('win32') == 1 then
    vim.cmd([[
      set shadafile=C:/Temp/shada
    ]])
  end

  vim.cmd([[

    augroup nord-theme-overrides
    autocmd!
    " Use 'nord7' as foreground color for Vim comment titles.
    autocmd ColorScheme nord highlight Comment gui=italic
    augroup END

  ]])

  require("nvim")

  -- [[ PLAYGROUND ]]

  local builtin = require('telescope.builtin')

  vim.keymap.set('n', '<leader>ps', function()
    local search = vim.fn.input("Grep: ")
    builtin.live_grep({ search = search })
    -- vim.cmd([[normal: /test]])
  end)

end

--  TODO: folds and foldmaker
