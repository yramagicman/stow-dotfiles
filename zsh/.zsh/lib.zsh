#{{{ source and load aliases and plugins

function clone_if_needed() {
    split=("${(@s#/#)1}")
    if [[ ( ! -d "$CONFIG_DIR/$split[1]" )  ]]; then
        if [[ -a $1 ]]; then
            return
        fi
        echo "$1 not found "
        read -k 1 -r \
            "REPLY?Do you want to clone it into $CONFIG_DIR "
        if [[ $REPLY =~ ^[yY]$ ]]; then
            mkdir -p $CONFIG_DIR/$split[1]
            echo
            git clone git@github.com:$split[1]/$split[2] $CONFIG_DIR/$split[1]/$split[2]/
            echo
        fi
    fi
}

function source_pkg() {
    if [[ -f "$CONFIG_DIR/$1/init.zsh" ]] then
        source $CONFIG_DIR/$1/init.zsh
        return
    elif [[  $( find $CONFIG_DIR/$1/ -maxdepth 1 -name "*.plugin.zsh" 2> /dev/null ) ]] then
        source  $CONFIG_DIR/$1/*.plugin.zsh
        return
    elif [[  $( find $CONFIG_DIR/$1/ -maxdepth 1 -name "*.zsh" 2> /dev/null ) ]] then
        source  $CONFIG_DIR/$1/*.zsh
        return
    elif [[  $( find $CONFIG_DIR/$1/ -maxdepth 1 -name "*.zsh-theme" 2> /dev/null ) ]] then
        source $CONFIG_DIR/$1/*.zsh-theme
        return
    elif [[  $( find $CONFIG_DIR/$1/ -maxdepth 1 -name "*.sh" 2> /dev/null ) ]] then
        source $CONFIG_DIR/$1/*.sh
        return
    elif [[ -a "$CONFIG_DIR/$1" ]] then
        source "$CONFIG_DIR/$1"
        return
    else
        source $1
    fi
}


function clean_tmp_themes () {
    tmpthemedir="$HOME/.tmptheme"
    /usr/bin/rm -rf $tmpthemedir
}
function download_pkgs() {
    clean_tmp_themes
    for p in $PACKAGES;
        do clone_if_needed $p
        done
}

function load_pkgs() {
    clean_tmp_themes
    for p in $PACKAGES;
        do source_pkg $p
        done
}

function reload_pkgs() {
    clean_tmp_themes
    /usr/bin/rm -rf $CONFIG_DIR/*
    clear
    source ~/.zshrc
}


function update_pkgs() {
    clean_tmp_themes
    cwd=$(pwd)
    for f in $(find $CONFIG_DIR -maxdepth 3 -type d -name '.git')
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
    if [[ ! -a "$tmpthemedir/$split[5]" ]] then
        git clone https://github.com/$split[4]/$split[5]
    fi
    echo
    if [[ $split[5] = 'prezto' ]] then

        echo source  $tmpthemedir/prezto/modules/prompt/functions/prompt-pwd
        echo source $tmpthemedir/prezto/modules/prompt/functions/$split[-1]

        source  $tmpthemedir/prezto/modules/prompt/functions/prompt-pwd
        source $tmpthemedir/prezto/modules/prompt/functions/$split[-1]
    elif [[ $split[5] = 'oh-my-zsh' ]] then


        echo source $tmpthemedir/oh-my-zsh/lib/spectrum.zsh # color support
        echo source $tmpthemedir/oh-my-zsh/lib/git.zsh # git support
        echo source $tmpthemedir/oh-my-zsh/lib/prompt_info_functions.zsh # rvm and ruby support
        echo source $tmpthemedir/oh-my-zsh/lib/nvm.zsh # nvm support
        echo source $tmpthemedir/oh-my-zsh/plugins/themes/themes.plugin.zsh # theming functions
        echo source $tmpthemedir/oh-my-zsh/themes/$split[-1] # theming functions

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
