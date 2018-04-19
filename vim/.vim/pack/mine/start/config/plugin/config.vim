"{{{ set secondary editor
let g:Gui_Editor = 'leafpad'
"}}}
"{{{setup stuff, for install plugin
let g:VimPack_Setup_Folders = ['after', 'autoload', 'backup', 'colors', 'doc', 'snippets', 'spell', 'swaps', 'syntax', 'tags', 'undo']
let g:VimPack_Update_Frequency = 5
let g:VimPack_Auto_Install = 1
let g:VimPack_Auto_Update = 1
"}}}
"{{{ Defaults probably won't change... ever
set updatetime=1500
set lazyredraw
set background=dark
set autoread
set spelllang=en_us
" best color scheme ever
colorscheme portable
set t_Co=256
"Use os clipboard
set clipboard^=unnamedplus,unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
" set gdefault
set binary
set eol
if exists("&backupdir")
    " Centralize backups, swapfiles and undo history
    set backupdir=~/.vim/backup//
endif
"set directory=~/.vim/swaps
"I hate swap files
set noswapfile
if exists("&undodir")
    set undolevels=5000
    set undodir=~/.vim/undo//
    set undofile
endif
" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
"set exrc
set secure
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
set smartcase
" Highlight dynamically as pattern is typed
set incsearch
" Disable error bells
set novisualbell
set noerrorbells
if exists('&belloff')
    set belloff=all
endif
" Don't reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
set shortmess+=A                      " ignore annoying swapfile messages
set shortmess+=I                      " no splash screen
set shortmess+=O                      " file-read message overwrites previous
set shortmess+=T                      " truncate non-file messages in middle
set shortmess+=W                      " don't echo "[w]"/"[written]" when writing
set shortmess+=a                      " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=o                      " overwrite file-written messages
set shortmess+=t                      " truncate file messages at start
" Show the current mode
set showmode
" Show the filename in the window titlebar
" set title
" Show the (partial) command as it’s being typed
set showcmd
" Enable syntax highlighting
syntax on
"set max highlight column
set synmaxcol=300
" Start scrolling two lines before the horizontal window border when will this
" break
set scrolloff=2
set nolist wrap linebreak sidescrolloff=15
set listchars=tab:▸\ ,trail:·,eol:¬,extends:❯,precedes:❮
set showbreak=....
if exists('+breakindent')
    set breakindent
endif
if has('folding')
  if has('windows')
    set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  endif
endif
set nojoinspaces
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j  " remove comment leader when joining comment lines
endif
" sensible completion
set completeopt=longest,menuone
set ofu=syntaxcomplete#complete
" Enable line numbers
set relativenumber
set number
" Change mapleader
let mapleader=","
let localleader="/"
set tags ^=./.git/tags,./.tags,.tags
" Don't wrap searches
set nowrapscan
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif
set pastetoggle=<F1>
set path+=**
set switchbuf=usetab  " try to reuse windows/tabs when switching buffers
set cursorline

set laststatus=2
set statusline=\|\ %m\ %f\ %r\ \%y
set statusline+=\ ...loading

set fillchars+=fold:·
"}}}
"{{{ folding options
set foldmethod=marker
set foldcolumn=2
"}}}
"{{{ Make tabs as wide as four spaces
set smarttab
set smartindent
set autoindent
set shiftwidth=4
set shiftround
"tabs to spaces
set expandtab
"}}}
"{{{ netrw settings
"let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
""let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
"}}}
"{{{ buffer sanity
set hidden
set winwidth=85
set winheight=20
"}}}
"{{{ Wild ignore, mostly stolen from Steve Losh
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX

set wildignore+=*.luac                           " Lua byte code

set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code

set wildignore+=*.orig                           " Merge resolution files
set wildignore+=.cache,.neocomplcache,.npm,.gem
set wildignore+=node_modules,bower_components

"}}}
"{{{motions
"{{{ visual block mode is better that visual mode
nnoremap v <c-v>
nnoremap <c-v> v
vnoremap v <C-V>
vnoremap <C-V> v
inoremap <C-n> <C-x><C-o>
"}}}
"}}}
"{{{ Automatic commands
if has("autocmd")
    "{{{Augroup VimStartup:
    augroup VimStartup
        au!
        autocmd CursorHold,CursorHoldI,CmdlineLeave * if !exists('g:mappingsloaded') | packadd mappings | endif
        autocmd CursorHold,CursorHoldI,CmdlineLeave * if !exists('g:autocmdsloaded') | packadd autocmds | endif
    augroup END
    "}}}
endif
"}}}
"{{{ remap escape for easier access
nnoremap <leader>m <ESC>
vnoremap <leader>m <ESC>
inoremap <leader>m <ESC>
onoremap <leader>m <ESC>
cnoremap <leader>m <ESC>
nnoremap <m <ESC>
vnoremap <m <ESC>
inoremap <m <ESC>
onoremap <m <ESC>
cnoremap <m <ESC>
inoremap <M <ESC>
nnoremap <M <ESC>
vnoremap <M <ESC>
onoremap <M <ESC>
cnoremap <M <ESC>
"}}}
"{{{ save
nnoremap <leader>ss :w<CR>
nnoremap ss :w<CR>
inoremap <leader>ss <ESC>:w<CR>
vnoremap <leader>ss <ESC>:w<CR>
"}}}
"{{{ close but don't save
nnoremap <leader>cl <ESC>:close!
inoremap <leader>cl <ESC>:close!
vnoremap <leader>cl <ESC>:close!
"}}}
"{{{ close
nnoremap cl <ESC>:close
vnoremap cl <ESC>:close
"}}}
iabbrev *dp* [deploy:ProductionDigitalOcean]
if &diff
    nnoremap <C-q> :qa!<cr>
endif
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

cnoremap <expr> %% expand('%:h').'/'
