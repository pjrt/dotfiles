" vim:fdm=marker

filetype off                   " required!

" Vim-Plug {{{
"============================================================

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/sideways.vim'
Plug 'Raimondi/delimitMate'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make'}
Plug 'Shougo/vimshell.vim'
Plug 'SirVer/ultisnips'
Plug 'benekastah/neomake'
Plug 'bling/vim-airline'
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
Plug 'dbakker/vim-projectroot'
Plug 'elzr/vim-json', { 'for': 'json'}
Plug 'ervandew/supertab'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'kassio/neoterm'
Plug 'kchmck/vim-coffee-script'
Plug 'nelstrom/vim-visual-star-search'
Plug 'pgilad/vim-skeletons'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'haya14busa/incsearch.vim'
Plug 'tyok/ack.vim'
Plug 'aehlke/vim-rename3'
Plug 'Jacoby6000/vimport-sort'
Plug 'jalvesaq/Nvim-R'
Plug 'scrooloose/vim-slumlord'

" Syntax {{{

Plug 'tpope/vim-markdown'
Plug 'nelstrom/vim-markdown-folding'
Plug 'GEverding/vim-hocon'
Plug 'pbrisbin/html-template-syntax'
Plug 'duganchen/vim-soy'
Plug 'dag/vim-fish'

Plug 'derekwyatt/vim-scala'
Plug 'udalov/kotlin-vim'
Plug 'gre/play2vim'
Plug 'othree/html5.vim'
Plug 'jparise/vim-graphql'
Plug 'kana/vim-filetype-haskell'
Plug 'aklt/plantuml-syntax'

" }}}

" Themes {{{

Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'

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
let g:solarized_termcolors=16
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

inoremap <silent>jk <ESC>
inoremap <silent>kj <ESC>

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

nnoremap <silent> <C-s> :w<CR>
inoremap <silent> <C-s> <ESC>:w<CR>

" Retrigger tag generation
nnoremap <silent> <SPACE>] :NeomakeSh git ctags<CR>

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

" Jenkinsfile is just a groovy file
au BufReadPost Jenkinsfile set syntax=groovy
au BufReadPost Jenkinsfile set filetype=groovy

" Re-enable :file
set shortmess-=F

" Make escape faster. Also fixes an performance issue in airline
" https://gist.github.com/brendonrapp/5944296
set ttimeoutlen=10
augroup FastEscape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=1000
augroup END

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
" let g:switchbuf="useopen,split"

" Quickfixsigns
let g:quickfixsigns_classes = ['qfl', 'loc', 'vcsdiff', 'breakpoints'] " No marks pls

" Return me to the last file, not newtr
let g:netrw_altfile=1

let g:netrw_browsex_viewer=$BROWSER

set complete-=t

" }}}

" Aesthetics {{{
" ============================================================================

set nolist

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

" Neoterm {{{
" ============================================================================

let g:neoterm_size = 20

" }}}


" Window Movement {{{
" ============================================================================

nmap <silent> <C-J>  <C-W>w
nmap <silent> <C-K>  <C-W>W

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

" Same key combo as Gblame, but only on visual
vnoremap <silent> gb :Gbrowse!<CR>


" }}}

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

" IncSearch{{{
" ===========================================================================
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
" }}}

" Easy Align {{{
" ===========================================================================

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" Vim-Move {{{
" =============================================================================
nnoremap <silent> <A-k> :<C-u>move-2<CR>==
nnoremap <silent> <A-j> :<C-u>move+<CR>==
xnoremap <silent> <A-k> :move-2<CR>gv=gv
xnoremap <silent> <A-j> :move'>+<CR>gv=gv
" }}}

" Sideways {{{
" =============================================================================
nnoremap <C-h> :SidewaysLeft<CR>
nnoremap <C-l> :SidewaysRight<CR>
"

" Gitgutter {{{
" =============================================================================
nmap <SPACE>ga <Plug>GitGutterStageHunk
nmap <SPACE>gu <Plug>GitGutterUndoHunk

omap ih <Plug>GitGutterTextObjectInnerPending
omap ah <Plug>GitGutterTextObjectOuterPending
xmap ih <Plug>GitGutterTextObjectInnerVisual
xmap ah <Plug>GitGutterTextObjectOuterVisual
" }}}

""" Vimsort {{{
" =============================================================================
nnoremap <silent><space>i :SortImports<CR>
" }}}

" Custom Functions {{{
" ============================================================================

" Create dirs if they don't exist when making a new file
" http://stackoverflow.com/a/4294176
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

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

  let l:splitted = split(l:word, '\.')
  let l:acc = []
  for wo in l:splitted
    let l:acc = add(l:acc, wo)
    if wo ==# l:plain_tag
      break
    endif
  endfor

  let l:combined = join(l:acc, ".")
  try
    execute "ta " . l:combined
  catch /.*E426.*/ " Tag not found
    execute "ta " . l:plain_tag
  endtry
endfunction

" }}}

if !empty(glob("~/.vimrc-local"))
  source ~/.vimrc-local
endif

" Allow project-specific vimrc
set exrc

" ...and be secure!
set secure
