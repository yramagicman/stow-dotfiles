let b:ale_linters=['phpcs']
let b:ale_linters=['phpcs']
let g:ale_php_phpcs_standard='PSR2'
function! Runtests()
    normal :wa
    normal :!./vendor/bin/phpunit ./tests/Unit/*

endfunction
nnoremap <F5> :wa<cr>:!( arclear > /dev/null 2>&1) && ./vendor/bin/phpunit $(find ./tests/Unit -type f -name '*.php')<cr>
