runtime! debian.vim

" Plugin management. This must run first to load all plugins before they can
" be configured.
call plug#begin('~/.vim/plugged')
	" Light & Dark Vim color schemes inspired by Google's Material Design
	" https://github.com/NLKNguyen/papercolor-theme
	Plug 'NLKNguyen/papercolor-theme'

	" Highlights trailing whitespace in red and provides :FixWhitespace to fix it.
	" https://github.com/bronson/vim-trailing-whitespace
	Plug 'bronson/vim-trailing-whitespace'

	" A tree explorer plugin for vim.
	" https://github.com/scrooloose/nerdtree
	Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

	" Active fork of kien/ctrlp.vim—Fuzzy file, buffer, mru, tag, etc finder.
	" https://github.com/ctrlpvim/ctrlp.vim
	Plug 'ctrlpvim/ctrlp.vim'

	" lean & mean status/tabline for vim that's light as air
	" https://github.com/vim-airline/vim-airline
	Plug 'vim-airline/vim-airline'

	" A collection of themes for vim-airline
	" https://github.com/vim-airline/vim-airline-themes
	Plug 'vim-airline/vim-airline-themes'

	" Vim plugin that displays tags in a window, ordered by scope
	" https://github.com/majutsushi/tagbar
	Plug 'majutsushi/tagbar'

	" Yaml plugin. Useful when writing Ansible playbooks.
	Plug 'avakhov/vim-yaml'
call plug#end()

" Syntax highlighting
syntax on
set t_Co=256		" Set total number of colors (256)
set background=dark	" Set terminal background
try
	colorscheme default
catch
endtry

" Good settings
set showmatch		" Show matching brackets
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set mouse=n		" Enable mouse normal mode only
set number		" Turn on line numbers
set textwidth=0		" Disable automatic hard line wrapping
set autoindent          " Smart indenting
"set wrap linebreak nolist " Set automatic soft line wrapping
set nowrap
" Correct tab settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab


" Mark everything past column 80 in a different color
if (exists('+colorcolumn'))
	"set colorcolumn=81
	"highlight ColorColumn ctermbg=250
	"highlight ColorColumn ctermbg=15
	"let &colorcolumn=join(range(81,999),",")

endif

" NERDTree settings
map <C-n> :NERDTreeToggle<CR>
" autocmd vimenter * NERDTree		" Automatically open on vim start

" pu keybindings
map <C-u><C-y> :!pu push %<CR>
map <C-u><C-d> :!pu pull %<CR>

" Settings for vim-airline
set laststatus=2			" Show airline statusline
let g:airline_powerline_fonts = 1 	" Automatically populate the correct glyphs and symbols dictionary
let g:airline#extensions#tabline#enabled = 1	" Show buffers as tabs
let g:airline_theme='papercolor'	" Change airline theme
