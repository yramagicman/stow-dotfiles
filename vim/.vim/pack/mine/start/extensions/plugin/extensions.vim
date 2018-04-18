call pack#load()

PlugStart 'editorconfig/editorconfig-vim'
PlugStart 'tpope/vim-commentary'
PlugStart 'vim-scripts/vim-indent-object'
PlugStart 'tpope/vim-surround'
PlugStart 'bronson/vim-visual-star-search'
PlugStart 'junegunn/fzf.vim'
PlugStart 'tpope/vim-repeat'
PlugOpt 'dzeban/vim-log-syntax'
PlugOpt 'w0rp/ale'
PlugOpt 'mileszs/ack.vim'
" PlugOpt 'shougo/neocomplete.vim' REMOVE AFTER 30/4/2018 IF STILL COMMENTED
PlugOpt 'leafgarland/typescript-vim'
" PlugOpt 'jceb/vim-orgmode'
" PlugOpt 'tpope/vim-speeddating'
PlugOpt 'shawncplus/phpcomplete.vim'
PlugOpt 'hail2u/vim-css3-syntax'
PlugOpt 'vim-scripts/Sass'
PlugOpt 'othree/html5.vim'
PlugOpt 'jwalton512/vim-blade'
PlugOpt 'posva/vim-vue'

command! -nargs=* Ack :packadd ack.vim | Ack <f-args>
augroup extensions
    autocmd!
    "autocmd FileType vim,css,scss,sass,html,javascript,python,php,c,cpp,typescript,zsh,sh silent! packadd neocomplete.vim | redraw REMOVE AFTER 30/4/2018 IF STILL COMMENTED{{{}}}
    autocmd FileType vim,css,scss,sass,html,javascript,python,php,c,cpp,typescript,zsh,sh silent! packadd ale | redraw
    autocmd BufRead *.ts  set filetype=typescript
    autocmd BufRead *.org  set filetype=org
    autocmd FileType typescript packadd typescript-vim
    autocmd FileType html packadd html5.vim
    autocmd FileType scss packadd Sass
    autocmd FileType scss,css packadd vim-css3-syntax
    autocmd FileType org packadd vim-speeddating
    autocmd FileType org packadd vim-orgmode
    autocmd FileType php silent! packadd  phpcomplete.vim | redraw
    autocmd BufRead *.blade.php silent! packadd vim-blade | redraw
    autocmd BufRead *.blade.php silent! set filetype=blade | redraw
    autocmd BufRead *.vue silent! packadd vim-vue | redraw
    autocmd BufRead *.vue silent! set filetype=vue | redraw
augroup end
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

" "{{{ completion REMOVE AFTER 30/4/2018 IF STILL COMMENTED
" "Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" " Disable AutoComplPop.
" let g:acp_enableAtStartup = 0
" " Use neocomplete.
" let g:neocomplete#enable_at_startup = 1
" " Use smartcase.
" let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"
" " Define dictionary.
" let g:neocomplete#sources#dictionary#dictionaries = {
"     \ 'default' : '',
"     \ 'vimshell' : $HOME.'/.vimshell_hist',
"     \ 'scheme' : $HOME.'/.gosh_completions'
"         \ }
"
" " Define keyword.
" if !exists('g:neocomplete#keyword_patterns')
"     let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
" " Plugin key-mappings.
" inoremap <expr><C-g>     neocomplete#undo_completion()
" inoremap <expr><C-l>     neocomplete#complete_common_string()
"
" " Recommended key-mappings.
" " <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
"   return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
"   " For no inserting <CR> key.
"   "return pumvisible() ? "\<C-y>" : "\<CR>"
" endfunction
" " <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
"
" " Shell like behavior(not recommended).
" "set completeopt+=longest
" "let g:neocomplete#enable_auto_select = 1
" "let g:neocomplete#disable_auto_complete = 1
" " inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"
" " Enable omni completion.
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"
" " Enable heavy omni completion.
" " if !exists('g:neocomplete#sources#omni#input_patterns')
" "   let g:neocomplete#sources#omni#input_patterns = {}
" " endif
" "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
" "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
" "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" "}}}

cnoreabbrev b Buffers<CR>
cnoreabbrev find Files<CR>
cnoreabbrev gf GFiles<CR>
cnoreabbrev fg GFiles<CR>


let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
