let mapleader = ","
call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'shaunsingh/nord.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'numToStr/Comment.nvim'
Plug 'xiyaowong/nvim-transparent'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'notjedi/nvim-rooter.lua'

call plug#end()

lua require('gitsigns').setup()
lua require('lualine').setup()
lua require('nvim-autopairs').setup()
lua require('Comment').setup()
lua require('nvim-rooter').setup()

lua <<EOF
local cmp = require'cmp'
cmp.setup({
  sources = {
    { name = 'path' }
  }
})
local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
    preview = {
      hide_on_startup = true
    },
    file_ignore_patterns = {
      "venv"
    }
  },
})
EOF

let g:transparent_enabled = v:true

" Comment
nnoremap <silent><leader>/ <Plug>(comment_toggle_linewise_current)
xnoremap <silent><leader>/ <Plug>(comment_toggle_linewise_visual)

" Telescope
nnoremap <silent> <leader>r <cmd>Telescope oldfiles<cr>
nnoremap <silent> <leader>g <cmd>Telescope git_files<cr>
nnoremap <silent> <leader>t <cmd>Telescope find_files<cr>

nnoremap <silent> <leader>b :b#<cr>

nmap k gk
nmap j gj

nnoremap <silent>K :bd<cr>
map . .`[
nnoremap Q @q

nnoremap <silent> * eb:let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
nnoremap <esc><esc> :nohlsearch<cr>

nmap <silent> gn :cnext<cr>
nmap <silent> gN :cprev<cr>

nnoremap <silent> <cr> :w<cr>

" Tap indent in visual mode
autocmd VimEnter * xmap <tab> >gv
autocmd VimEnter * xmap <s-tab> <gv

" Jump to last cursor position unless it's invalid or in an event handler
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" No bell
autocmd VimEnter * set vb t_vb=

" quickfix jumping
nmap <silent> gn :cnext<cr>
nmap <silent> gN :cprev<cr>

colorscheme nord
set ignorecase
set smartcase
set nowrap
set clipboard=unnamed
set number
set tabstop=3
set signcolumn=yes

if has('win32')
  nnoremap <leader>ev :edit C:\Users\jernejar\AppData\Local\nvim\init.vim<cr>
else
  nnoremap <leader>ev :edit ~/.config/nvim/init.vim<cr>
endif
