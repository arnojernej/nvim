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
}
