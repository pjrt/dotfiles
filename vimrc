"=============================================================
" Vundle
"============================================================

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-surround'
Bundle 'derekwyatt/vim-scala'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'klen/python-mode'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-abolish'
Bundle 'vim-scripts/AutoClose--Alves'
Bundle 'scrooloose/nerdcommenter'
Bundle 'mhinz/vim-startify'
Bundle 'kchmck/vim-coffee-script'
Bundle 'RelOps'
Bundle 'scrooloose/nerdtree'
Bundle 'Valloric/YouCompleteMe'
Bundle 'elzr/vim-json'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'sjl/gundo.vim'
"Bundle 'lukerandall/haskellmode-vim'
Bundle 'dag/vim2hs'
"Bundle 'Shougo/neocomplete.vim'
Bundle 'https://github.com/ujihisa/neco-ghc'
Bundle 'chrisbra/csv.vim'


set encoding=utf8
" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","
let maplocalleader = ","

" Add Fugitive info to the status bar
set statusline+=%{fugitive#statusline()}

" Make kj and jk to be <ESC>
inoremap kj <Esc>
inoremap jk <Esc>

" Gundo mapping
nnoremap <silent><Leader>p :GundoToggle<CR>

" Use ALL the colors!
set t_Co=256

" make ctrl+s be ctrl+a since c-a is used in screen
nnoremap <c-s> <c-a>

" Edit my vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Source my vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Make H and L be ^ and $
nnoremap H ^
nnoremap L $

" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F2>
set clipboard+=unnamed

" map operator p to i) (easy inner parameter selecting)
onoremap p i)
onoremap } i}
onoremap ] i]

" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again

" Bind nohl
" Removes highlight of your last search
nnoremap <silent><C-m> :nohl<CR>

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" easier moving between tabs
map <Leader>t <esc>:tabnew<CR>

" map sort function to a key
vnoremap <Leader>s :sort<CR>


" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Make Y behave correctly
nnoremap Y y$

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/


" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
color wombat256mod

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype plugin indent on
syntax enable

" Set line numbers
set nu

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap


" Useful settings
set history=700
set undolevels=700


" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab


" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Startify and ctrlP don't work well together without this
let g:ctrlp_reuse_window  = 'startify'

" ============================================================================
" Haskell-mode settings
" ============================================================================
"au BufEnter *.hs compiler ghc
"let g:haddock_browser="/usr/bin/google-chrome"
"nnoremap :g :GHCi 
"nnoremap :make :w<CR>:make<CR>

" ============================================================================
" vim2hs settings
" ============================================================================
au FileType haskell nnoremap <Leader>m :HLint<CR>
au FileType haskell setlocal omnifunc=necoghc#omnifunc


" ============================================================================
" Python IDE Setup
" ============================================================================


" Settings for vim-powerline
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
set laststatus=2


" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*.class,*.jar,*.iml,*.classpath,*/target/*


" Settings for python-mode
" cd ~/.vim/bundle
" git clone https://github.com/klen/python-mode
map <Leader>g :call RopeGotoDefinition()<CR>
map <Leader>d <C-c>d
map <Leader>f <C-c>f
let ropevim_enable_shortcuts = 1
let g:pymode_rope_goto_def_newwin = "vnew"
let g:pymode_rope_extended_complete = 1
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 1
let g:pymode_syntax_builtin_funcs = 1
let g:pymode_lint_ignore = "E501"
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>


" Python folding
" mkdir -p ~/.vim/ftplugin
" curl -so ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
set nofoldenable

" NerdTreeTab settings
" Start it on startup
"let g:nerdtree_tabs_open_on_console_startup=1
nnoremap <silent><Leader>, :NERDTreeTabsToggle <CR>

