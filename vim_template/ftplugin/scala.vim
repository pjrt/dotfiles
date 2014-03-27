set errorformat=%E\ %#[error]\ %#%f:%l:\ %m,%-C\ %#[error]\ %m,%-Z\ %#[error]\ %p^
set errorformat+=%W\ %#[warn]\ %#%f:%l:\ %m,%-C\ %#[warn]\ %m,%-Z\ %#[warn]\ %p^
set errorformat+=%-G%.%#
noremap <silent> <Leader>ff :cf /tmp/sbt.quickfix<CR>
noremap <silent> <Leader>fn :cn<CR>

function! GetPackageForFile(...)
    let regexes = [
                \   [ '/src/main/scala',      '/src/main/scala' ],
                \   [ '/src/test/scala',      '/src/test/scala' ],
                \   [ '/src/it/scala',        '/src/it/scala' ],
                \   [ '/src/multi-jvm/scala', '/src/multi-jvm/scala' ],
                \   [ '/app/model/scala',     '/app/model/scala' ],
                \   [ '/app/controllers',     '/app' ],
                \   [ '/test/scala',          '/test/scala' ]
                \ ]
    return _GetPackageForFile(regexes)
endfunction
