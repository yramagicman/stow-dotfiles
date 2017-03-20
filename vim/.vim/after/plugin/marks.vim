command! Marks call s:MyMarks()

function! s:MyMarks()
    marks abcdefghijklmnop.
    echom 'Which mark? '
    let m = nr2char(getchar())
    redraw
    execute 'normal! `' . m
endfunction
