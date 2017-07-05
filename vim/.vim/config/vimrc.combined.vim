"{{{ defaults
"{{{ set secondary editor
let g:Gui_Editor = 'geany'
"}}}
"{{{setup stuff, for install plugin
let g:VundleHelper_Setup_Folders = ['after', 'autoload', 'backup', 'colors', 'config', 'doc', 'snippets', 'spell', 'swaps', 'syntax', 'tags', 'undo']
let g:VundleHelper_Plugin_File =  '/.vim/config/extensions/vundle.vim'
let g:VundleHelper_Update_Frequency = 5
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
" text-width
" For some reason this doesn't work on everything. I've hacked around it with an
" autocmd further down the file.
set textwidth=80
"Use os clipboard with mac
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
set title
" Highlight current line
""set cursorline
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
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
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
" Show "invisible” characters
set lcs=tab:⟩\ ,trail:·,eol:↩,nbsp:_
"set list " breaks set linebreak
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
"}}}
"{{{ Make tabs as wide as four spaces
set tabstop=4
set smarttab
set smartindent
set autoindent
set shiftwidth=4
set shiftround
"tabs to spaces
set expandtab
"}}}
"{{{ set status line
" Always show status line
let f=system('[[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"')
let b=system('git branch 2>/dev/null | grep \* | sed "s/\*//g"')
let c=split(b, '')
set laststatus=2
set statusline=\|\ %m\ %f\ %r\ \%y
set statusline+=\ \%{c[0]}
set statusline+=%{f[0]}
set statusline+=%=
set statusline+=Line:
set statusline+=%4l/%-4L
set statusline+=\ Column\ %2c
set statusline+=\ \|
"}}}
"{{{ netrw settings
"let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_banner=0        " disable annoying banner
""let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
":let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
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
set switchbuf=usetab  " try to reuse windows/tabs when switching buffers
set whichwrap=b,h,l,s,<,>,[,],~       " allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries
"}}}
"{{{motions
"{{{ kill arrow keys
nnoremap <down> <C-d>
nnoremap <left> <Nop>
nnoremap <up> <C-u>
nnoremap <right> <Nop>
inoremap <right> <Nop>
inoremap <down> <Nop>
inoremap <left> <Nop>
inoremap <up> <Nop>
vnoremap <left> <Nop>
vnoremap <down> <C-d>
vnoremap <right> <Nop>
vnoremap <up> <C-u>
"}}}
"{{{always center when navigating
noremap G Gzz
noremap { {zz
noremap ( (zz
noremap } }zz
noremap ) )zz
noremap % %zz
noremap <Tab> <Tab>zz
"}}}
"{{{ jump to ...
nnoremap <leader>j J
vnoremap <leader>j J
"}}}
"{{{ command line movement mappings
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-e>  <End>
"}}}
"{{{ Substitute word under cursor globally
nnoremap --r :%s/\<<C-r><C-w>\>//g<Left><Left>
" ask for confirmation
nnoremap -r :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
nnoremap -gd :grep -R <C-r><C-w> ./
nnoremap -gl :grep <C-r><C-w> ./*
"}}}
"{{{ Substitute selection globally
vnoremap --r y<Esc>:%s/<C-r>"//g<Left><Left>
" ask for confirmation
vnoremap -r y<Esc>:%s/<C-r>"//gc<Left><Left><Left>
"}}}
"{{{ visual block mode is better that visual mode
nnoremap v <c-v>
nnoremap <c-v> v
vnoremap v <C-V>
vnoremap <C-V> v
"}}}
"{{{ Diff motions
nnoremap <leader>dn ]czt
nnoremap <leader>dp [czt
"}}}
"}}}
"{{{ Automatic commands
if has("autocmd")
    "{{{Augroup VimStartup:
    augroup VimStartup
        au!
        au VimEnter * if expand("%") == "" | e . | endif

    augroup END
    "}}}
    augroup general
        autocmd!
        "{{{ Status line
        autocmd BufEnter,BufWritePost,ShellCmdPost * let f=system('[[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"')
        autocmd VimEnter,BufEnter,ShellCmdPost * let b=system('git branch 2>/dev/null | grep \* | sed "s/\*//g"')
        autocmd VimEnter,BufEnter,ShellCmdPost * let c=split(b, '')
        "}}}
        "{{{ show cursorline on current buffer only
        autocmd BufEnter * set cursorline
        autocmd BufLeave * set nocursorline
        "}}}
        "{{{ auto-reload vim files, auto resize splits on window resize
        autocmd BufWritePost $HOME/.vim/config/* :source %
        autocmd BufWritePost $HOME/.vim/config/* :set visualbell
        autocmd BufWritePost $HOME/.vim/config/* :set foldmethod=marker
        autocmd BufWritePost $HOME/.vimrc :source %
        autocmd BufWritePost $HOME/.vimrc :set visualbell
        autocmd BufWritePost $HOME/.vimrc :set foldmethod=marker
        autocmd VimResized * exe "normal! \<c-w>="
        autocmd VimEnter * set vb t_vb=
        "}}}
        "{{{ fold method marker for specific files
        autocmd FileType vim setlocal foldmethod=marker
        autocmd FileType zsh setlocal foldmethod=marker
        autocmd FileType lua setlocal foldmethod=marker
        autocmd FileType muttrc setlocal foldmethod=marker
        autocmd FileType conf setlocal foldmethod=marker
        "}}}
        "{{{ Saving
        autocmd BufEnter,BufWritePre * silent! checktime
        autocmd BufLeave,BufWritePre * silent! call functions#StripWhitespace()
        autocmd BufLeave,BufWritePre * silent! call functions#Knl()
        autocmd BufLeave,BufWritePre * silent! call functions#LineEndings()
        autocmd BufLeave,BufWritePre * silent! %retab
        autocmd BufLeave,BufWritePre *.py silent! %s/#\w/# &/g
        autocmd BufLeave,BufWritePre *.py silent! %s/# #/# /g
        autocmd BufLeave,BufWritePre *.js silent! %s/\/\/\w/\/\/ &/g
        autocmd BufLeave,BufWritePre *.js silent! %s/\/\/ \/\//\/\/ /g
        autocmd BufLeave,CursorHold * silent! if @% != ''| silent! w
        autocmd BufEnter,FileType * if &ft != 'qf' | nnoremap <CR> @@ | else | nnoremap <CR> <CR> | endif
        "}}}
    augroup end
    augroup js
        "{{{ Treat Leave files as .js
        autocmd!
        autocmd BufLeave,BufRead *.json setfiletype json syntax=javascript
        "}}}
    augroup end
    augroup coding
        autocmd!
        "{{{ scheme coding standards
        autocmd BufEnter,BufRead scheme set tabstop=2
        autocmd BufEnter,BufRead scheme set smartindent
        autocmd BufEnter,BufRead scheme set shiftwidth=2
        autocmd BufEnter,BufRead scheme set expandtab
        "}}}
    augroup end
    augroup extra
        "{{{ Misc. individual commands that don't merit their own fold group
        autocmd!
        autocmd FileType mail set spell
        autocmd FileType make set noexpandtab
        autocmd FileType,BufEnter snippets set noexpandtab
        autocmd BufNewFile,BufRead *.md set filetype=markdown
        autocmd BufEnter * execute "source ~/.vim/colors/" . g:colors_name . ".vim"
        " make Vim edit cron again
        autocmd BufEnter /private/tmp/crontab.* setl backupcopy=yes
        " always reload files when changed outside Vim
        "autocmd CursorHold,CursorMovedI,CursorMoved,Bufenter * :checktime
        autocmd Bufenter,FocusGained,BufLeave * :checktime
        " save on focus lost
        autocmd FocusLost,BufLeave * :silent! wall
        " leave insert mode on focus lost
        autocmd FocusLost,BufLeave * call feedkeys("\<ESC>")
        autocmd FileType * set textwidth=80
        autocmd FileType mail set textwidth=0
        " }}}
    augroup end
endif
"}}}
"{{{matchbrackets
"{{{ visual mode surround text
vnoremap ' xi''<ESC>hp<ESC>f'
vnoremap " xi""<ESC>hp<ESC>f"
vnoremap { xi{}<ESC>hp<ESC>f}
vnoremap [ xi[]<ESC>hp<ESC>f]
vnoremap ( xi()<ESC>hp<ESC>F(
vnoremap } xi{}<ESC>hp<ESC>f}
vnoremap ] xi[]<ESC>hp<ESC>f]
vnoremap ) xi()<ESC>hp<ESC>F(i
"}}}
"{{{ autocomplete quotes and brackets
inoremap (  ()<Left>
inoremap [  []<Left>
inoremap {  {}<Left>
inoremap <  <><Left>
inoremap [<CR> [<CR>]<ESC>O
inoremap (<CR> (<CR>)<ESC>O
inoremap {<CR> {<CR>}<ESC>O
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>": "]"
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> >  strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
"}}}
"{{{ filetype specific mappings for characters and shortcuts
augroup abbrevs
    autocmd!
    autocmd FileType * iabbrev <buffer> api API
    autocmd FileType * iabbrev <buffer> iso ISO
    autocmd FileType * iabbrev <buffer> csv CSV
    autocmd FileType * iabbrev <buffer> etap Etapestry
    autocmd FileType * iabbrev <buffer> durpal Drupal
    autocmd FileType * iabbrev <buffer> drupal Drupal
    autocmd FileType mail,text,gitcommit,scheme inoremap <buffer> ' '
    autocmd FileType html vnoremap <buffer> < xi<<ESC>pa<ESC>la
    autocmd FileType html,vim inoremap <<CR> <<CR>><ESC>O
    autocmd FileType html,vim inoremap <expr> >  strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"
    autocmd FileType php  iabbrev <buffer> pp> print '<pre>';
    autocmd FileType php  iabbrev <buffer> cpp> print '</pre>';
    autocmd FileType vim inoremap <buffer> " "
augroup end
"}}}
"{{{ Make backspace work nicely with autopairs
function! Backspace()
    let l:current = strpart(getline('.'), col('.')-1, 1)
    let l:prev = strpart(getline('.'), col('.')-2, 1)
    if l:current == '"' || l:current == "'" || l:current == "]" || l:current == ")" || l:current == "}" || l:current == ">"
        if l:current == l:prev
            return "\<Right>\<BS>\<BS>"
        elseif l:prev == '[' && l:current == ']'
            return "\<Right>\<BS>\<BS>"
        elseif l:prev == "{" && l:current == "}"
            return "\<Right>\<BS>\<BS>"
        elseif l:prev == "(" && l:current == ")"
            echom 'bs'
            return "\<Right>\<BS>\<BS>"
        elseif l:prev == "<" && l:current == ">"
            return "\<Right>\<BS>\<BS>"
        else
            return "\<BS>"
        endif
    else
        return "\<BS>"
    endif
endfunction
inoremap <expr> <BS> Backspace()
"}}}
"{{{ Unwrap parens and brackets
function! UnwrapParens()
    let l:current = strpart(getline('.'), col('.')-1, 1)
    if  l:current == "]" || l:current == ")" || l:current == "}" || l:current == "[" || l:current == "(" || l:current == "{" || l:current == "<" || l:current == ">"
        norm ml%mkx`lx
    endif
    if l:current == '"'
        try
            norm mlf"mkx`lx
        catch
            norm mlF"mkx`lx
        endtry
    endif
    if l:current == "'"
        try
            norm mlf'mkx`lx
        catch
            norm mlF'mkx`lx
        endtry
    endif
endfunction
inoremap <localleader><BS> <Esc>:call UnwrapParens()<CR>
noremap <leader>x :call UnwrapParens()<CR>
"}}}
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
"{{{saving
"{{{ control whitespace and tabs on save
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
"{{{ save and quit
nnoremap <silent><leader>wq :wqa<CR>
inoremap <silent><leader>wq <ESC>:wqa<CR>
vnoremap <silent><leader>wq <ESC>:wqa<CR>
"}}}
"{{{ quit without saving
nnoremap <leader>Q :q!
inoremap <leader>Q <ESC>:q!
vnoremap <leader>Q <ESC>:q!
nnoremap QQ :q!
command! QQ :q!
"}}}
"{{{ nice quit
nnoremap <silent><leader>q :q<CR>
inoremap <silent><leader>q <ESC>:q<CR>
vnoremap <silent><leader>q :q<CR>
"}}}
"{{{ sanity mappings
nnoremap qq :wq
nnoremap qw :wq
nnoremap cl :close<CR>
inoremap q q
inoremap qq qq
"}}}
"}}}
"{{{folding
nnoremap <Leader>z zMzvzz
nnoremap <Leader><Leader>z zMzOzz
"{{{ folding options
set foldmethod=indent
set foldcolumn=2
set foldlevel=100
"}}}
"}}}
"{{{mappings
"{{{file navigation shortcuts
nnoremap <silent> <leader>ev :e ~/.vim/config/vimrc.combined.vim<CR>
nnoremap <silent> <leader>pe :e ~/.vim/config/extensions<CR>
noremap <leader>rl <ESC>:source ~/.vimrc<CR>:set visualbell<CR>
"}}}
"{{{ Make Vim work logically
"paste in insert mode
inoremap <leader>p <ESC>pa
" delete till the beginning of a line
nnoremap <leader>D d0
inoremap <leader>D <ESC>d0xi
"repeat last command
nnoremap <leader>! @:
"}}}
"{{{ Formatting, TextMate-style
nnoremap Q gqip
vnoremap Q gq
" Reformat line.
nnoremap Ql gqq
"}}}
"{{{ Convenience bindings
" highlight test
nnoremap <c-\> :so $VIMRUNTIME/syntax/hitest.vim<CR>
" Save a file as root ('W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>
"delete blank lines
noremap <localleader>db :g/^$/d<ESC>:let @/ = ""<CR>
" delete duplicate blank lines
noremap <leader>db mz:%!cat -s<CR>`z
" toggle word wrap
noremap <silent><leader>w <ESC>:set wrap!<CR>
inoremap <silent><leader>w <ESC>:set wrap!<CR>i
"toggle file explorer
noremap <silent><leader>e <ESC>:Explore<CR>
"retab
noremap <leader>r <ESC>:%retab<CR>
"kill search highlighting
noremap <silent><leader><space> <ESC>:let @/ = ""<CR>
"uppercase words
inoremap <C-u> <ESC>mzgUiwea
nnoremap <C-u> <ESC>mzgUiwe
" Toggle [i]nvisible characters
nnoremap <silent><leader>I :set list!<CR>
" reset color scheme
nnoremap U :syntax sync fromstart<CR>:redraw!<CR>

nnoremap <leader>cd :lcd %:p:h<CR>
"}}}
"{{{ spelling mappings
nnoremap --s :set spell!<CR>
nnoremap -s zg
nnoremap -d ]szo
nnoremap -a [szo
nnoremap -w 1z=
nnoremap --w z=
"}}}
"{{{ I've needed these mappings forever. Map '; to ; and ": to , also quickfix
" last search
nnoremap  qf :execute 'vimgrep /' .@/.'/g %'<CR>:copen<CR>
nnoremap '; ;
nnoremap ": ,

iabbrev JOnathan Jonathan
"}}}
"{{{ insert blank lines in normal mode
nnoremap <leader>O O<ESC>j
nnoremap <leader>o o<ESC>k
"}}}
"{{{ Command line abbreviations
cnoreabbrev clam Clam
cnoreabbrev tw Tw
cnoreabbrev gab !git add %
cnoreabbrev ga !git add %
cnoreabbrev gac !git add %
cnoreabbrev ga% !git add %
cnoreabbrev gcm !git commit -m
cnoreabbrev b ls<CR> :b
"}}}
"{{{ autoload functions
nnoremap <silent><leader>le :call functions#LineEndings()<CR>
nnoremap <Leader>f :call functions#FoldColumn()<CR>
command! Clean :call functions#CleanScreen()
command! Scratch :call functions#Scratch()
command! Fc :call functions#FoldColumn()
command! Tw :call functions#Tw()
"}}}
"}}}
"{{{splits
"{{{window navigation & and splits
noremap <C-l> <C-w>l
noremap <C-j> <C-w>j
noremap <C-h> <C-w>h
noremap <C-k> <C-w>k
noremap <C-w>m :call functions#Maximize()<CR>
"window stuff
set equalalways
noremap <localleader>= <C-w>=
"}}}
"{{{ put splits in a logical place
set splitbelow
set splitright
"}}}
"}}}
"{{{ Regisers
let @r = "/returnO,mjo,m"
let @d = "ddn"
let @s = "vi["
let @p = "vi("
let @c = "vi{"
let @q = "vi'"
let @b = 'vi"'
let @a = "vi<"
let @u = "dt(,x"
let @v = '0/\u~hi_, '
let @q = ':wq'
"}}}
"
inoremap <C-n> <C-x><C-o>
