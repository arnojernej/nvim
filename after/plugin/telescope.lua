if not vim.g.vscode then
   -- [[ Configure Telescope ]]
   -- See `:help telescope` and `:help telescope.setup()`
   --
   local builtin = require('telescope.builtin')
   local actions = require("telescope.actions")
   require('telescope').setup {
      defaults = {
         mappings = {
            i = {
               ["<esc>"] = actions.close,
               ['<C-u>'] = false,
               ['<C-d>'] = false,
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
         },
      },
   }

   -- Enable telescope fzf native, if installed
   pcall(require('telescope').load_extension, 'fzf')

   -- See `:help telescope.builtin`
   vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
   -- vim.keymap.set('n', '<leader>/', function()
   --    -- You can pass additional configuration to telescope to change theme, layout, etc.
   --    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
   --       winblend = 10,
   --       previewer = false,
   --    })
   -- end, { desc = '[/] Fuzzily search in current buffer' })

   vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
   vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
   vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
   vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
   vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
   vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
   
   vim.keymap.set('n', '<leader>r', builtin.oldfiles, {})
   -- vim.keymap.set('n', '<leader>p', builtin.find_files, {})

   vim.keymap.set("n", "<Leader>p",
      function()
         local opts = {} -- define here if you want to define something
         vim.fn.system('git rev-parse --is-inside-work-tree')
         if vim.v.shell_error == 0 then
            builtin.git_files(opts)
         else
            builtin.find_files(opts)
         end
      end
      , {noremap = true, silent = true}
   )
end
