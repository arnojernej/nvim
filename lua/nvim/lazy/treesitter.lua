return {
   {
      -- Highlight, edit, and navigate code (main-branch rewrite, Neovim 0.12+)
      'nvim-treesitter/nvim-treesitter',
      branch = 'main',
      lazy = false,
      build = ':TSUpdate',
      dependencies = {
         { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
      },
      config = function()
         local ts = require 'nvim-treesitter'

         ts.setup {}

         -- Parsers to keep installed. install() is async and a no-op for
         -- parsers that are already present.
         ts.install {
            'c',
            'cpp',
            'c_sharp',
            'lua',
            'python',
            'tsx',
            'typescript',
            'vim',
            'javascript',
            'html',
            'json',
            'markdown',
            'yaml',
            'css',
            'sql',
         }

         -- Highlighting and indentation are provided by Neovim itself on the
         -- main branch; enable them per-buffer for any filetype that has a
         -- parser available.
         vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('nvim_treesitter_start', { clear = true }),
            callback = function(args)
               if pcall(vim.treesitter.start, args.buf) then
                  vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
               end
            end,
         })

         -- Text objects (the textobjects module is its own setup + keymaps now)
         require('nvim-treesitter-textobjects').setup {
            select = {
               lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            },
            move = {
               set_jumps = true, -- whether to set jumps in the jumplist
            },
         }

         local select = require 'nvim-treesitter-textobjects.select'
         local swap = require 'nvim-treesitter-textobjects.swap'
         local move = require 'nvim-treesitter-textobjects.move'

         -- select
         for lhs, query in pairs {
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
         } do
            vim.keymap.set({ 'x', 'o' }, lhs, function()
               select.select_textobject(query, 'textobjects')
            end)
         end

         -- swap
         vim.keymap.set('n', '<leader>a', function()
            swap.swap_next '@parameter.inner'
         end)
         vim.keymap.set('n', '<leader>A', function()
            swap.swap_previous '@parameter.inner'
         end)

         -- move
         for lhs, query in pairs {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
         } do
            vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
               move.goto_next_start(query, 'textobjects')
            end)
         end
         for lhs, query in pairs {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
         } do
            vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
               move.goto_next_end(query, 'textobjects')
            end)
         end
         for lhs, query in pairs {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
         } do
            vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
               move.goto_previous_start(query, 'textobjects')
            end)
         end
         for lhs, query in pairs {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
         } do
            vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
               move.goto_previous_end(query, 'textobjects')
            end)
         end
      end,
   },
}
