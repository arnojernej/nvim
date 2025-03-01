return {

   'tpope/vim-sleuth',
   -- "tpope/vim-repeat",
   -- "tpope/vim-surround",
   -- 'tpope/vim-rhubarb',

   'mtdl9/vim-log-highlighting',

   {
      'ethanholz/nvim-lastplace',
      opts = {
         lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
         lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
         lastplace_open_folds = true,
      },
   },

   {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      opts = {}, -- this is equalent to setup({}) function
   },

   { 'windwp/nvim-ts-autotag', opts = {} },

   {
      'folke/ts-comments.nvim',
      opts = {},
      event = 'VeryLazy',
      enabled = vim.fn.has 'nvim-0.10.0' == 1,
   },
}
