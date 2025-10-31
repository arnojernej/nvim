return {

   -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },

   {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = {
         'nvim-lua/plenary.nvim',
         { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
      },
      config = function()
         local builtin = require 'telescope.builtin'
         local actions = require 'telescope.actions'
         local action_state = require 'telescope.actions.state'

         require('telescope').setup {

            pickers = {
               find_files = {
                  find_command = { "fdfind", "--type", "f", "-L", "--hidden" },
               },
               git_branches = {
                  mappings = {
                     i = { ['<cr>'] = actions.git_switch_branch },
                  },
               },
               oldfiles = {
                  cwd_only = true,
               },
            },

            defaults = {
               show_line = false,

               path_display = { 'truncate' }, -- Truncate long file paths

               layout_config = {
                  width = 0.9999,
                  height = 0.9,
                  preview_cutoff = 120,
                  horizontal = {
                     preview_width = 0.5,
                  },
                  vertical = {
                     preview_height = 0.5,
                  },
               },

               mappings = {
                  i = {
                     ['<ESC>'] = actions.close,
                     ['<cr>'] = function(prompt_bufnr)
                        actions.smart_send_to_qflist(prompt_bufnr)

                        local entry = action_state.get_selected_entry()

                        if entry then
                           if entry.filename then
                              vim.cmd('edit ' .. vim.fs.normalize(entry.filename))
                           end

                           if entry.col and entry.lnum then
                              vim.fn.setpos('.', { 0, entry.lnum, entry.col, 0 })
                           end
                        end
                     end,
                     ['<C-u>'] = false,
                     ['<C-d>'] = false,
                  },
               },
               file_ignore_patterns = {
                  'venv',
                  'bin',
                  'obj',
                  'node_modules',
               },
            },
         }

         require('telescope').load_extension 'fzf'

         -- Enable extensions
         -- pcall(require('telescope').load_extension 'fzf')

         -- See `:help telescope.builtin`
         -- vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })

         -- vim.keymap.set('n', '<leader>/', function()
         --    -- You can pass additional configuration to telescope to change theme, layout, etc.
         --    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
         --       winblend = 10,
         --       previewer = false,
         --    })
         -- end, { desc = '[/] Fuzzily search in current buffer' })

         -- vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
         vim.keymap.set('n', '<leader>g', builtin.git_branches, { desc = '' })
         vim.keymap.set('n', '<leader>p', function()
            builtin.find_files()
         end, { desc = '[S]earch [F]iles' })
         vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
         vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
         vim.keymap.set('n', '<leader>f', builtin.live_grep, { desc = '[S]earch by [G]rep' })
         vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

         vim.keymap.set('n', '<leader>r', function()
            builtin.oldfiles()
         end, {})
         -- vim.keymap.set('n', '<leader>r', ":Telescope frecency<cr>", {})
         vim.keymap.set('n', '<leader>p', function()
            builtin.find_files()
         end, {})

         -- vim.keymap.set("n", "<Leader>p",
         --    function()
         --       local opts = {} -- define here if you want to define something
         --       vim.fn.system('git rev-parse --is-inside-work-tree')
         --       if vim.v.shell_error == 0 then
         --          builtin.git_files(opts)
         --       else
         --          builtin.find_files(opts)
         --       end
         --    end
         --    , {noremap = true, silent = true}
         -- )
      end,
   },
}
