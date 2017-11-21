function! GetPackageForFile()
    let regexes = [
                \   [ '/src/main/java',      '/src/main/java' ],
                \   [ '/src/test/java',      '/src/test/java' ],
                \   [ '/src/it/java',        '/src/it/java' ],
                \   [ '/src/multi-jvm/java', '/src/multi-jvm/java' ],
                \   [ '/app/model/java',     '/app/model/java' ],
                \   [ '/app/controllers',     '/app' ],
                \   [ '/app/controllers',     '/app' ],
                \   [ '/app/com',             '/app' ],
                \   [ '/app/src/main/java',   '/app/src/main/java' ],
                \   [ '/test/com',            '/test' ],
                \   [ '/test/java',          '/test/java' ]
                \ ]
    return _GetPackageForFile(regexes)
endfunction
