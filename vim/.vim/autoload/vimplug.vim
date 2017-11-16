set packpath+=$HOME/.vim/pack/
set packpath+=$HOME/.vim/pack/vendor
function! s:sanity_check()
   if  exists("g:VimPlug_Setup_Folders")
       for d in g:VimPlug_Setup_Folders
           if !isdirectory($HOME.'/.vim/'.d)
               call mkdir($HOME.'/.vim/'.d)
           endif
       endfor
   endif

    for d in split(&packpath, ',')
        if !isdirectory(d)
            silent! call mkdir(d)
        endif
    endfor
    if !isdirectory($HOME.'/.vim/pack/vendor/opt')
        silent! call mkdir($HOME.'/.vim/pack/vendor/opt')
    endif

    if !isdirectory($HOME.'/.vim/pack/vendor/start')
        silent! call mkdir($HOME.'/.vim/pack/vendor/start')
    endif
endfunction


function! s:read_start_dir()
    return systemlist('ls $HOME/.vim/pack/vendor/start')
endfunction


function! s:read_opt_dir()
    return  systemlist('ls $HOME/.vim/pack/vendor/opt')
endfunction


let s:start_plugs = []
function! s:install_start_plugins(plug)
    let repo = split( a:plug, '/' )[0]
    let plug = split( a:plug, '/' )[1]
    let plug = plug[:-2]
    let destination = split( &packpath, ',')[-1] . '/start/'. plug

    call add(s:start_plugs, ['$HOME/.vim/pack/vendor/opt/'. plug, 'git clone --quiet https://github.com/'.repo[1:].'/'.plug . ' ' . destination])
endfunction

let s:opt_plugs = []

function! s:install_opt_plugins(plug)
    let repo = split( a:plug, '/' )[0]
    let plug = split( a:plug, '/' )[1]
    let plug = plug[:-2]
    let destination = split( &packpath, ',')[-1] . '/opt/'. plug

    call add(s:opt_plugs, ['$HOME/.vim/pack/vendor/opt/'. plug, 'git clone --quiet  https://github.com/'.repo[1:].'/'.plug . ' ' . destination])

endfunction

function! s:install_opts()
    for package in s:opt_plugs
        if !isdirectory(package[0])
            let package_name = split(package[0], '/')[-1]
            echom 'installing '. package_name
            let j =  job_start( package[1] )
        endif
    endfor
endfunction


function! s:install_start()
    for package in s:start_plugs
        if !isdirectory(package[0])
            let package_name = split(package[0], '/')[-1]
            echom 'installing '. package_name
            let j = job_start( package[1] )
        endif
    endfor
endfunction

function! s:clean_plugins()
    let start_in = s:read_start_dir()
    let start_list = []
    for p in s:start_plugs
        call add(start_list, split( p[0], '/' )[-1][:-1])
    endfor

    let opt_in = s:read_opt_dir()
    let opt_list = []
    for p in s:opt_plugs
        call add(opt_list, split( p[0], '/' )[-1])
    endfor
    if len(start_in) != len(start_list)
        echom "cleaning"
        for p in start_in
            if index(start_list, p) == -1
                echom join( systemlist('rm -rfv $HOME/.vim/pack/vendor/start/'.p) )
            endif
        endfor
    endif

endfunction

function! s:update()
    if exists('g:VimPlug_Update_Frequency')
        let oneday = 24 * 60 * 60
        let today = split( system('date +%s') )[0]
        if filereadable($HOME.'/.vim/lastupdate')
            let updatetime = readfile($HOME.'/.vim/lastupdate')[1]
            if today > updatetime
                autocmd VimLeave * PlugUpdate
                autocmd CursorHold * echom 'updating on close'

                let nextupdate = today + (oneday * g:VimPlug_Update_Frequency)
                call writefile([today], $HOME.'/.vim/lastupdate')
                call writefile([nextupdate], $HOME.'/.vim/lastupdate', "a")
                return
            endif
        else
            autocmd VimLeave * PlugUpdate
            autocmd CursorHold * echom 'updating on close'
            let nextupdate = today + (oneday * g:VimPlug_Update_Frequency)
            call writefile([today], $HOME.'/.vim/lastupdate')
            call writefile([nextupdate], $HOME.'/.vim/lastupdate', "a")
            return
        endif
    else
        let g:VimPlug_Update_Frequency = 30
        call s:update()
    endif
endfunction
function! s:install_all()
    call s:sanity_check()
    call s:install_opts()
    call s:install_start()
    silent! helptags ALL
    echom ''
endfunction
function! vimplug#load()
    autocmd VimEnter *  call s:sanity_check()
    command! -nargs=+ PlugOpt call s:install_opt_plugins(<f-args>)
    command! -nargs=+ PlugStart call s:install_start_plugins(<f-args>)
    command! PlugInstall  call s:install_all()
    command! PlugClean  call s:clean_plugins()
endfunction
