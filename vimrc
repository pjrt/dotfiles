" vim:fdm=marker

filetype off                   " required!

" Vim-Plug {{{
"============================================================

call plug#begin('~/.vim/plugged')

Plug 'Chiel92/vim-autoformat'
Plug 'Raimondi/delimitMate'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make'}
Plug 'Shougo/vimshell.vim'
Plug 'SirVer/ultisnips'
Plug 'benekastah/neomake'
Plug 'bling/vim-airline'
Plug 'chrisbra/csv.vim'
Plug 'dbakker/vim-projectroot'
Plug 'elzr/vim-json', { 'for': 'json'}
Plug 'ervandew/supertab'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'kchmck/vim-coffee-script'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'pgilad/vim-skeletons'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'rhysd/vim-grammarous', { 'for': 'markdown', 'commit': '74a88d233056ac63ef65b3dd6766494ec33e6f2e' }
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'zhaocai/GoldenView.Vim'

" Syntax {{{

Plug 'gabrielelana/vim-markdown'
Plug 'GEverding/vim-hocon'
Plug 'pbrisbin/html-template-syntax'
Plug 'tyok/ack.vim'
Plug 'duganchen/vim-soy'
Plug 'dag/vim-fish'

Plug 'derekwyatt/vim-scala'
Plug 'udalov/kotlin-vim'
Plug 'gre/play2vim'
Plug 'othree/html5.vim'
Plug 'jparise/vim-graphql'
Plug 'kana/vim-filetype-haskell'

Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'

" }}}

" Themes {{{

Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'

" }}}

" Other {{{

Plug 'pjrt/vim-vault'
Plug 'pjrt/custom-vim'

" }}}

call plug#end()

" }}}

" Meta {{{
" ============================================================================
set encoding=utf-8
" Rebind <Leader> key
let mapleader = ","
let maplocalleader = ","

" For Cdo
set hidden

" As a general rule, turn off spelling
set nospell

" Use ALL the colors!
syntax enable
set t_Co=256
set background=dark
colorscheme solarized
set nomodeline " Wasn't using this, and it is annoying when it fails


" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F2>

" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again

" Soft line limit
set colorcolumn=80

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
" Try to go into visual mode (v), then select several lines of code here and
" then press ``>`` several times.
vnoremap < <gv
vnoremap > >gv

" Make Y behave correctly
nnoremap Y y$

" Delete whitespace on command
nnoremap <silent> <F5> :%s/\s\+$//<CR>

" Neovim things
if exists(":terminal")
  tnoremap <c-\><c-\> <c-\><c-n>
endif

" }}}

" Misc {{{
" ============================================================================

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
"au InsertLeave * match ExtraWhitespace /\s\+$/

autocmd BufEnter * call <SID>AutoProjectRootCD() " Replicate vim-project

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

nnoremap <silent> Q :w<CR>

" Disable backup files, point swap files elsewhere
set nobackup
set nowritebackup
set dir=~/.vim/tmp

" Tags
set tags=tags;/

" Set Autoread
set autoread

" No useless toolbar or scrollbars when on gvim
set guioptions-=T
set guioptions-=r
set guioptions-=L

" Set Notes dir for vim-notes
let g:notes_directories = ['~/Documents/Notes']

" Skeleton settings
let skeletons#autoRegister = 1

" }}}

" FZF {{{
" ============================================================================
nnoremap <silent><c-p> :FZF<cr>
nnoremap <silent><c-c> :Tag<cr>
nnoremap <silent><c-b> :Buffers<cr>

" Search for <cword>
nnoremap <silent><space>gs :<C-u>execute 'Ag \b' . expand("<cword>") . '\b'<cr>

nnoremap <space>s :Ag 
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

" Formatting {{{

noremap <silent><F5> :Autoformat<CR>
let g:formatdef_scalafmt = "'scalafmt --stdin'"
let g:formatters_scala = ['scalafmt']

" }}}

" Aesthetics {{{
" ============================================================================

set list

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

" Set line numbers
set nu

" Useful settings
set history=700
set undolevels=700


" No tabs, only spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
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
nnoremap <silent> gp :Gpush<CR>
nnoremap <silent> gPP :Gpush -f<CR>
nnoremap <silent> gr :Gpull --rebase<CR>

" }}}

" Unite {{{
" ============================================================================
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '-i --vimgrep --hidden'

" Allow history of yank command
let g:unite_source_history_yank_enable = 1

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

call unite#custom#source('grep', 'matchers', 'matcher_fuzzy')

nnoremap <space>b :Unite -buffer-name=buffers -quick-match buffer<cr>
nnoremap <space>t :<C-u>execute 'Unite -buffer-name=ack grep:./::' . '(todo\|TODO)\:(pr\|pjrt\|pedro)'<cr>
nnoremap <space>r :UniteResume<cr>

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

" Allow to catch tags that extend over a `.` (ie: qualified tags)
function! TagJumpDot() abort
  let l:plain_tag = expand("<cword>")
  let l:orig_keyword = &iskeyword
  set iskeyword+=\.
  let l:word = expand("<cword>")
  let &iskeyword = l:orig_keyword
  try
    execute "ta " . l:word
  catch /.*E426.*/ " Tag not found
    execute "ta " . l:plain_tag
  endtry
endfunction

" }}}
