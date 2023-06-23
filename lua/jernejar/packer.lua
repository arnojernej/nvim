-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	-- Git related plugins
	use 'tpope/vim-fugitive'
	use 'tpope/vim-rhubarb'
	use 'tpope/vim-surround'

	-- Detect tabstop and shiftwidth automatically
	use 'tpope/vim-sleuth'

	use 'windwp/nvim-autopairs'

	-- Visual
	use 'lukas-reineke/indent-blankline.nvim'
	use 'lewis6991/gitsigns.nvim'
	use 'sakshamgupta05/vim-todo-highlight'
	use 'xiyaowong/nvim-transparent'

	use({
		'shaunsingh/nord.nvim',
		as = 'nord',
		config = function()
			vim.cmd('colorscheme nord')
		end
	})

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		}
	}

end)
