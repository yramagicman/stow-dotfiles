"{{{functions
"{{{ Strip trailing whitespace
function! functions#StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
"}}}
"{{{ indent guides
let g:indentguides_state = 0
function! functions#IndentGuides()
    if g:indentguides_state
        let g:indentguides_state = 0
        2match None
    else
        let g:indentguides_state = 1
        execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
    endif
endfunction
"call IndentGuides()
"}}}
"{{{ Fix Line Endings
function! functions#LineEndings()
    update
    e ++ff=dos
    setlocal ff=unix
    :w
endfunction
"}}}
"{{{ kill extra newlines
function! functions#Knl ()
    try
        %s#\($\n\s*\)\+\%$##
    catch
    endtry
endfunction
"}}}
"{{{ Check for :Error command so it can be run on save
function! functions#CheckErrorFn()
    if exists(':Error')
        Error
    endif
endfunction
"}}}
"{{{ get stuff off my screen
let g:clean = 1
function! functions#CleanScreen()
    if  g:clean == 0
        let g:numoff = 0
        set laststatus=2
        set foldcolumn=2
        set relativenumber
        set number
        set showmode
        let g:clean=1
        return g:clean
    else
        let g:numoff = 1
        set laststatus=0
        set noshowmode
        set nonumber
        set norelativenumber
        set foldcolumn=12
        let g:clean=0
        return g:clean
    endif
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
"{{{ toggle fold column markers
let g:foldon=1
function! functions#FoldColumn()
    if g:foldon == 1
        hi      FoldColumn       ctermbg=234     ctermfg=247    guifg=# c1c1c  guibg=# c1c1c
        let g:foldon=0
        return g:foldon
    else
        hi      FoldColumn       ctermbg=234     ctermfg=234    guifg=# c1c1c  guibg=# c1c1c
        let g:foldon=1
        return g:foldon
    endif
endfunction
"}}}
"{{{ Open in secondary editor. I use TextWrangler on OS X so tw makes sense
function! functions#Tw()
    if has('python')
python << endpython
import sys, os, vim
from subprocess import call
gui_editor_defined = int(vim.eval('exists("g:Gui_Editor")'))
cur_file = vim.eval('bufname("%")')
platform = sys.platform
if gui_editor_defined:
    gui_editor = vim.eval('g:Gui_Editor')
    if platform == 'darwin':
        call(['open', '-a', gui_editor, cur_file])
    if platform =='linux' or platform == 'linux2':
        call([gui_editor, cur_file])
else:
    print "Please set a secondary editor by adding let g:Gui_Editor='editor command' to your vimrc"
endpython
endif
endfunction
"}}}
"{{{ Maximize
function! functions#Maximize()
    wincmd _
    wincmd |
endfunction
"}}}
"{{{ Auto-highlight current word
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
function! functions#AutoHighlightToggle()
    let @/ = ''
    if exists('# uto_highlight')
        au! auto_highlight
        augroup! auto_highlight
        setl updatetime=4000
        echo 'Highlight current word: off'
        return 0
    else
        augroup auto_highlight
            au!
            au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
        augroup end
        setl updatetime=500
        echo 'Highlight current word: ON'
        return 1
    endif
endfunction
"}}}
"}}}
