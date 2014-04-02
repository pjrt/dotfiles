set omnifunc=necoghc#omnifunc

nnoremap <Leader>m :w<CR>:make<CR>

nnoremap ght :GhcModType<CR>
nnoremap ghm :GhcModTypeClear<CR>

let g:haskell_shqq = 0 " e and w don't work well in vim2hs if this is not set to zero. https://github.com/dag/vim2hs/issues/72

set wildignore+=*/cabal-dev/*,*/dist/*,*.hi

