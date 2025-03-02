return {
   'tpope/vim-fugitive',
   init = function ()
      vim.g.fugitive_git_executable = 'git'

      -- Exit fugitive window with K
      vim.api.nvim_create_autocmd("FileType", {
         pattern = {"fugitiveblame", "fugitive"},
         callback = function()
            vim.api.nvim_buf_set_keymap(0, 'n', 'K', 'gq', { silent = true })
         end
      })

   end,
}
