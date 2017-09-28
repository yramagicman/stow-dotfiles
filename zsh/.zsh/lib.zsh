#{{{ source and load aliases and plugins

function clone_if_needed() {
    split=("${(@s#/#)1}")
    if [[ ( ! -d "$MODULES_DIR/$split[1]" )  ]]; then
        if [[ -a $1 ]]; then
            return
        fi
        echo "$1 not found "
        read -k 1 -r \
            "REPLY?Do you want to clone it into $MODULES_DIR "
        if [[ $REPLY =~ ^[yY]$ ]]; then
            mkdir -p $MODULES_DIR/$split[1]
            echo
            git clone git@github.com:$split[1]/$split[2] $MODULES_DIR/$split[1]/$split[2]/
            echo
        fi
        # clean up if we don't clone anything. This won't delete directories
        # that arent empty'
        build_pkg_cache 2>/dev/null
        find $MODULES_DIR -type d -delete 2>/dev/null
        if [[ $(ls $MODULES_DIR | wc -l) -eq 0 ]]; then
            echo "nothing cloned"
            rm $MODULES_DIR/.plugins
        fi
    fi
}

function cache_pkg () {
    if [[ -f "$MODULES_DIR/$1/init.zsh" ]]; then
        echo "$MODULES_DIR/$1/init.zsh" >> $MODULES_DIR/.plugins
        source $MODULES_DIR/$1/init.zsh
        return
    elif [[  $( find $MODULES_DIR/$1/ -maxdepth 1 -name "*.plugin.zsh" 2> /dev/null ) ]]; then
        find $MODULES_DIR/$1/ -maxdepth 1 -name "*.plugin.zsh" >> $MODULES_DIR/.plugins
        source  $MODULES_DIR/$1/*.plugin.zsh
        return
    elif [[  $( find $MODULES_DIR/$1/ -maxdepth 1 -name "*.zsh" 2> /dev/null ) ]]; then
        find $MODULES_DIR/$1/ -maxdepth 1 -name "*.zsh" >> $MODULES_DIR/.plugins
        source  $MODULES_DIR/$1/*.zsh
        return
    elif [[  $( find $MODULES_DIR/$1/ -maxdepth 1 -name "*.zsh-theme" 2> /dev/null ) ]]; then
        find $MODULES_DIR/$1/ -maxdepth 1 -name "*.zsh-theme" >> $MODULES_DIR/.plugins
        source $MODULES_DIR/$1/*.zsh-theme
        return
    elif [[  $( find $MODULES_DIR/$1/ -maxdepth 1 -name "*.sh" 2> /dev/null ) ]]; then
        find $MODULES_DIR/$1/ -maxdepth 1 -name "*.sh" >> $MODULES_DIR/.plugins
        source $MODULES_DIR/$1/*.sh
        return
    elif [[ -a "$MODULES_DIR/$1" ]]; then
        echo "$MODULES_DIR/$1" >> $MODULES_DIR/.plugins
        source "$MODULES_DIR/$1"
        return
    elif [[ -f "$1" ]]; then
        echo "$1" >> $MODULES_DIR/.plugins
        source $1
        return
    else
        return
    fi

    sort -u  $MODULES_DIR/.plugins > $MODULES_DIR/.plug
    mv $MODULES_DIR/.plug $MODULES_DIR/.plugins
}

function clean_tmp_themes () {
    tmpthemedir="$HOME/.tmptheme"
    /usr/bin/rm -rf $tmpthemedir
}
function download_pkgs() {
    for p in $PACKAGES;
        do
            clone_if_needed $p
        done
}

function build_pkg_cache() {
    echo "caching"
    if [[ -f $MODULES_DIR/.plugins ]]; then
        /usr/bin/rm  $MODULES_DIR/.plugins
    fi
    for p in $PACKAGES;
        do
            cache_pkg $p
        done
}
function load_pkgs() {
    if [[ -f $MODULES_DIR/.plugins ]]; then
        for p in $( cat $MODULES_DIR/.plugins )
        do
            source $p
        done
    else
        build_pkg_cache
    fi
}

function reload_pkgs() {
    clean_tmp_themes
    /usr/bin/rm $MODULES_DIR/.plugins
    /usr/bin/rm -rf $MODULES_DIR/*
    clear
    source ~/.zshrc
}

function update_pkgs() {
    clean_tmp_themes
    cwd=$(pwd)
    for f in $(find $MODULES_DIR -maxdepth 3 -type d -name '.git')
        do
        builtin cd $f
        builtin cd ../
        echo "updating $(pwd)"
        git pull
        done
    builtin cd $cwd
}

function try_theme() {
    PROMPT=''
    RPROMPT=''
    split=("${(@s#/#)1}")
    cwd=$(pwd)
    tmpthemedir="$HOME/.tmptheme"
    mkdir -p $tmpthemedir
    builtin cd $tmpthemedir
    if [[ ! -a "$tmpthemedir/$split[5]" ]]; then
        git clone https://github.com/$split[4]/$split[5]
    fi
    echo
    if [[ $split[5] = 'prezto' ]]; then

        echo source $tmpthemedir/prezto/init.zsh
        echo source $tmpthemedir/prezto/modules/prompt/functions/prompt-pwd
        echo source $tmpthemedir/prezto/modules/prompt/functions/$split[-1]

        echo
        source $tmpthemedir/prezto/init.zsh
        source $tmpthemedir/prezto/modules/prompt/functions/prompt-pwd
        source $tmpthemedir/prezto/modules/prompt/functions/$split[-1]

    elif [[ $split[5] = 'oh-my-zsh' ]]; then

        echo source $tmpthemedir/oh-my-zsh/lib/spectrum.zsh # color support
        echo source $tmpthemedir/oh-my-zsh/lib/git.zsh # git support
        echo source $tmpthemedir/oh-my-zsh/lib/prompt_info_functions.zsh # rvm and ruby support
        echo source $tmpthemedir/oh-my-zsh/lib/nvm.zsh # nvm support
        echo source $tmpthemedir/oh-my-zsh/plugins/themes/themes.plugin.zsh # theming functions
        echo source $tmpthemedir/oh-my-zsh/themes/$split[-1] # theming functions
        echo
        source $tmpthemedir/oh-my-zsh/lib/spectrum.zsh # color support
        source $tmpthemedir/oh-my-zsh/lib/git.zsh # git support
        source $tmpthemedir/oh-my-zsh/lib/prompt_info_functions.zsh # rvm and ruby support
        source $tmpthemedir/oh-my-zsh/lib/nvm.zsh # nvm support
        source $tmpthemedir/oh-my-zsh/plugins/themes/themes.plugin.zsh # theming functions
        source $tmpthemedir/oh-my-zsh/themes/$split[-1] # theming functions

    fi

    builtin cd $cwd

}

download_pkgs
load_pkgs
#}}}
