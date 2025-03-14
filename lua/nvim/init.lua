if vim.fn.has 'win32' == 1 then
   vim.opt.shadafile = 'C:/Temp/shada'
end

require 'nvim.set'
require 'nvim.remap'
require 'nvim.lazy_init'
-- require 'nvim.snips'

vim.api.nvim_create_autocmd({ 'BufWritePre' }, { pattern = '*', command = [[%s/\s\+$//e]] })

vim.diagnostic.config {
   -- update_in_insert = true,
   float = {
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
   },
}
