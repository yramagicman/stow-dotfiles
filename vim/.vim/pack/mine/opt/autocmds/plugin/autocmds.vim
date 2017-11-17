augroup mine
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
    autocmd FileType,BufEnter vim setlocal foldmethod=marker
    autocmd FileType,BufEnter zsh setlocal foldmethod=marker
    autocmd FileType,BufEnter lua setlocal foldmethod=marker
    autocmd FileType,BufEnter muttrc setlocal foldmethod=marker
    autocmd FileType,BufEnter conf setlocal foldmethod=marker
    "}}}
    "{{{ Saving
    autocmd BufEnter,BufWritePre,CursorHold * silent! checktime
    autocmd BufLeave,BufWritePre,CursorHold * silent! call functions#StripWhitespace()
    autocmd BufLeave,BufWritePre * silent! call functions#Knl()
    autocmd BufLeave,BufWritePre * silent! call functions#LineEndings()
    autocmd BufLeave,BufWritePre,CursorHold * silent! %retab
    autocmd BufLeave,BufWritePre,CursorHold *.py silent! %s/#\w/# &/g
    autocmd BufLeave,BufWritePre,CursorHold *.py silent! %s/# #/# /g
    autocmd BufLeave,CursorHold * silent! if @% != ''| silent! wall
    autocmd BufEnter,FileType * if &ft != 'qf' | nnoremap <CR> @@ | else | nnoremap <CR> <CR> | endif
    "}}}
    "{{{ Treat Leave files as .js
    autocmd BufLeave,BufRead *.json setfiletype json syntax=javascript
    "}}}
    "{{{ scheme coding standards
    autocmd BufEnter,BufRead scheme set tabstop=2
    autocmd BufEnter,BufRead scheme set smartindent
    autocmd BufEnter,BufRead scheme set shiftwidth=2
    autocmd BufEnter,BufRead scheme set expandtab
    "}}}
    "{{{ Misc. individual commands that don't merit their own fold group
    autocmd FileType mail set spell
    autocmd FileType make set noexpandtab
    autocmd FileType,BufEnter snippets set noexpandtab
    autocmd BufNewFile,BufRead *.md set filetype=markdown
    autocmd BufEnter * execute "source ~/.vim/colors/" . g:colors_name . ".vim"
    " make Vim edit cron again
    autocmd BufEnter /private/tmp/crontab.* setl backupcopy=yes
    " always reload files when changed outside Vim
    autocmd CursorHold,CursorMovedI,CursorMoved,Bufenter * :checktime
    autocmd Bufenter,FocusGained,BufLeave * :checktime
    " save on focus lost
    autocmd FocusLost,BufLeave * :silent! wall
    " leave insert mode on focus lost
    autocmd FocusLost,BufLeave * call feedkeys("\<ESC>")
    autocmd FileType * set textwidth=80
    autocmd FileType mail set textwidth=0
    " }}}
augroup end

doautocmd FileType
let g:autocmdsloaded = 1
