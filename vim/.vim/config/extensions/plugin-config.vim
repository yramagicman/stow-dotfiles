call vimplug#load()

PlugStart 'haya14busa/incsearch.vim'
PlugStart 'editorconfig/editorconfig-vim'
PlugStart 'haya14busa/incsearch.vim'
PlugStart 'tpope/vim-commentary'
PlugStart 'vim-scripts/vim-indent-object'
PlugStart 'tpope/vim-surround'
PlugStart 'bronson/vim-visual-star-search'
PlugOpt 'dzeban/vim-log-syntax'
PlugOpt 'mileszs/ack.vim'
PlugOpt 'sjl/clam.vim'
PlugOpt 'shougo/neocomplete.vim'
PlugOpt 'shawncplus/phpcomplete.vim'
PlugOpt 'leafgarland/typescript-vim'
PlugOpt 'jceb/vim-orgmode'
PlugOpt 'tpope/vim-speeddating'
PlugOpt 'hail2u/vim-css3-syntax'
PlugOpt 'vim-scripts/Sass'
PlugOpt 'othree/html5.vim'


"{{{ completion
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
" inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
" if !exists('g:neocomplete#sources#omni#input_patterns')
"   let g:neocomplete#sources#omni#input_patterns = {}
" endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"}}}

map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:UltiSnipsExpandTrigger="<C-e>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"


command! -nargs=* Ack :packadd ack.vim | Ack <f-args>
command! -nargs=* Clam :packadd clam.vim | Clam <f-args>


autocmd! FileType vim,css,scss,sass,html,javascript,python,php packadd neocomplete.vim
autocmd! FileType php packadd phpcomplete.vim
autocmd! BufRead *.ts  set filetype=typescript
autocmd! FileType typescript packadd typescript-vim
autocmd! FileType html packadd html5.vim
