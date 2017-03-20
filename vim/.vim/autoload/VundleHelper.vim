function! VundleHelper#UpdateNotify()
if !exists('g:VundleHelperNotified') && exists('g:VundleHelperUpdateNotify')
    echom 'Updating plugins on close'
    let g:VundleHelperNotified = 1
endif
endfunction
