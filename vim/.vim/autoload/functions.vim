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
    botright new
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal nobuflisted
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
"{{{ tab completion
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
"{{{ toggle status line
function! functions#StatusToggle()
    if &laststatus == 2
        set laststatus=0
    else
        set laststatus=2
    endif
endfunction
"}}}
"{{{ saving
function! functions#Save()
    if filewritable(expand('%')) == 1
        silent w
    endif
endfunction
"}}}
" {{{ compile javascript
function! functions#CompileJS()
    if !bufexists('compiling-js')
        call term_start(['/bin/sh', '-c', 'npm run dev'], {'term_rows': 5, 'term_finish': 'close' , 'term_name': 'compiling-js'})
        redraw!
    endif
endfunction
" }}}
