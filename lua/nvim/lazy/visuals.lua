return {

   {
      -- Set lualine as statusline
      'nvim-lualine/lualine.nvim',
      -- See `:help lualine.txt`
      opts = {
         options = {
            icons_enabled = false,
            component_separators = '|',
            section_separators = '',
         },
         sections = {
            lualine_a = {},
            lualine_b = {
               {
                  'branch',
                  color = { gui = 'bold' },
               },
            },
            lualine_c = {
               {
                  'filename',
                  file_status = true,
                  newfile_status = true,
                  path = 1,
                  shorting_target = 40,
                  symbols = {
                     modified = '[+]',
                     readonly = '[-]',
                     unnamed = '[No Name]',
                     newfile = '[New]',
                  },
               },
               -- nvim 0.12 puts vim.diagnostic.status() in the default
               -- statusline; lualine replaces that, so put the counts back.
               {
                  'diagnostics',
                  symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
               },
            },
         },
      },
   },

   {
      'lukas-reineke/virt-column.nvim',
      opts = {
         char = '│',
      },
      init = function()
         local augroup = vim.api.nvim_create_augroup
         -- local ThePrimeagenGroup = augroup('ThePrimeagen', {})

         local autocmd = vim.api.nvim_create_autocmd
         local yank_group = augroup('HighlightYank', {})

         autocmd('TextYankPost', {
            group = yank_group,
            pattern = '*',
            callback = function()
               vim.hl.on_yank {
                  higroup = 'IncSearch',
                  timeout = 150,
               }
            end,
         })
      end,
   },

   {
      -- Add indentation guides even on blank lines
      'lukas-reineke/indent-blankline.nvim',
      -- Enable `lukas-reineke/indent-blankline.nvim`
      -- See `:help indent_blankline.txt`
      main = 'ibl',
      remove_blankline_trail = false,
      opts = {
         scope = { enabled = false },
         indent = {
            char = '│',
         },
      },
   },

   {
      'dstein64/nvim-scrollview',
      opts = {},
   },

   {
      'folke/todo-comments.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      opts = {
         signs = false,
      },
   },

   -- {
   --    'rachartier/tiny-inline-diagnostic.nvim',
   --    event = 'VeryLazy', -- Or `LspAttach`
   --    priority = 1000, -- needs to be loaded in first
   --    config = function()
   --       require('tiny-inline-diagnostic').setup {
   --          preset = 'classic',
   --          options = {
   --             multilines = {
   --                enabled = true,
   --                always_show = true,
   --             },
   --          },
   --       }
   --       vim.diagnostic.config { virtual_text = false } -- Only if needed in your configuration, if you already have native LSP diagnostics
   --    end,
   -- },

   -- {
   --    -- Folding
   --    'kevinhwang91/nvim-ufo',
   --    dependencies = { 'kevinhwang91/promise-async' },
   --    opts = {
   --       -- provider_selector = function(bufnr, filetype, buftype)
   --       --    return { 'treesitter', 'indent' }
   --       -- end,
   --    },
   --    init = function()
   --       vim.o.foldcolumn = '0' -- '0' is not bad
   --       vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
   --       vim.o.foldlevelstart = 99
   --       vim.o.foldenable = true
   --    end,
   -- },

   {
      'MeanderingProgrammer/render-markdown.nvim',
      -- nvim-web-devicons is already pulled in by oil/nvim-tree; the mini.nvim
      -- suite was ~40 modules loaded for an icon lookup.
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {},
   },
}
