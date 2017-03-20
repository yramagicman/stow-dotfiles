function! PyFormat() range
    let cmd = [
                \ '!autopep8',
                \ '-' ]

    execute a:firstline . ',' . a:lastline . join(cmd)
endfunction
command! -bar -nargs=0 Pyformat call PyFormat()
function! JsBeautify() range
    let cmd = [
                \ '!js-beautify',
                \ '-i -'
                \ ]
    let type =(&filetype ==# 'javascript' || &filetype ==# 'php') ? 'js' : &filetype
    if &expandtab
        let cmd = add(cmd, '--indent-size '. shiftwidth())
    else
        let cmd = add(cmd, '--indent-with-tabs')
    endif
    let cmd = add(cmd, '--type ' . type)
    execute a:firstline . ',' . a:lastline . join(cmd)
endfunction
augroup formatters
    autocmd!
    autocmd FileType html,css,javascript,json,php command! -bar -nargs=0 -buffer -range=% Format <line1>,<line2>call JsBeautify()
    autocmd FileType python command! -bar -nargs=0 -buffer -range=% Format <line1>,<line2>call PyFormat()
augroup end
