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


function download_pkgs() {
    for p in $PACKAGES;
        do clone_if_needed $p
        done
}

function load_pkgs() {
    for p in $PACKAGES;
        do source_pkg $p
        done
}

function clean_pkgs() {
    rm -rf $CONFIG_DIR/*
    clear
    source ~/.zshrc
}

download_pkgs
load_pkgs
#}}}
