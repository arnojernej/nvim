local builtin = require('telescope.builtin')
local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
    preview = {
      hide_on_startup = true
    },
    file_ignore_patterns = {
      "venv",
      "bin",
      "obj",
      "node_modules",
    }
  },
})

vim.keymap.set('n', '<leader>r', builtin.oldfiles, {})
-- vim.keymap.set('n', '<leader>p', builtin.find_files, {})

vim.keymap.set("n", "<Leader>p", 
  function()
    local opts = {} -- define here if you want to define something
    vim.fn.system('git rev-parse --is-inside-work-tree')
    if vim.v.shell_error == 0 then
      require"telescope.builtin".git_files(opts)
    else
      require"telescope.builtin".find_files(opts)
    end
  end
  , {noremap = true, silent = true})
