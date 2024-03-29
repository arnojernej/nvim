if vim.g.vscode then

	function ColorMyPencils(color)
		vim.api.nvim_set_hl(0, "CurSearch", { fg = "#3b4252", bg = "#88c0d0"})
	end

else

	function ColorMyPencils(color)
		color = color or "nord"
		vim.cmd.colorscheme(color)

		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

		vim.api.nvim_set_hl(0, "Search", { bg = "#4c566a"})
		vim.api.nvim_set_hl(0, "IncSearch", { bg = "#4c566a"})
		vim.api.nvim_set_hl(0, "CurSearch", { fg = "#3b4252", bg = "#88c0d0"})

		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

		vim.api.nvim_set_hl(0, "@tag.tsx", { fg = "#81a1c1"}) -- blue
		vim.api.nvim_set_hl(0, "@tag.delimiter.tsx", { fg = "#81a1c1"}) -- blue
		vim.api.nvim_set_hl(0, "@constructor.tsx", { fg = "#88c0d0"}) -- lightblue
		vim.api.nvim_set_hl(0, "@tag.attribute.tsx", { fg = "#88c0d0"}) -- lightblue
	end

end

ColorMyPencils()