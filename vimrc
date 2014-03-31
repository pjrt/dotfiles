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
Bundle 'Raimondi/delimitMate'
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
Bundle 'chrisbra/csv.vim'
Bundle 'othree/html5.vim'
Bundle 'gre/play2vim'
Bundle 't9md/vim-chef'
Bundle 'tyok/ack.vim'
Bundle 'nerdtree-ack'
Bundle 'pbrisbin/html-template-syntax'
Bundle 'justinmk/vim-sneak'
"Bundle 'scrooloose/syntastic'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'eagletmt/neco-ghc'
Bundle 'Shougo/vimproc.vim'
Bundle 'SirVer/ultisnips'
Bundle 'spiroid/vim-ultisnip-scala'
Bundle 'regedarek/ZoomWin'
Bundle 'tpope/vim-unimpaired'
Bundle 'zhaocai/GoldenView.Vim'

" Interface
Bundle 'tomtom/quickfixsigns_vim' 

" Themes
Bundle 'altercation/vim-colors-solarized'
Bundle 'tomasr/molokai'
Bundle 'chriskempson/vim-tomorrow-theme'

" ============================================================================
" Meta
" ============================================================================
set encoding=utf8
" Rebind <Leader> key
let mapleader = ","
let maplocalleader = ","

" Add Fugitive info to the status bar
set statusline+=%{fugitive#statusline()}

" Use ALL the colors!
set t_Co=256

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F2>

"set clipboard+=unnamed
" ============================================================================
" Key remapping
" ============================================================================
" Make kj and jk to be <ESC>
inoremap kj <Esc>
inoremap jk <Esc>

" Gundo mapping
nnoremap <silent><Leader>p :GundoToggle<CR>

" Edit my vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Source my vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again

" Bind nohl
" Removes highlight of your last search
nnoremap <silent><C-m> :nohl<CR>

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
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

" Switch buffer rules
let g:switchbuf="useopen,split"

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Delete whitespace on command
nnoremap <silent> <F5> :%s/\s\+$//<CR>

" Seems to need to set this here and not in haskell.vim
let g:haddock_browser="/usr/bin/google-chrome"

let g:haskell_autotags = 1
let g:haskell_tags_generator = "hasktags"

" ============================================================================
" Aesthetics
" ============================================================================

set background=dark
colorscheme solarized

" Crosshairs
hi CursorLine   cterm=NONE ctermbg=235
hi CursorColumn cterm=NONE ctermbg=235
nnoremap <silent> <Leader>vv :set cursorline! cursorcolumn!<CR>
if has("gui_running")
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline cursorcolumn
    au WinLeave * setlocal nocursorline nocursorcolumn
endif

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

" Tags
set tags=tags;/

" Quickfixsigns
let g:quickfixsigns_classes = ['qfl', 'loc', 'vcsdiff', 'breakpoints'] " No marks pls

" ============================================================================
" Golden Ratio
" ============================================================================

let g:goldenview__enable_default_mapping = 0
nmap <silent> <c-L> <Plug>GoldenViewSplit

nmap <silent> <C-J>  <Plug>GoldenViewNext
nmap <silent> <C-K>  <Plug>GoldenViewPrevious

nmap <silent> <C-w>m  <Plug>GoldenViewSwitchMain
nmap <silent> <C-w>n  <Plug>GoldenViewSwitchToggle

" ============================================================================
" Fugitive
" ============================================================================

nnoremap <silent> gb :Gblame<CR>
nnoremap <silent> gs :Gstatus<CR>

" ============================================================================
" CtrlP
" ============================================================================
" Startify and ctrlP don't work well together without this
let g:ctrlp_reuse_window  = 'startify'
let g:ctrlp_working_path_mode = "ra"
let g:ctrlp_max_height = 30
let g:ctrlp_root_markers = ['project/']
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*.class,*.jar,*.iml,*.classpath,*/target/*

" ===========================================================================
" UltiSnips
" ===========================================================================

let g:UltiSnipsExpandTrigger="<C-c>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" Settings for vim-powerline
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
set laststatus=2

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone


" ============================================================================
" NerdTreeTab settings
" ============================================================================
nnoremap <silent><Leader>, :NERDTreeTabsToggle <CR>
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

let g:NERDTreeMapJumpNextSibling = "<C-n>"
let g:NERDTreeMapJumpPrevSibling = "<C-p>"

" Copied from https://github.com/derekwyatt/vim-config/blob/master/xpt-personal/ftplugin/scala/scala.xpt.vim
function! _GetPackageForFile(regexes)
    let dir = expand('%:p:h')
    for e in regexes
      let idx = match(dir, e[0])
      if idx != -1
        let subdir = strpart(dir, idx + strlen(e[1]) + 1)
        let package = substitute(subdir, '/', '.', 'g')
        return package
      endif
    endfor
    return ''
endfunction

function! Classname(...)
  return expand('%:t:r')
endfunction
"
" Set Autoread
set autoread
