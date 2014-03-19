set omnifunc=necoghc#omnifunc

compiler ghc
nnoremap <Leader>gi :GHCi<Space>
nnoremap <Leader>m :w<CR>:make<CR>

nnoremap ght :GhcModType<CR>
nnoremap ghm :GhcModTypeClear<CR>

let g:haskell_shqq = 0 " e and w don't work well in vim2hs if this is not set

