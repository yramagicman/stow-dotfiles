scriptencoding utf-8
if filereadable(expand('$VIMRUNTIME/defaults.vim'))
    unlet! g:skip_defaults_vim
    source $VIMRUNTIME/defaults.vim
endif
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Switch syntax highlighting on
syntax on

colorscheme base16
set background=dark

let g:VimPack_Setup_Folders = ['after', 'autoload', 'backup', 'colors', 'doc', 'snippets', 'spell', 'swaps', 'syntax', 'tags', 'undo']
let g:VimPack_Update_Frequency = 5
let g:VimPack_Auto_Install = 1
let g:VimPack_Auto_Update = 1

" set packpath+=~/.vim/pack/
call pack#load()

PlugStart 'editorconfig/editorconfig-vim'
PlugStart 'tpope/vim-commentary'
PlugStart 'vim-scripts/vim-indent-object'
PlugStart 'tpope/vim-surround'
PlugStart 'bronson/vim-visual-star-search'
PlugStart 'tpope/vim-repeat'
PlugOpt 'dzeban/vim-log-syntax'
PlugOpt 'w0rp/ale'
PlugOpt 'mileszs/ack.vim'
PlugOpt 'leafgarland/typescript-vim'
PlugOpt 'shawncplus/phpcomplete.vim'
PlugOpt 'hail2u/vim-css3-syntax'
PlugOpt 'vim-scripts/Sass'
PlugOpt 'othree/html5.vim'
PlugOpt 'jwalton512/vim-blade'
PlugOpt 'posva/vim-vue'
if system('which fzf')[:-2] != 'fzf not found'
    PlugStart 'junegunn/fzf.vim'
    cnoreabbrev b Buffers<CR>
    cnoreabbrev find Files<CR>
    cnoreabbrev gf GFiles<CR>
    cnoreabbrev fg GFiles<CR>
endif

command! -nargs=* Ack :packadd ack.vim | Ack <f-args>
augroup extensions
    autocmd!
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
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

set shell=zsh

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" enable Omnicomplete
set omnifunc=syntaxcomplete#Complete

packadd! matchit
packadd! editexisting

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

set autoread
set autowrite

set lazyredraw
set ttyfast

" Centralize backups, swapfiles and undo history
if exists("&backupdir")
    set backupdir=~/.vim/backup//
endif
if exists("&directory")
    set directory=~/.vim/swaps//
endif
if exists("&undodir")
    set undolevels=5000
    set undodir=~/.vim/undo//
    set undofile
endif

set laststatus=2
set number
set relativenumber
set expandtab
set eol
set nowrapscan

set foldcolumn=2
set foldmethod=marker
set wildmenu
set wildmode=full
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set nolist wrap linebreak sidescrolloff=15
set listchars=tab:▸\ ,trail:·,eol:¬,extends:❯,precedes:❮
set showbreak=....
if exists('+breakindent')
    set breakindent
endif

set nojoinspaces

" set equalalways
set splitbelow
set splitright
set scrolloff=2
" 256 colors
set t_Co=256
"Use os clipboard
set clipboard^=unnamedplus,unnamed
set incsearch

" Ignore case of searches
set ignorecase
set smartcase
set startofline

set shortmess+=A " ignore annoying swapfile messages
set shortmess+=I " no splash screen
set shortmess+=O " file-read message overwrites previous
set shortmess+=T " truncate non-file messages in middle
set shortmess+=W " don't echo "[w]"/"[written]" when writing
set shortmess+=a " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=o " overwrite file-written messages
set shortmess+=t " truncate file messages at start

set novisualbell
set noerrorbells
if exists('&belloff')
    set belloff=all
endif


set statusline=\|\ %m\ %f\ %r\ \%y
" Always show status line
let f=system('[[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"')
let b=system('git branch 2>/dev/null | grep \* | sed "s/\*//g"')
let c=split(b, '')
set laststatus=2
set statusline=\|\ %m\ %f\ %r\ \%y
if len(c)
    set statusline+=\ \%{c[0]}
endif
if len(f)
    set statusline+=\ %{f[0]}
endif
set statusline+=%=
set statusline+=Line:
set statusline+=%4l/%-4L
set statusline+=\ Column\ %2c
set statusline+=\ \|

set hidden
set winheight=2
set winminheight=2

" let s:dontwrite = ['!zsh', '[No Name]']
augroup defaults
    autocmd!
    autocmd InsertLeave * if filewritable( expand('%')) == 1 | silent w | endif
    autocmd BufWritePost $MYVIMRC source %
    autocmd BufWritePre,InsertLeave * :%s/\s\+$//e
    autocmd BufWritePre * silent! :%s#\($\n\s*\)\+\%$##
    autocmd BufWritePre,InsertLeave * silent! :retab!
    autocmd BufEnter * set cursorline
    autocmd BufLeave * set nocursorline
    autocmd BufEnter,BufWritePost,ShellCmdPost * let f=system('[[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"')
    autocmd VimEnter,BufEnter,ShellCmdPost * let b=system('git branch 2>/dev/null | grep \* | sed "s/\*//g"')
    autocmd VimEnter,BufEnter,ShellCmdPost * let c=split(b, '')
    autocmd VimEnter * source $MYVIMRC
    autocmd FileType * set textwidth=80
    autocmd FileType mail set textwidth=0
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=python3complete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType clojure setlocal omnifunc=clojurecomplete#Complete
    autocmd FileType sql setlocal omnifunc=sqlcomplete#Complete
    autocmd BufRead,BufEnter .env :ALEDisableBuffer
    autocmd CursorHold * :w
augroup end

noremap <left>  <Nop>
noremap <down>  <Nop>
noremap <up>    <Nop>
noremap <right> <Nop>
inoremap <left>  <Nop>
inoremap <down>  <Nop>
inoremap <up>    <Nop>
inoremap <right> <Nop>
hi ExtraWhitespace cterm=underline
match ExtraWhitespace /\s\+$/
inoremap <space><space> <Esc>:w<cr>
vnoremap <space><space> <Esc>:w<cr>
nnoremap <space><space> :w<cr>
nnoremap .<space> i<space><Esc>:w<cr>

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif pumvisible()
        return "\<C-n>"
    else
        return "\<c-n>"
    endif
endfunction

inoremap <expr> <tab> InsertTabWrapper()
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
cnoremap <expr> %% expand('%:h').'/'
inoremap <c-f> <c-x><c-f>

if &diff
    nnoremap <C-q> :qa!<cr>
    set foldmethod=diff
    set list
    set nowrap
endif

let mapleader=","
nnoremap <leader><space> :set hlsearch!<cr>
nnoremap <leader><leader> <C-^>
nnoremap * :set hlsearch<cr>*
