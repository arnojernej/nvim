return {
	'mbbill/undotree',
	priority = 1000,
	config = function()
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
	end,
}

