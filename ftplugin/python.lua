function RunPythonInSplit()
   local cur_win = vim.api.nvim_get_current_win()
   local term_buf = _G.python_term_buf

   if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
      -- Look for an existing window showing our terminal buffer.
      local term_win = nil
      for _, win in ipairs(vim.api.nvim_list_wins()) do
         if vim.api.nvim_win_get_buf(win) == term_buf then
            term_win = win
            break
         end
      end
      -- If the terminal isn’t visible, open it in a new split.
      if not term_win then
         vim.cmd 'botright 10split'
         term_win = vim.api.nvim_get_current_win()
         vim.api.nvim_win_set_buf(term_win, term_buf)
         vim.api.nvim_win_set_option(term_win, 'number', false)
         vim.api.nvim_win_set_option(term_win, 'relativenumber', false)
      end
      local term_job_id = vim.api.nvim_buf_get_var(term_buf, 'terminal_job_id')
      if term_job_id then
         -- Interrupt any running process, clear the terminal, and run the Python file.
         vim.fn.chansend(term_job_id, '\x03')
         vim.fn.chansend(term_job_id, 'clear\n')
         vim.fn.chansend(term_job_id, 'python ' .. vim.fn.expand '%:p' .. '\n')
      end
      -- Return focus to your editing window.
      vim.api.nvim_set_current_win(cur_win)
   else
      -- No terminal exists yet: create one.
      vim.cmd 'botright 10split'
      local term_win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_option(term_win, 'number', false)
      vim.api.nvim_win_set_option(term_win, 'relativenumber', false)
      term_buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_win_set_buf(term_win, term_buf)
      _G.python_term_buf = term_buf

      local shell = vim.o.shell
      local term_job_id = vim.fn.termopen(shell)
      vim.api.nvim_buf_set_var(term_buf, 'terminal_job_id', term_job_id)
      vim.cmd 'file __python_run__'
      -- Defer sending the command so the shell has time to initialize.
      vim.defer_fn(function()
         vim.fn.chansend(term_job_id, 'python ' .. vim.fn.expand '%:p' .. '\n')
         local last_line = vim.api.nvim_buf_line_count(term_buf)
         vim.api.nvim_win_set_cursor(term_win, { last_line, 0 })
      end, 100)
      vim.api.nvim_set_current_win(cur_win)
   end
end

-- vim.keymap.set('n', '<leader>x', ':w<cr>:term python3 %<cr>', { silent = false })
vim.keymap.set('n', '<leader>x', ':w<cr>:! python3 %<cr>', { silent = false })
-- vim.api.nvim_set_keymap('n', '<leader>x', ':w<CR>:lua RunPythonInSplit()<CR>', { noremap = true, silent = true })
