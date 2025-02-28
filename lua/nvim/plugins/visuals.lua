return {

	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				component_separators = "|",
				section_separators = "",
			},
			sections = {
				lualine_a = {},
				lualine_b = {
					{
						"branch",
						color = { gui = "bold" },
					},
				},
				lualine_c = {
					{
						"filename",
						file_status = true,
						newfile_status = true,
						path = 1,
						shorting_target = 40,
						symbols = {
							modified = "[+]",
							readonly = "[-]",
							unnamed = "[No Name]",
							newfile = "[New]",
						},
					},
				},
			},
		},
	},

	{
		"lukas-reineke/virt-column.nvim",
		opts = {
			char = "│",
		},
		init = function()
			local augroup = vim.api.nvim_create_augroup
			-- local ThePrimeagenGroup = augroup('ThePrimeagen', {})

			local autocmd = vim.api.nvim_create_autocmd
			local yank_group = augroup("HighlightYank", {})

			autocmd("TextYankPost", {
				group = yank_group,
				pattern = "*",
				callback = function()
					vim.highlight.on_yank({
						higroup = "IncSearch",
						timeout = 150,
					})
				end,
			})
		end,
	},

	{
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		main = "ibl",
		remove_blankline_trail = false,
		opts = {
			scope = { enabled = false },
			indent = {
				char = "│",
			},
		},
	},

	{
		"petertriho/nvim-scrollbar",
		opts = {
			handle = {
				-- color ='#444e59',
				color = "#4c566a",
			},
			handlers = {
				cursor = false,
				diagnostic = true,
				gitsigns = true, -- Requires gitsigns
				handle = true,
			},
		},
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = false,
		},
	},

	{
		-- Folding
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		opts = {
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		},
		init = function()
			vim.o.foldcolumn = "0" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
		end,
	},
}
