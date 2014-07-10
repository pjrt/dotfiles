" vim:fdm=marker

set nocompatible               " be iMproved
filetype off                   " required!

" Vundle {{{
"============================================================

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Bundle 'gmarik/Vundle.vim'

Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-surround'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-abolish'
Bundle 'Raimondi/delimitMate'
Bundle 'scrooloose/nerdcommenter'
"Bundle 'mhinz/vim-startify'
Bundle 'kchmck/vim-coffee-script'
Bundle 'Shougo/neocomplete.vim'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'elzr/vim-json'
Bundle 'tpope/vim-vinegar'
Bundle 'kris89/vim-multiple-cursors'
Bundle 'sjl/gundo.vim'
"Bundle 'lukerandall/haskellmode-vim'
Bundle 'dag/vim2hs'
"Bundle 'Shougo/neocomplete.vim'
Bundle 'chrisbra/csv.vim'
Bundle 't9md/vim-chef'
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

Bundle 'amiorin/vim-project'

Bundle 'Shougo/vimshell.vim'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimfiler.vim'

" Syntax {{{

Bundle 'derekwyatt/vim-scala'
Bundle 'klen/python-mode'
Bundle 'tpope/vim-markdown'
Bundle 'pbrisbin/html-template-syntax'
Bundle 'tyok/ack.vim'
Bundle 'othree/html5.vim'
Bundle 'gre/play2vim'
Bundle 'itchyny/landscape.vim'

" }}}

" Interface {{{

Bundle 'tomtom/quickfixsigns_vim'

" }}}

" Themes {{{

Bundle 'altercation/vim-colors-solarized'
Bundle 'tomasr/molokai'
Bundle 'chriskempson/vim-tomorrow-theme'

" }}}

" Other {{{

Bundle 'pjrt/vim-vault'
Bundle 'pjrt/custom-vim'

" }}}

" }}}

" Meta {{{
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

" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again

" }}}

" Key remapping {{{
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

" Delete whitespace on command
nnoremap <silent> <F5> :%s/\s\+$//<CR>

" }}}

" Misc {{{
" ============================================================================

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Tags
set tags=tags;/

" Set Autoread
set autoread

" }}}

" Variable setting {{{
" ============================================================================

" Switch buffer rules
let g:switchbuf="useopen,split"

" Seems to need to set this here and not in haskell.vim
let g:haddock_browser="/usr/bin/google-chrome"

let g:haskell_autotags = 1
let g:haskell_tags_generator = "hasktags"

" Quickfixsigns
let g:quickfixsigns_classes = ['qfl', 'loc', 'vcsdiff', 'breakpoints'] " No marks pls

" Multiple cursors
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0


" }}}

" Aesthetics {{{
" ============================================================================

set background=dark
colorscheme desert

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

" }}}

" Golden Ratio {{{
" ============================================================================

let g:goldenview__enable_default_mapping = 0
nmap <silent> <c-L> <Plug>GoldenViewSplit

nmap <silent> <C-J>  <Plug>GoldenViewNext
nmap <silent> <C-K>  <Plug>GoldenViewPrevious

nmap <silent> <C-w>m  <Plug>GoldenViewSwitchMain
nmap <silent> <C-w>n  <Plug>GoldenViewSwitchToggle

" }}}

" Fugitive {{{
" ============================================================================

nnoremap <silent> gb :Gblame<CR>
nnoremap <silent> gs :Gstatus<CR>

" }}}

" Unite {{{
" ============================================================================
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'

let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'

" Allow history of yank command
let g:unite_source_history_yank_enable = 1

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <C-p> :Unite -buffer-name=files -start-insert file_rec/async<cr>
nnoremap <space>b :Unite -buffer-name=buffers -quick-match buffer<cr>
nnoremap <space>s :Unite -buffer-name=ack grep:.<cr>
nnoremap <space>r :UniteResume<cr>

" Search <cword>
nnoremap <space>gs :<C-u>execute 'Unite grep:.::' . expand("<cword>")<cr>
" Global search <cword>
nnoremap <space>Gs :<C-u>execute 'Unite grep:..::' . expand("<cword>")<cr>

nnoremap <space>y :Unite history/yank<cr>

set wildignore+=tags
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*.class,*.jar,*.iml,*.classpath,*/target/*

" }}}

" UltiSnips {{{
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

" }}}

" NeoComplete {{{
" ===========================================================================

let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

"  }}}


" Custom Functions {{{
" ============================================================================

" Copied from https://github.com/derekwyatt/vim-config/blob/master/xpt-personal/ftplugin/scala/scala.xpt.vim
function! _GetPackageForFile(regexes)
    let dir = expand('%:p:h')
    for e in a:regexes
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

" }}}
