autocmd! VimEnter * if expand("%") == "" | e . | endif
set packpath+=~/.vim/pack/
