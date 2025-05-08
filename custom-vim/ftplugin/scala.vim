set errorformat=%E\[E]\ \[E%n]\ %f:%l:%c,
set errorformat+=%Z\[E]\ %m,
set errorformat+=\[error]\ %f:%l:%c:\ %m,
set errorformat+=%E\ %#[error]\ %#%f:%l:\ %m,%-C\ %#[error]\ %m,%-Z\ %#[error]\ %p^
set errorformat+=%W\ %#[warn]\ %#%f:%l:\ %m,%-C\ %#[warn]\ %m,%-Z\ %#[warn]\ %p^
set errorformat+=%-G%.%#
noremap <silent> <Leader>ff :cf .git/quickfix<CR>
noremap <silent> <Leader>fn :cn<CR>

" Search local or project for the class, trait, val or def under the cursor
nnoremap <silent><space>f /\(def\\|val\\|class\\|trait\\|object\) \<<C-r><C-w>\>/I<cr>
nnoremap <silent><space>gf :<C-u>execute 'Ag (def\|class\|trait\|object) ' . expand("<cword>") . '\b'<cr>
nnoremap <silent><space>ge :<C-u>execute 'Ag (extends\|with) ' . expand("<cword>") . '\b'<cr>

nnoremap <silent><F5> :!scalafmt -i -f %<CR>

nnoremap <silent>,tq :T qsbt<CR>
nnoremap <silent>,ts :Tmap testQuick<CR>

" Required to allow stags to tag jars
set notagrelative
set tags=.git/tags,/home/pjrt/.cache/nvim/tags

" No idea where this came from
" unmap <C-i>

augroup zipfiles
  autocmd!
  autocmd BufEnter zipfile:/*.scala set nomodifiable
  autocmd BufLeave zipfile:/*.scala set modifiable
augroup END

" set foldmethod=syntax
" setlocal foldlevel=99

function! GetPackageForFile()
    let regexes = [
                \   [ '/src/main/scala',      '/src/main/scala' ],
                \   [ '/src/test/scala',      '/src/test/scala' ],
                \   [ '/src/it/scala',        '/src/it/scala' ],
                \   [ '/src/fun/scala',       '/src/fun/scala' ],
                \   [ '/src/multi-jvm/scala', '/src/multi-jvm/scala' ],
                \   [ '/app/model/scala',     '/app/model/scala' ],
                \   [ '/app/controllers',     '/app' ],
                \   [ '/app/com',             '/app' ],
                \   [ '/test/com',            '/test' ],
                \   [ '/test/scala',          '/test/scala' ],
                \   [ '/src',                 '/src' ]
                \ ]
    return _GetPackageForFile(regexes)
endfunction

" Use stags' qualified tags
" nnoremap <silent> <C-]> :<C-u>call TagJumpDot()<CR>

" " Smaller updatetime for CursorHold & CursorHoldI
" set updatetime=300

" " don't give |ins-completion-menu| messages.
" set shortmess+=c

" " always show signcolumns
" set signcolumn=yes

" " Some server have issues with backup files, see #649
" set nobackup
" set nowritebackup

" " Better display for messages
" set cmdheight=2

" " Use <c-space> for trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" " Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" " Use `[c` and `]c` for navigate diagnostics
" nmap <silent> [c <Plug>(coc-diagnostic-prev)
" nmap <silent> ]c <Plug>(coc-diagnostic-next)

" " Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Remap for do codeAction of current line
" nmap <leader>ac <Plug>(coc-codeaction)

" " Remap for do action format
" nnoremap <silent> F :call CocAction('format')<CR>

" " Use K for show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if &filetype == 'vim'
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction

" " Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" " Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)

" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
