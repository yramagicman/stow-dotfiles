"{{{ set status line
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
"}}}
"{{{always center when navigating
noremap G Gzz
noremap { {zz
noremap ( (zz
noremap } }zz
noremap ) )zz
noremap % %zz
noremap n nzz
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
" {{{ paste in insert mode
inoremap <leader>p <ESC>pa
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
"kill search highlighting
noremap <silent><leader><space> <ESC>:set nohlsearch<CR>
noremap / <ESC>:set hlsearch<CR>/
noremap n <ESC>:set hlsearch<CR>n
noremap N <ESC>:set hlsearch<CR>N
"uppercase words
inoremap <C-u> <ESC>mzgUiwea
nnoremap <C-u> <ESC>mzgUiwe
" Toggle [i]nvisible characters
nnoremap <silent><leader>I :set list!<CR>
" reset color scheme
nnoremap R :syntax sync fromstart<CR>:redraw!<CR>
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
iabbrev GIlson Gilson
"}}}
"{{{ insert blank lines in normal mode
nnoremap <leader>O O<ESC>j
nnoremap <leader>o o<ESC>k
"}}}
"{{{ Command line abbreviations
cnoreabbrev gab !git add %
cnoreabbrev ga !git add %
cnoreabbrev gac !git add %
cnoreabbrev ga% !git add %
cnoreabbrev gcm !git commit -m
cnoreabbrev gco !git checkout %
"}}}
"{{{ autoload functions
nnoremap <silent><leader>le :call functions#LineEndings()<CR>
nnoremap <Leader>f :call functions#FoldColumn()<CR>
command! Clean :call functions#CleanScreen()
command! Scratch :call functions#Scratch()
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
"{{{ Diff motions
nnoremap <leader>dn ]czt
nnoremap <leader>dp [czt

nnoremap ]c ]czt
nnoremap [c [czt
"}}}
let g:mappingsloaded = 1
