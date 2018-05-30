set packpath+=$HOME/.vim/pack/
set packpath+=$HOME/.vim/pack/vendor
function! s:sanity_check()
   if  exists("g:VimPack_Setup_Folders")
       for d in g:VimPack_Setup_Folders
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
    return split( globpath('$HOME/.vim/pack/vendor/start', '*'), '\n' )
endfunction


function! s:read_opt_dir()
    return split( globpath('$HOME/.vim/pack/vendor/opt', '*'), '\n' )
endfunction


let s:start_plugs = []
function! s:install_start_plugins(plug)
    let repo = split( a:plug, '/' )[0]
    let plug = split( a:plug, '/' )[1]
    let plug = plug[:-2]
    let destination = split( &packpath, ',')[-1] . '/start/'. plug
    call add(s:start_plugs, [destination, 'git clone --quiet --depth 4 https://github.com/'.repo[1:].'/'.plug . ' ' . destination])
endfunction

let s:opt_plugs = []

function! s:install_opt_plugins(plug)
    let repo = split( a:plug, '/' )[0]
    let plug = split( a:plug, '/' )[1]
    let plug = plug[:-2]
    let destination = split( &packpath, ',')[-1] . '/opt/'. plug
    call add(s:opt_plugs, [destination, 'git clone --quiet --depth 4  https://github.com/'.repo[1:].'/'.plug . ' ' . destination])
endfunction

function! s:install_opts()
    for package in s:opt_plugs
        if !isdirectory(package[0])
            let package_name = split(package[0], '/')[-1]
            echom 'installing '. package_name
            let j = job_start( ["/bin/sh", "-c", package[1]] )
        endif
    endfor
endfunction


function! s:install_start()
    for package in s:start_plugs
        if !isdirectory(package[0])
            let package_name = split(package[0], '/')[-1]
            echom 'installing '. package_name
            let j = job_start( ["/bin/sh", "-c", package[1]] )
        endif
    endfor
endfunction

function! s:clean_plugins()
    let start_in = []
    let start_list = []
    for p in s:start_plugs
        call add(start_list,  split(p[0], '/')[-1] )
    endfor

    for p in s:read_start_dir()
        call add(start_in,  split(p, '/')[-1] )
    endfor

    let opt_in = []
    let opt_list = []
    for p in s:opt_plugs
        call add(opt_list,  split(p[0], '/')[-1] )
    endfor

    for p in s:read_opt_dir()
        call add(opt_in,  split(p, '/')[-1] )
    endfor

    if len(start_in) != len(start_list)
        for q in start_in
            if index(start_list, q) == -1
                echom 'removing ' . q
                let path = '$HOME/.vim/pack/vendor/start/'
                echom join( systemlist('rm -rf '.path.q) )
            endif
        endfor
    else
    endif


    if len(opt_in) != len(opt_list)
        for p in opt_in
            if index(opt_list, p) == -1
                echom 'removing ' . q
                let path = '$HOME/.vim/pack/vendor/opt/'
                echom join( systemlist('rm -rf '.path.p) )
            endif
        endfor
    else

    endif
endfunction

function! s:update_one(plug)
    echom 'updating ' . a:plug
    let cmd = 'cd ' . a:plug ." && git pull"
    let j = job_start(["/bin/sh", "-c", cmd])
    return j
endfunction

function! s:update_all()
    let opt_jobs = []
    let start_jobs = []
    for path in s:read_opt_dir()
        call add(opt_jobs,  s:update_one(path))
    endfor

    while len(opt_jobs)
        for job in opt_jobs
            if job_status(job) != 'run'
                call remove(opt_jobs, index(opt_jobs, job))
            endif
        endfor
    endwhile
    for path in s:read_start_dir()
        call add(start_jobs,  s:update_one(path))
    endfor

    while len(start_jobs)
        for work in start_jobs
            if job_status(work) != 'run'
                call remove(start_jobs, index(start_jobs, work))
            endif
        endfor
    endwhile
endfunction

function! s:do_update()
    if exists('g:VimPack_Update_Frequency')
        let oneday = 24 * 60 * 60
        let today = split( system('date +%s') )[0]
        if filereadable($HOME.'/.vim/lastupdate')
            let updatetime = readfile($HOME.'/.vim/lastupdate')[1]
            if today > updatetime
                autocmd! VimLeavePre * call s:update_all()
                autocmd! CursorHold * echom 'updating on close'

                let nextupdate = today + (oneday * g:VimPack_Update_Frequency)
                call writefile([today], $HOME.'/.vim/lastupdate')
                call writefile([nextupdate], $HOME.'/.vim/lastupdate', "a")
                return
            endif
        else
            autocmd! VimLeavePre * call s:update_all()
            autocmd! CursorHold * echom 'updating on close'
            let nextupdate = today + (oneday * g:VimPack_Update_Frequency)
            call writefile([today], $HOME.'/.vim/lastupdate')
            call writefile([nextupdate], $HOME.'/.vim/lastupdate', "a")
            return
        endif
    else
        let g:VimPack_Update_Frequency = 30
        call s:do_update()
    endif
endfunction

function! s:install_all()
    call s:sanity_check()
    call s:install_opts()
    call s:install_start()
    silent! helptags ALL
    echom ''
endfunction

function! pack#load()
    autocmd VimEnter *  call s:sanity_check()
    autocmd VimEnter *  call s:do_update()
    command! -nargs=+ PlugOpt call s:install_opt_plugins(<f-args>)
    command! -nargs=+ PlugStart call s:install_start_plugins(<f-args>)
    command! PlugInstall  call s:install_all()
    command! PlugClean  call s:clean_plugins()
    command! PlugUpdate  call s:update_all()
endfunction

autocmd VimEnter *  call s:sanity_check()
if exists('g:VimPack_Auto_Install')
    autocmd BufEnter *  call s:install_all() | redraw
endif
if exists('g:VimPack_Auto_Update')
    autocmd BufEnter *  call s:do_update()
endif
