syntax enable
filetype plugin on

set title
set spell spelllang=en_us
set mouse=a
set path+=~/src/**
set wildignore+=**/build/**,*.class,*.o,*.obj,*.jar,*.zip,*.?gz
set tags=~/.cache/tags
set completeopt=menu,preview,noinsert " don't automatically insert completion
set ts=4 sts=4 sw=4     " make tabs 4 spaces
set expandtab
set nowrap              " don't wrap long lines
set hlsearch            " highlight search results set incsearch           " incremental search
set ignorecase          " ignore case when searching
set smartcase           " override ignorecase for mixed-case searches
set showmatch           " show matching brackets
set number
set hidden              " allow dirty buffers to be hidden
set termguicolors       " 24-bit colors
set background=light
colorscheme solarized8
set splitbelow          " default split layout
set splitright
set clipboard=unnamedplus " yank to '+' register

" If rg is available use it for grep command
" Remap K to grep the word currently under the cursor
if executable('rg')
    set grepprg=rg\ --vimgrep
endif

nmap <F1> :vert help<CR>
nmap <F2> :split<CR>
nmap <F3> :vsplit<CR>
nmap <F4> :vsplit<CR>:term<CR><ESC>:setlocal nospell<CR>a
nmap <F5> :set hlsearch!<CR>
nmap <F6> :set hlsearch<CR>viw"qy/<C-r>q<CR>
nmap <F7> :grep! "\b<C-r><C-w>\b"<CR>:cw<CR><CR>:setlocal nospell<CR>
nmap <F9> :NERDTreeToggle<CR>
nmap <F11> :BD<CR>
nmap <F12> <C-W>c

set pastetoggle=<F10>

nmap <S-F5> :setlocal spell! spelllang=en_us<CR>
nmap <S-F7> :vsplit<CR><F7>
nmap <S-F11> :BD<CR><C-W>c
nmap <S-F12> :qa<CR>

nmap <leader>t :tabnew<CR>
nmap <leader>c :tabclose<CR>
nmap <leader>n :tabnext<CR>
nmap <leader>p :tabprev<CR>

" Buffer navigation
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>

" Toggle search highlighting
" Search the current file for the word under the cursor
" Remap / to enable highlighting again before searching
nnoremap / :set hlsearch<CR>/

" Allow esc to exit insert mode in :term, note this clobbers the ability to
" press the esc key
tnoremap <Esc> <C-\><C-n>

command! MakeTags !ctags -f ~/.cache/tags -R ~/src

au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

let g:netrw_banner=0            " hide banner
let g:netrw_browser_split=4     " open in prior window
let g:netrw_liststyle=3         " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeIgnore=['^build$[[dir]]']
let g:NERDTreeWinSize=60

"let &shell='/usr/local/bin/bash --login'
