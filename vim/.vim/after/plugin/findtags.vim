"afa

function! Findtags()
    let index = -2
    let path =  expand('%:p')
    let g:path = split( path, '/' )[:index]
    function! Recurse(p, index)
        if len(a:p) > 0 && a:index > -25
            echom join(g:path[:a:index])
            let p = a:p
            echom "\n"
            let l:tagsfile = system('find '.'/'.join(g:path[:a:index], '/').' -maxdepth 1 -type f -name ".tags" ')
            echom l:tagsfile
            if l:tagsfile != ''
                execute "set tags=".l:tagsfile
                set tags
                return
            endif
            return Recurse(g:path[ :a:index], a:index - 1)
        endif
    endfunction
    call Recurse(path, index)
endfunction

autocmd bufenter * call Findtags()

"find tags
