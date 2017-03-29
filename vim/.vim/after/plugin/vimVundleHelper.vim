function! VundleHelper_sanity_check()
   if  exists("g:VundleHelper_Setup_Folders")
       for d in g:VundleHelper_Setup_Folders
           if !isdirectory($HOME.'/.vim/'.d)
               call mkdir($HOME.'/.vim/'.d)
           endif
       endfor
   endif
endfunction

function! VundleHelper_install_vundle()
    if !isdirectory($HOME.'/.vim/bundle/Vundle.vim')
        chdir $HOME/.vim/bundle/
        pwd
        let message =  system('git clone https://github.com/gmarik/Vundle.vim.git')
        source $HOME/.vimrc
    endif
endfunction

function! VundleHelper_read_plugins()
    if exists("g:VundleHelper_Plugin_File")
        let names = []
        for l in readfile($HOME.g:VundleHelper_Plugin_File)
            if split(l)[0] == 'Plugin'
                let plugin = split(l)[1]
                if len(split(plugin, '/')) == 2
                    let n = split(plugin, '/')[1]
                    let name = split(n, "'")[0]
                    call add(names, name)
                else
                    let n = split(plugin, '/')[0]
                    let name = split(n, "'")[0]
                    call add(names, name)
                endif
            endif
        endfor
        return names
    endif
endfunction

function! VundleHelper_read_plugin_dir()
    return systemlist('ls $HOME/.vim/bundle')
endfunction

function! VundleHelper_install_plugins()
    let added = []
    let installed = VundleHelper_read_plugin_dir()
    let listed = VundleHelper_read_plugins()
    for l in listed
        if index(installed, l) == -1
            call add(added, l)
        endif
    endfor
    if len(added) > 0
        execute 'PluginInstall'
    endif
endfunction

function! VundleHelper_clean_plugins()
    let installed = VundleHelper_read_plugin_dir()
    let listed = VundleHelper_read_plugins()
    let removed = []
    for l in installed
        if index(listed, l) == -1
            call add(removed, l)
        endif
    endfor

    if len(removed) > 0
        execute 'PluginClean'
    endif
endfunction

function! VundleHelper_update()
    if exists('g:VundleHelper_Update_Frequency')
        let oneday = 24 * 60 * 60
        let today = split( system('date +%s') )[0]
        if filereadable($HOME.'/.vim/lastupdate')
            let updatetime = readfile($HOME.'/.vim/lastupdate')[1]
            if today > updatetime
                autocmd VimLeave * PluginUpdate
                autocmd CursorHold * echom 'updating on close'

                let nextupdate = today + (oneday * g:VundleHelper_Update_Frequency)
                call writefile([today], $HOME.'/.vim/lastupdate')
                call writefile([nextupdate], $HOME.'/.vim/lastupdate', "a")
                return
            endif
        else
            autocmd VimLeave * PluginUpdate
            autocmd CursorHold * echom 'updating on close'
            let nextupdate = today + (oneday * g:VundleHelper_Update_Frequency)
            call writefile([today], $HOME.'/.vim/lastupdate')
            call writefile([nextupdate], $HOME.'/.vim/lastupdate', "a")
            return
        endif
    else
        let g:VundleHelper_Update_Frequency = 30
        call VundleHelper_update()
    endif
endfunction

autocmd VimEnter * silent! call VundleHelper_sanity_check()
autocmd VimEnter * silent! call VundleHelper_install_vundle()
autocmd VimEnter * silent! call VundleHelper_update()
autocmd VimEnter * silent! call VundleHelper_install_plugins()
autocmd VimEnter * silent! call VundleHelper_clean_plugins()
