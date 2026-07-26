if vim.fn.has 'win32' == 1 then
   -- Keep shada on a local disk, but somewhere that is guaranteed to exist:
   -- C:/Temp is not present on a fresh machine, and stdpath('data') is
   -- %LOCALAPPDATA%\nvim-data, i.e. local rather than a roaming profile.
   local shada = vim.fs.joinpath(vim.fn.stdpath 'data', 'shada')
   vim.fn.mkdir(shada, 'p')
   vim.opt.shadafile = vim.fs.joinpath(shada, 'main.shada')
end

require 'nvim.set'
require 'nvim.remap'
require 'nvim.lazy_init'
-- require 'nvim.snips'

-- Strip trailing whitespace on save. `keeppatterns` keeps it out of the search
-- history (so `n` still repeats your last real search) and the view save/restore
-- keeps the cursor and scroll position put. Markdown is skipped: two trailing
-- spaces are a hard line break there.
vim.api.nvim_create_autocmd('BufWritePre', {
   pattern = '*',
   callback = function(args)
      -- Skip markdown, and skip buffers we can't edit (`:w` out of a
      -- checkhealth/help buffer would otherwise raise E21).
      if vim.bo[args.buf].filetype == 'markdown' or not vim.bo[args.buf].modifiable then
         return
      end
      local view = vim.fn.winsaveview()
      vim.cmd [[keeppatterns %s/\s\+$//e]]
      vim.fn.winrestview(view)
   end,
})

vim.diagnostic.config {
   -- update_in_insert = true,
   -- Diagnostics for the cursor line only, rendered below it. Swap for
   -- `virtual_text = true` to get the old one-per-line-at-end-of-line style.
   virtual_lines = { current_line = true },
   float = {
      focusable = false,
      style = 'minimal',
      -- border comes from 'winborder'
      source = true,
      header = '',
      prefix = '',
   },
}
