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
"{{{folding
nnoremap <Leader>z zMzvzz
nnoremap <Leader><Leader>z zMzOzz
"{{{ folding options
set foldmethod=indent
set foldcolumn=2
"}}}
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
"{{{mappings
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
"kill search highlighting
noremap <silent><leader><space> <ESC>:let @/ = ""<CR>
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
cnoreabbrev find ls<CR> :find
"}}}
"{{{ autoload functions
nnoremap <silent><leader>le :call functions#LineEndings()<CR>
nnoremap <Leader>f :call functions#FoldColumn()<CR>
command! Clean :call functions#CleanScreen()
command! Scratch :call functions#Scratch()
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
"}}}
let g:mappingsloaded = 1
