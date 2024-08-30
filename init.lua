if vim.g.vscode then

  vim.cmd([[
    set shadafile=NONE
  ]])

end

if vim.g.vscode then
  require("code")
else

  if vim.fn.has('win32') == 1 then
    vim.cmd([[
      set shadafile=C:/Temp/shada
    ]])
  end

  vim.cmd([[

    set listchars=tab:»·,trail:·,extends:>,precedes:<,space:·

  set listchars=tab:\ \ ,eol:¬

  ]])

  require("nvim")

  -- [[ PLAYGROUND ]]

  -- local builtin = require('telescope.builtin')
  --
  -- vim.keymap.set('n', '<leader>ps', function()
  --   local search = vim.fn.input("Grep: ")
  --   builtin.live_grep({ search = search })
  --   -- vim.cmd([[normal: /test]])
  -- end)
  --
  vim.cmd([[

    let g:netrw_keepdir=0

  ]])

end
