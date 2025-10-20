-- Markdown checkbox toggle for spacebar
vim.keymap.set('n', '<Space>', function()
   local line = vim.fn.getline('.')
   local linenum = vim.fn.line('.')

   -- Extract leading whitespace and the rest of the line
   local indent, rest = string.match(line, '^(%s*)(.*)$')

   -- Check if the line (after indentation) starts with '- '
   if string.sub(rest, 1, 2) == '- ' then
      local newline
      -- Check if it already has a checkbox
      if string.match(rest, '^- %[ %]') then
         -- Change [ ] to [x]
         newline = indent .. string.gsub(rest, '^- %[ %]', '- [x]', 1)
      elseif string.match(rest, '^- %[x%]') then
         -- Change [x] to [ ]
         newline = indent .. string.gsub(rest, '^- %[x%]', '- [ ]', 1)
      else
         -- Add checkbox after '- '
         newline = indent .. string.sub(rest, 1, 2) .. '[ ] ' .. string.sub(rest, 3)
      end
      vim.fn.setline(linenum, newline)
   end
end, { silent = true, buffer = true })
