function clone_if_needed() {
    split=("${(@s#/#)1}")
    if [[ ( ! -d "$MODULES_DIR/$split[1]" )  ]]; then
        if [[ -a $1 ]]; then
            return
        fi
        echo "$1 not found "
        mkdir -p $MODULES_DIR/$split[1]
        echo
        git clone --depth 3 git@github.com:$split[1]/$split[2] $MODULES_DIR/$split[1]/$split[2]/
        find $MODULES_DIR -type d -delete 2>/dev/null
        if [[ ! -d $MODULES_DIR/$split[1]/$split[2]  ]]; then
            echo "nothing cloned; trying https"
            git clone --depth 3 https://github.com/$split[1]/$split[2] $MODULES_DIR/$split[1]/$split[2]/
        fi
        echo
        # clean up if we don't clone anything. This won't delete directories
        # that arent empty'
        find $MODULES_DIR -type d -delete 2>/dev/null
        if [[ $(ls $MODULES_DIR | wc -l) -eq 0 ]]; then
            echo "nothing cloned"
            command rm $MODULES_DIR/.plugins
        fi
    fi
}

function cache_pkg () {
    if [[ ! -f $MODULES_DIR/.plugins ]]; then
        mkdir -p $MODULES_DIR
        touch $MODULES_DIR/.plugins
    fi
    if [[ -f "$MODULES_DIR/$1/init.zsh" ]]; then
        echo "$MODULES_DIR/$1/init.zsh" >> $MODULES_DIR/.plugins
        return
    elif [[  $( find $MODULES_DIR/$1/ -maxdepth 1 -name "*.plugin.zsh" 2> /dev/null ) ]]; then
        find $MODULES_DIR/$1/ -maxdepth 1 -name "*.plugin.zsh" >> $MODULES_DIR/.plugins
        return
    elif [[  $( find $MODULES_DIR/$1/ -maxdepth 1 -name "*.zsh" 2> /dev/null ) ]]; then
        find $MODULES_DIR/$1/ -maxdepth 1 -name "*.zsh" >> $MODULES_DIR/.plugins
        return
    elif [[  $( find $MODULES_DIR/$1/ -maxdepth 1 -name "*.zsh-theme" 2> /dev/null ) ]]; then
        find $MODULES_DIR/$1/ -maxdepth 1 -name "*.zsh-theme" >> $MODULES_DIR/.plugins
        return
    elif [[  $( find $MODULES_DIR/$1/ -maxdepth 1 -name "*.sh" 2> /dev/null ) ]]; then
        find $MODULES_DIR/$1/ -maxdepth 1 -name "*.sh" >> $MODULES_DIR/.plugins
        return
    elif [[ -a "$MODULES_DIR/$1" ]]; then
        echo "$MODULES_DIR/$1" >> $MODULES_DIR/.plugins
        return
    elif [[ -f "$1" ]]; then
        echo "$1" >> $MODULES_DIR/.plugins
        return
    else
        return
    fi
}

function clean_tmp_themes () {
    tmpthemedir="$HOME/.tmptheme"
    command rm -rf $tmpthemedir
}

function download_pkgs() {
    num_packages="$( ls $CONFIG_DIR | wc -l ) + $( ls $MODULES_DIR | wc -l )"
    if [[ ! -d $MODULES_DIR ]]; then
        mkdir -p $MODULES_DIR
    fi
    if [[ $num_packages -lt $#PACKAGES ]]; then
        if [[ $( ping -c 2 8.8.8.8 2> /dev/null ) ]]; then
            for p in $PACKAGES;
            do
                clone_if_needed $p
            done
        fi
        build_pkg_cache
    fi
}

function build_pkg_cache() {
    echo "caching"
    if [[ -f $MODULES_DIR/.plugins ]]; then
        command rm  $MODULES_DIR/.plugins
    fi
    for p in $PACKAGES;
        do
            cache_pkg $p
        done

    sort -u  $MODULES_DIR/.plugins > $MODULES_DIR/.plug
    command mv $MODULES_DIR/.plug $MODULES_DIR/.plugins
}

function load_pkgs() {
    if [[ -f $MODULES_DIR/.plugins ]]; then
        for p in $( cat $MODULES_DIR/.plugins )
        do
            source $p
        done
    else
        build_pkg_cache
        source ~/.zshrc
    fi
}

function reload_pkgs() {
    clean_tmp_themes
    command rm $MODULES_DIR/.plugins
    command rm -rf $MODULES_DIR/*
    clear
    download_pkgs
    source ~/.zshrc
}

function update_pkgs() {
    clean_tmp_themes
    cwd=$(pwd)
    for f in $(find $MODULES_DIR -maxdepth 3 -type d -name '.git')
        do
        builtin cd $f
        builtin cd ../
            if [[ $1 != '--silent' ]];
            then
                echo "updating $(pwd)"
                git pull
            else

                git pull --quiet
            fi
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
function check_updates() {
    if [[ -z $UPDATE_INTERVAL ]];
    then
        UPDATE_INTERVAL=30
    fi
    if [[ -z $( cat $MODULES_DIR/.updatetime ) ]];
    then
        echo 0 > $MODULES_DIR/.updatetime
    fi

    day=$((24 * 60 * 60 ))
    gap=$(( $UPDATE_INTERVAL * $day ))
    diff="$(( $(date +'%s') - $(cat $MODULES_DIR/.updatetime ) ))"
    if [[ $diff -gt $gap ]];
    then
        if [[ $SILENT_UPDATES ]];
        then
            update_pkgs --silent &
        else
            update_pkgs
        fi
        date +'%s' > $MODULES_DIR/.updatetime
    fi
}
if [[ $AUTO_INSTALL ]];
then
    download_pkgs > /dev/null
fi
if [[ $AUTO_UPDATE ]];
then
    check_updates
fi
load_pkgs
