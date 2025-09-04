return {

   {
      'zbirenbaum/copilot.lua',
      cmd = 'Copilot',
      build = ':Copilot auth',
      event = 'InsertEnter',
      config = function()
         require('copilot').setup {
            suggestion = {
               enabled = true,
               auto_trigger = true,
               keymap = {
                  accept = '<tab>',
                  next = '<M-]>',
                  prev = '<M-[>',
               },
            },
            panel = { enabled = false },
            filetypes = {
               markdown = true,
               help = true,
            },
         }
      end,
   },

   -- {
   --    'github/copilot.vim',
   -- },

   -- {
   --    'olimorris/codecompanion.nvim',
   --    opts = {
   --       strategies = {
   --          chat = {
   --             adapter = {
   --                name = 'copilot',
   --                model = 'claude-sonnet-4',
   --             },
   --          },
   --       },
   --    },
   --    dependencies = {
   --       'nvim-lua/plenary.nvim',
   --       'nvim-treesitter/nvim-treesitter',
   --    },
   -- },

   -- {
   --    'CopilotC-Nvim/CopilotChat.nvim',
   --    dependencies = {
   --       { 'nvim-lua/plenary.nvim', branch = 'master' },
   --    },
   --    build = 'make tiktoken',
   --    opts = {
   --       -- See Configuration section for options
   --       --ClaudeCode
   --       model = 'claude-sonnet-4', -- AI model to use
   --       temperature = 0.1, -- Lower = focused, higher = creative
   --       window = {
   --          layout = 'horizontal', -- 'vertical', 'horizontal', 'float'
   --          -- hight = 0.5,           -- 50% of screen width
   --       },
   --       auto_insert_mode = true, -- Enter insert mode when opening
   --    },
   -- },

   -- {
   --    'yetone/avante.nvim',
   --    config = function()
   --       require("avante").setup({
   --          windows = {
   --             edit = {
   --                border = "rounded", -- Options: "single", "double", "rounded", "solid", "shadow"
   --                start_insert = true,
   --             },
   --             ask = {
   --                floating = true,
   --                border = "rounded",
   --                start_insert = true,
   --             },
   --          },
   --       })
   --    end,
   --
   --    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
   --    -- ⚠️ must add this setting! ! !
   --    build = vim.fn.has 'win32' ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' or
   --        'make',
   --    event = 'VeryLazy',
   --    version = false, -- Never set this value to "*"! Never!
   --    ---@module 'avante'
   --    ---@type avante.Config
   --    opts = {
   --       -- add any opts here
   --       -- this file can contain specific instructions for your project
   --       instructions_file = 'avante.md',
   --       -- for example
   --       provider = 'copilot',
   --       providers = {
   --          claude = {
   --             endpoint = 'https://api.anthropic.com',
   --             model = 'claude-sonnet-4-20250514',
   --             timeout = 30000, -- Timeout in milliseconds
   --             extra_request_body = {
   --                temperature = 0.75,
   --                max_tokens = 20480,
   --             },
   --          },
   --          copilot = {
   --             endpoint = 'https://api.githubcopilot.com',
   --             proxy = nil,
   --             allow_insecure = false,
   --             timeout = 10 * 60 * 1000, -- 10 minutes
   --             extra_request_body = {
   --                temperature = 0,
   --                max_completion_tokens = 1000000,
   --             },
   --             reasoning_effort = 'high',
   --             model = 'claude-sonnet-4', -- or "claude-3.5-sonnet" if you're using an earlier version
   --          },
   --       },
   --    },
   --    dependencies = {
   --       'nvim-lua/plenary.nvim',
   --       'MunifTanjim/nui.nvim',
   --       --- The below dependencies are optional,
   --       'echasnovski/mini.pick',         -- for file_selector provider mini.pick
   --       'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
   --       'hrsh7th/nvim-cmp',              -- autocompletion for avante commands and mentions
   --       'ibhagwan/fzf-lua',              -- for file_selector provider fzf
   --       'stevearc/dressing.nvim',        -- for input provider dressing
   --       'folke/snacks.nvim',             -- for input provider snacks
   --       'nvim-tree/nvim-web-devicons',   -- or echasnovski/mini.icons
   --       'zbirenbaum/copilot.lua',        -- for providers='copilot'
   --       {
   --          -- support for image pasting
   --          'HakonHarnes/img-clip.nvim',
   --          event = 'VeryLazy',
   --          opts = {
   --             -- recommended settings
   --             default = {
   --                embed_image_as_base64 = false,
   --                prompt_for_file_name = false,
   --                drag_and_drop = {
   --                   insert_mode = true,
   --                },
   --                -- required for Windows users
   --                use_absolute_path = true,
   --             },
   --          },
   --       },
   --       {
   --          -- Make sure to set this up properly if you have lazy=true
   --          'MeanderingProgrammer/render-markdown.nvim',
   --          opts = {
   --             file_types = { 'markdown', 'Avante' },
   --          },
   --          ft = { 'markdown', 'Avante' },
   --       },
   --    },
   -- },
}
