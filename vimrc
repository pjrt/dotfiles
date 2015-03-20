" vim:fdm=marker

set nocompatible               " be iMproved
filetype off                   " required!

" Vim-Plug {{{
"============================================================

call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline'
Plug 'tpope/vim-surround'
Plug 'nelstrom/vim-visual-star-search'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'kchmck/vim-coffee-script'
Plug 'Shougo/neocomplete.vim'
Plug 'elzr/vim-json', { 'for': 'json'}
Plug 'tpope/vim-vinegar'
Plug 'sjl/gundo.vim'
Plug 'chrisbra/csv.vim'
Plug 't9md/vim-chef'
Plug 'justinmk/vim-sneak'
Plug 'Shougo/vimproc.vim', { 'do': 'make'}
Plug 'SirVer/ultisnips'
Plug 'regedarek/ZoomWin'
Plug 'tpope/vim-unimpaired'
Plug 'zhaocai/GoldenView.Vim'
Plug 'tpope/vim-dispatch'

Plug 'dbakker/vim-projectroot'

Plug 'Shougo/vimshell.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'Peeja/vim-cdo'


" Syntax {{{

"Plug 'dag/vim2hs'
Plug 'derekwyatt/vim-scala'
Plug 'klen/python-mode'
Plug 'tpope/vim-markdown'
Plug 'pbrisbin/html-template-syntax'
Plug 'tyok/ack.vim'
Plug 'othree/html5.vim'
Plug 'gre/play2vim'
Plug 'itchyny/landscape.vim'

" }}}

" Interface {{{

"Plug 'tomtom/quickfixsigns_vim'
Plug 'kana/vim-filetype-haskell'

" }}}

" Themes {{{

Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'chriskempson/vim-tomorrow-theme'

" }}}

" Other {{{

Plug 'pjrt/vim-vault'
Plug 'pjrt/custom-vim'

" }}}

call plug#end()

" }}}

" Meta {{{
" ============================================================================
set encoding=utf8
" Rebind <Leader> key
let mapleader = ","
let maplocalleader = ","

" For Cdo
set hidden

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

autocmd BufEnter * call <SID>AutoProjectRootCD() " Replicate vim-project

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Tags
set tags=tags;/

" Set Autoread
set autoread

" No useless toolbar when on gvim
set guioptions-=T

" }}}

" Variable setting {{{
" ============================================================================

" Switch buffer rules
let g:switchbuf="useopen,split"

" Quickfixsigns
let g:quickfixsigns_classes = ['qfl', 'loc', 'vcsdiff', 'breakpoints'] " No marks pls

" Return me to the last file, not newtr
let g:netrw_altfile=1

" }}}

" Aesthetics {{{
" ============================================================================

set background=dark
colorscheme desert

" Crosshairs
hi CursorLine   cterm=NONE ctermbg=235
hi CursorColumn cterm=NONE ctermbg=235
if has("gui_running")
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline cursorcolumn
    au WinLeave * setlocal nocursorline nocursorcolumn
    set go-=m " Useless toolbars
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

" Vinegar {{{
" ============================================================================
nnoremap <silent> _ -:execute 'edit' . getcwd() <CR>
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

call unite#custom#source('grep', 'matchers', 'matcher_fuzzy')

nnoremap <C-p> :Unite -buffer-name=files -start-insert file_rec/async<cr>
nnoremap <space>b :Unite -buffer-name=buffers -quick-match buffer<cr>
nnoremap <space>s :Unite -buffer-name=ack grep:.<cr>
nnoremap <space>t :<C-u>execute 'Unite -buffer-name=ack grep:.::' . '(todo\|TODO)\:(pr\|pjrt\|pedro)'<cr>
nnoremap <space>r :UniteResume<cr>

" Search <cword>
nnoremap <space>gs :<C-u>execute 'Unite grep:.::\\b' . expand("<cword>") . '\\b'<cr>
" Global search <cword>
nnoremap <space>Gs :<C-u>execute 'Unite grep:..::\\b' . expand("<cword>") . '\\b'<cr>

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
    echom "Could not extract package for " . dir
    return ''
endfunction

function! Classname(...)
  return expand('%:t:r')
endfunction

function! <SID>AutoProjectRootCD()
  try
    if &ft != 'help'
      ProjectRootCD
    endif
  catch
    " Silently ignore invalid buffers
  endtry
endfunction

" }}}
