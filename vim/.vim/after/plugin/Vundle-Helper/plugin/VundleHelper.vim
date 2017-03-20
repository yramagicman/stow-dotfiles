" --------------------------------
" Add our plugin to the path
" --------------------------------

python import sys
python import vim
python sys.path.append(vim.eval('expand("<sfile>:h")'))

" --------------------------------
"  Function(s)
" --------------------------------

function! VundleHelper#SelfUpdate()
python << endOfPython
from VundleHelper import VundleHelper_self_update
VundleHelper_self_update()
endOfPython
endfunction

function! VundleHelper#Install()
python << endOfPython
from VundleHelper import VundleHelper_run_install
VundleHelper_run_install()
endOfPython
endfunction

function! VundleHelper#Update()
python << endOfPython
from VundleHelper import VundleHelper_run_updates
VundleHelper_run_updates()
endOfPython
endfunction

function! VundleHelper#UpdateNotifyCheck()
python << endOfPython
from VundleHelper import VundleHelper_update_notify_check
VundleHelper_update_notify_check()
endOfPython
endfunction
" --------------------------------
"  Expose our commands to the user
" --------------------------------
command! VHInstall call VundleHelper#Install()
call VundleHelper#Install()
call feedkeys('<CR>')
call VundleHelper#UpdateNotifyCheck()

command! VHUpdate call VundleHelper#Update()

autocmd! CursorHold * call VundleHelper#UpdateNotify()
" Update VundleHelper on vim leave based on timing.
autocmd! VimLeavePre * call VundleHelper#Update()
autocmd! VimLeave *  call VundleHelper#SelfUpdate()

" Copyright Jonathan Gilson 2014
