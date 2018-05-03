function! findtags#Findtags()
    silent! set tags=''
    let index = -1
    let path =  expand('%:p')
    let g:path = split( path, '/' )[:index]
    function! Recurse(p, index)
        if len(a:p) > 0 && a:index > -25
            let p = a:p
            let l:tagsfile = system('find '.'/'.join(g:path[:a:index], '/').' -maxdepth 1 -type f -name ".tags" ')
            if l:tagsfile != ''
                execute "set tags=".l:tagsfile
                if &tags
                    set tags
                endif
                return
            endif
            return Recurse(g:path[ :a:index], a:index - 1)
        endif
    endfunction
    if &tags != ''
        silent! call Recurse(path, index)
    endif
endfunction
command! FindTags :call findtags#Findtags()
