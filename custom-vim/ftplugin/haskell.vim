set errorformat=%E%f:%l:%c:,%C%m
set errorformat+=%E%f:%l:%c:\ %m,%C%m
set errorformat+=%W%f:%l:%c:\ Warning:,%C%m

nnoremap <Leader>m :w<CR>:make<CR>
nnoremap <silent> <Leader>ff :cf .git/cabal.quickfix<CR>
nnoremap <silent> <Leader>fn :cn<CR>
nnoremap <silent> <space>hh :exec "!hlint . \| tee .git/cabal.quickfix"<CR>

set wildignore+=*/cabal-dev/*,*/dist/*,*.hi,.stack-work/*

" Search local or project for the class, trait, val or def under the cursor
nnoremap <silent><space>f /\(data\\|type\\|class) \<<C-r><C-w>\>/I<cr>
nnoremap <silent><space>gf :Unite -buffer-name=ack grep:.::(data\|type\|class)\ <C-r><C-w>\\b<cr>

" We use hasktags, which support qualified tags
nnoremap <silent> <C-]> :<C-u>call TagJumpDot()<CR>

function! GetPackageForFile()
    let regexes = [
                \   [ '/src/test',    '/src/test' ],
                \   [ '/src/lib',     '/src/lib' ],
                \   [ '/src/service', '/src/service' ],
                \   [ '/src',         '/src' ],
                \   [ '/test',        '/test' ],
                \ ]
    return _GetPackageForFile(regexes)
endfunction
