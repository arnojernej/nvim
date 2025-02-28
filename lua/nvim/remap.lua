-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.keymap.set("n", "<enter>", ":w<cr>", { silent = true })
vim.keymap.set("x", "<enter>", "<esc>:w<cr>", { silent = true })

-- Remap Enter in Quickfix window to open the selected entry, again
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<CR>", { noremap = true, silent = true })
	end,
})

-- Quickfix jumping
vim.keymap.set("n", "gn", ":cnext<cr>", { silent = true })
vim.keymap.set("n", "gN", ":cprev<cr>", { silent = true })

vim.keymap.set("n", "gq", ":copen<cr>", { silent = true })

vim.keymap.set("n", "<esc>", ":nohlsearch<cr>", { silent = true })
vim.keymap.set("n", "*", "*N", { silent = true })

vim.keymap.set("n", "<leader>b", ":b#<cr>", { silent = true })
vim.keymap.set("n", "K", ":bd<cr>", { silent = true })
-- vim.keymap.set('n', '<C-K>', ':bd<cr>', { silent = true })

vim.keymap.set("n", ".", ".`[", { silent = true })
vim.keymap.set("x", ".", ":'<,'>normal .<cr>", { silent = true })

vim.keymap.set("n", "Q", "@q", { silent = true })
vim.keymap.set("x", "Q", ":'<,'>normal @q<cr>", { silent = true })

-- toggle comments
vim.cmd([[
   nmap <leader>/ gcc
   vmap <leader>/ gc
]])

-- Tap indent in visual mode
vim.keymap.set("x", "<tab>", ">gv", { silent = true })
vim.keymap.set("x", "<s-tab>", "<gv", { silent = true })

if vim.fn.has("win32") == 1 then
	vim.keymap.set(
		"v",
		"<leader>s",
		":%!C:\\3_REPO_LOCAL\\DBeaver_sqlfmt\\bin\\Release\\net8.0\\DBeaver_sqlfmt.exe<cr>",
		{ silent = true }
	)
else
	vim.keymap.set("v", "<leader>s", ":%!sqlfmt - 2>/dev/null<cr>", { silent = true })
end

-- Fold 1 level
vim.keymap.set("n", "<F13>", ":%foldc<cr>", { silent = true })

vim.keymap.set("n", "<C-g>", "<cmd>silent !tmux neww ~/.local/scripts/tmux-sessionizer<CR>")

vim.keymap.set("n", "<C-p>", "{", { silent = false })
vim.keymap.set("n", "<C-n>", "}", { silent = false })

vim.keymap.set("n", "<C-f>", "<nop>", { silent = true })

-- local group = vim.api.nvim_create_augroup("markdown_autocommands", { clear = true })
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*",
--   callback = function(ev)
--     -- actual mapping
--     vim.keymap.set('n', '<C-p>', '{', { silent = false })
--     vim.keymap.set('n', '<C-n>', '}', { silent = false })
--   end,
--   group = group
-- })
--

-- Ctrl-hjkl for windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })
