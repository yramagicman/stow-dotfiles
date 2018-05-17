"{{{ Fix Line Endings
function! functions#LineEndings()
    update
    e ++ff=dos
    setlocal ff=unix
    :w
endfunction
"}}}
"{{{ open scratch buffer
function! functions#Scratch()
    new
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal nobuflisted
    resize -15
endfunction
"}}}
"{{{ Maximize
function! functions#Maximize()
    wincmd _
    wincmd |
endfunction
"}}}
"{{{ wrap toggle, provides a nice message when wrap is toggled.
function! functions#WrapToggle()
    set wrap!
    if &wrap == 1
        echom 'wrap on'
    else
        echom 'wrap off'
    endif
endfunction
"}}}
"{{{
function! functions#InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif pumvisible()
        return "\<C-n>"
    else
        return "\<c-n>"
    endif
endfunction
"}}}
