syntax enable
filetype plugin on

set spell spelllang=en_us
set mouse=a
set path+=~/src/**
set wildignore+=**/build/**,*.class,*.o,*.obj,*.jar,*.zip,*.?gz
set tags=~/.cache/tags
set completeopt=menu,preview,noinsert " don't automatically insert completion
set ts=4 sts=4 sw=4     " make tabs 4 spaces
set expandtab
set nowrap              " don't wrap long lines
set hlsearch            " highlight search results
set incsearch           " incremental search
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

" If rg is available use it for grep command
" Remap K to grep the word currently under the cursor
if executable('rg')
    set grepprg=rg\ --vimgrep
    nnoremap K :grep! "\b<C-r><C-w>\b"<CR>:cw<CR><CR>
endif

" Split mappings
nnoremap ,v <C-w>v
nnoremap ,h <C-w>s

" Buffer navigation
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>

" BD plugin unloads a buffer without closing the window
nnoremap <C-c> :BD<CR>

" Searching
"
" Toggle search highlighting
nnoremap <F4> :set hlsearch!<CR>
" Search the current file for the word under the cursor
nnoremap <F5> :set hlsearch<CR>viw"qy/<C-r>q<CR>
" Remap / to enable highlighting again before searching
nnoremap / :set hlsearch<CR>/

nnoremap <F9> :NERDTree<CR>
nnoremap <F1> :vert help<CR>

nnoremap <F12> :qa<CR>

" Allow esc to exit insert mode in :term, note this clobbers the ability to
" press the esc key
tnoremap <Esc> <C-\><C-n>

command! MakeTags !ctags -f ~/.cache/tags -R ~/src

let g:netrw_banner=0            " hide banner
let g:netrw_browser_split=4     " open in prior window
let g:netrw_liststyle=3         " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeIgnore = ['^build$[[dir]]']
