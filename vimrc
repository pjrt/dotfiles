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
Bundle 'lukerandall/haskellmode-vim'
Bundle 'dag/vim2hs'
"Bundle 'Shougo/neocomplete.vim'
Bundle 'https://github.com/ujihisa/neco-ghc'
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
Bundle 'Shougo/vimproc.vim'
Bundle 'SirVer/ultisnips'
Bundle 'spiroid/vim-ultisnip-scala'
Bundle 'vim-scripts/dbext.vim'

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

" make ctrl+s be ctrl+a since c-a is used in screen
nnoremap <c-s> <c-a>

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

" Make H and L be ^ and $
nnoremap H ^
nnoremap L $

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

" ============================================================================
" Haskell-mode settings
" ============================================================================
au BufEnter *.hs compiler ghc
let g:haddock_browser="/usr/bin/google-chrome"
au FileType haskell nnoremap <Leader>gi :GHCi<Space>
au FileType haskell nnoremap <Leader>m :w<CR>:make<CR>

au FileType haskell nnoremap ght :GhcModType<CR>
au FileType haskell nnoremap ghm :GhcModTypeClear<CR>

" ============================================================================
" vim2hs settings
" ============================================================================
au FileType haskell setlocal omnifunc=necoghc#omnifunc

" ============================================================================
" Chef Vim
" ============================================================================

au FileType ruby nnoremap <Leader>f :ChefFindAny<CR>

" ============================================================================
" Python IDE Setup
" ============================================================================


" Settings for vim-powerline
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
set laststatus=2

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

" Python folding
" mkdir -p ~/.vim/ftplugin
" curl -so ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
set nofoldenable

" ============================================================================
" NerdTreeTab settings
" ============================================================================
nnoremap <silent><Leader>, :NERDTreeTabsToggle <CR>
let g:ackprg="ack-grep -H --nocolor --nogroup --column"


" ===========================================================================
" Scala IDE
" ===========================================================================
set errorformat=%E\ %#[error]\ %#%f:%l:\ %m,%-Z\ %#[error]\ %p^,%-C\ %#[error]\ %m
set errorformat+=,%W\ %#[warn]\ %#%f:%l:\ %m,%-Z\ %#[warn]\ %p^,%-C\ %#[warn]\ %m
set errorformat+=,%-G%.%#
noremap <silent> <Leader>ff :cf /tmp/sbt.quickfix<CR>
noremap <silent> <Leader>fn :cn<CR>

" Copied from https://github.com/derekwyatt/vim-config/blob/master/xpt-personal/ftplugin/scala/scala.xpt.vim
function! GetPackageForFile(...)
    let dir = expand('%:p:h')
    let regexes = [
                \   [ '/src/main/scala',      '/src/main/scala' ],
                \   [ '/src/test/scala',      '/src/test/scala' ],
                \   [ '/src/it/scala',        '/src/it/scala' ],
                \   [ '/src/multi-jvm/scala', '/src/multi-jvm/scala' ],
                \   [ '/app/model/scala',     '/app/model/scala' ],
                \   [ '/app/controllers',     '/app' ],
                \   [ '/test/scala',          '/test/scala' ]
                \ ]
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

" ===========================================================================
" DB connections
" ===========================================================================
let g:dbext_default_profile_localhost = 'type=MYSQL:user=root:dbname=updtr'
