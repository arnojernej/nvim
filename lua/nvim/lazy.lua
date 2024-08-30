local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
   }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
   -- NOTE: First, some plugins that don't require any configuration

   -- Git related plugins
   'tpope/vim-fugitive',
   -- 'tpope/vim-rhubarb',

   'github/copilot.vim',

   -- Detect tabstop and shiftwidth automatically
   'tpope/vim-sleuth',

   'tpope/vim-repeat',
   'tpope/vim-surround',

   'mtdl9/vim-log-highlighting',

   -- Set dir to current root
   'airblade/vim-rooter',

   -- { 'ethanholz/nvim-lastplace', opts = {} },

   {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      opts = {} -- this is equalent to setup({}) function
   },

   { 'windwp/nvim-ts-autotag', opts = {} },

   {
      'kevinhwang91/nvim-ufo',
      dependencies = { 'kevinhwang91/promise-async' }
   },

   {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
         -- your configuration comes here
         -- or leave it empty to use the default settings
         -- refer to the configuration section below
         signs = false
      }
   },

   -- NOTE: This is where your plugins related to LSP can be installed.
   --  The configuration is done below. Search for lspconfig to find it below.
   {
      -- LSP Configuration & Plugins
      'neovim/nvim-lspconfig',
      dependencies = {
         -- Automatically install LSPs to stdpath for neovim
         { 'williamboman/mason.nvim', config = true },
         'williamboman/mason-lspconfig.nvim',

         -- Useful status updates for LSP
         -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
         { 'j-hui/fidget.nvim', tag = 'legacy', opts = {
            window = {
               blend = 0,
            }
         } },

         -- Additional lua configuration, makes nvim stuff amazing!
         'folke/neodev.nvim',
      },
   },

   {
      -- Autocompletion
      'hrsh7th/nvim-cmp',
      dependencies = {
         -- Snippet Engine & its associated nvim-cmp source
         'L3MON4D3/LuaSnip',
         'saadparwaiz1/cmp_luasnip',

         -- Adds LSP completion capabilities
         'hrsh7th/cmp-nvim-lsp',

         'hrsh7th/cmp-nvim-lua',
         'hrsh7th/cmp-buffer',
         'hrsh7th/cmp-path',

         -- Adds a number of user-friendly snippets
         'rafamadriz/friendly-snippets',
      },
   },

   -- Useful plugin to show you pending keybinds.
   -- { 'folke/which-key.nvim', opts = {} },

   {
      -- Adds git releated signs to the gutter, as well as utilities for managing changes
      'lewis6991/gitsigns.nvim',
      opts = {
         on_attach = function(bufnr)
            vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
            vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
            vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
         end,
      },
   },

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
      },
   },

   {
      -- color theme
      'kaiuri/nvim-juliana',
      lazy = false,
      opts = { --[=[ configuration --]=] },
      config = true,
   },

   { 'shaunsingh/nord.nvim' },

   {
      "rose-pine/neovim", name = "rose-pine",
      opts = {
         styles = {
            transparency = true,
         },
         highlight_groups = {
            TelescopeBackground = { bg = "none" },
            TelescopeBorder = { fg = "highlight_high", bg = "none" },
            TelescopeNormal = { bg = "none" },
            TelescopePromptNormal = { bg = "none" },
            TelescopeResultsNormal = { fg = "subtle", bg = "none" },
            TelescopeSelection = { fg = "text", bg = "none" },
            TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
            CurSearch = { fg = "base", bg = "rose", inherit = false },
            Search = { bg = "rose", blend = 20, inherit = false },
         },
      }
   },

   {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
   },

   {
      -- Add indentation guides even on blank lines
      'lukas-reineke/indent-blankline.nvim',
      -- Enable `lukas-reineke/indent-blankline.nvim`
      -- See `:help indent_blankline.txt`
      main = "ibl",
      remove_blankline_trail = false,
      opts = {
         scope = { enabled = false },
         indent = {
            char = '│',
         },
      },
   },

   -- Fuzzy Finder (files, lsp, etc)
   { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

   -- Fuzzy Finder Algorithm which requires local dependencies to be built.
   -- Only load if `make` is available. Make sure you have the system
   -- requirements installed.
   {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
         return vim.fn.executable 'make' == 1
      end,
   },

   {
      "folke/trouble.nvim",
      -- dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {
         -- your configuration comes here
         -- or leave it empty to use the default settings
         -- refer to the configuration section below
      },
   },

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
         }
      } -- this is equalent to setup({}) function
   },
   'nvim-treesitter/playground',

   {
      'kaiuri/nvim-juliana',
      lazy = false,
      opts = { --[=[ configuration --]=] },
      config = true,
   },

   {
      "folke/ts-comments.nvim",
      opts = {},
      event = "VeryLazy",
      enabled = vim.fn.has("nvim-0.10.0") == 1,
   },

   {
      'nvimtools/none-ls.nvim',
      dependencies = { "nvim-lua/plenary.nvim" },
   }

   -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
   --       These are some example plugins that I've included in the kickstart repository.
   --       Uncomment any of the lines below to enable them.
   -- require 'kickstart.plugins.autoformat',
   -- require 'kickstart.plugins.debug',

   -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
   --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
   --    up-to-date with whatever is in the kickstart repo.
   --
   --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
   --

   -- { import = 'plugin' },
}, {})
