return {
   {
      -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
         'nvim-treesitter/nvim-treesitter-textobjects',
      },
      build = ':TSUpdate',
      opts = {
         autotag = {
            enable = true,
         },
      },
      config = function()
         require('nvim-treesitter.configs').setup {

            -- Add languages to be installed here that you want installed for treesitter
            ensure_installed = {
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
            },

            -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
            auto_install = false,

            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
               enable = true,
               keymaps = {
                  node_incremental = 'v',
                  node_decremental = 'V',
               },
            },
            textobjects = {
               select = {
                  enable = true,
                  lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                  keymaps = {
                     -- You can use the capture groups defined in textobjects.scm
                     ['aa'] = '@parameter.outer',
                     ['ia'] = '@parameter.inner',
                     ['af'] = '@function.outer',
                     ['if'] = '@function.inner',
                     ['ac'] = '@class.outer',
                     ['ic'] = '@class.inner',
                  },
               },
               move = {
                  enable = true,
                  set_jumps = true, -- whether to set jumps in the jumplist
                  goto_next_start = {
                     [']m'] = '@function.outer',
                     [']]'] = '@class.outer',
                  },
                  goto_next_end = {
                     [']M'] = '@function.outer',
                     [']['] = '@class.outer',
                  },
                  goto_previous_start = {
                     ['[m'] = '@function.outer',
                     ['[['] = '@class.outer',
                  },
                  goto_previous_end = {
                     ['[M'] = '@function.outer',
                     ['[]'] = '@class.outer',
                  },
               },
               swap = {
                  enable = true,
                  swap_next = {
                     ['<leader>a'] = '@parameter.inner',
                  },
                  swap_previous = {
                     ['<leader>A'] = '@parameter.inner',
                  },
               },
            },
         } -- this is equalent to setup({}) function

         -- require 'nvim-treesitter.parsers'.get_parser_configs().dbt = {
         --    install_info = {
         --       url = "https://github.com/dbt-labs/tree-sitter-jinja2",
         --       files = { "src/parser.c" },
         --       branch = "main",
         --    },
         --    filetype = "sql",
         -- }
      end,
   },
   'nvim-treesitter/playground',
}
