-- Enable word wrapping at 80 characters
vim.opt_local.textwidth = 80
vim.opt_local.wrap = true
vim.opt_local.linebreak = true

-- Auto-trigger file picker after @ in markdown files
vim.keymap.set('i', '@', function()
   -- Save cursor position while still in insert mode
   local saved_row, saved_col = unpack(vim.api.nvim_win_get_cursor(0))

   require('telescope.builtin').find_files({
      prompt_title = "@ File Reference",
      attach_mappings = function(_, map)
         local actions = require('telescope.actions')
         local action_state = require('telescope.actions.state')

         map('i', '<CR>', function(prompt_bufnr)
            local entry = action_state.get_selected_entry()
            actions.close(prompt_bufnr)

            if entry then
               local path = vim.fn.fnamemodify(entry.path, ':.')
               vim.schedule(function()
                  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                  local line = vim.api.nvim_get_current_line()

                  -- Use saved position from insert mode
                  local insert_pos = saved_col
                  local text = '@' .. path .. ' '
                  local new_line = line:sub(1, insert_pos) .. text .. line:sub(insert_pos + 1)

                  vim.api.nvim_set_current_line(new_line)

                  -- Position cursor after the inserted text
                  vim.api.nvim_win_set_cursor(0, {row, insert_pos + #text - 1})
                  vim.cmd('startinsert!')
               end)
            end
         end)

         -- If cancelled, do nothing (no @ was inserted)
         map('i', '<ESC>', function(prompt_bufnr)
            actions.close(prompt_bufnr)
         end)

         return true
      end
   })
end, { buffer = true, desc = 'Insert @ and trigger file picker' })

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
