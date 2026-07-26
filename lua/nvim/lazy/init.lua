return {

   'tpope/vim-sleuth',
   'tpope/vim-repeat',
   'tpope/vim-surround',
   -- 'tpope/vim-rhubarb',

   'mtdl9/vim-log-highlighting',

   -- nvim-lastplace (unmaintained since 2023) is replaced by the cursor/view
   -- restore autocmds in lua/nvim/set.lua.

   {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      opts = {}, -- this is equalent to setup({}) function
   },

   -- nvim-ts-autotag is replaced by vim.lsp.linked_editing_range, enabled per
   -- client in lua/nvim/lazy/lsp.lua.

   {
      'folke/ts-comments.nvim',
      opts = {},
      event = 'VeryLazy',
      enabled = vim.fn.has 'nvim-0.10.0' == 1,
   },
}
