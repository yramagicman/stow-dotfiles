#{{{ Set default, list packages to load

# Set the root directory for all zsh packages. If a github url is given it will
# be cloned into this directory. This directory is created automatically when
# zsh is loaded for the first time. Files that are refereced from disk will be
# left in place.
CONFIG_DIR="$HOME/.zsh"
MODULES_DIR="$HOME/.zsh_modules"
AUTO_INSTALL=1
AUTO_UPDATE=1
UPDATE_INTERVAL=5

# PACKAGES is an array of either absolute paths to local files or github
# user/repo/folder paths without leading or trailing slashes. If you want to use
# a part of Oh-my-zsh you would set PACKAGES to something like:
#
# PACKAGES=( 'robbyrussell/oh-my-zsh/plugins/git' )
#
# It is recommended, however that you find stand alone packages if at all
# possible. Frameworks have internal dependencies that bog down configurations.
# The packages refereced from github should have a single initilization file in the
# folder specified by the listed path. In the example above
# 'robbyrussell/oh-my-zsh/plugins/git' contains git.plugin.zsh that happens to
# be the entire plugin. The initilization file should be called init.zsh,
# *.plugin.zsh, *.zsh, or *.sh in that order. init.zsh will be sourced first,
# followed by pkg_name.plugin.zsh, followed by pkg_name.zsh, then finally
# pkg_name.sh.
#
# The last thing looked for is an absolute path to a local file. If found,
# this file is sourced directly.

# Set up zsh. Feel free to remove any of these and replace them with your own
# modules.
PACKAGES=(
    $CONFIG_DIR/runtime.zsh
    $CONFIG_DIR/history.zsh
    $CONFIG_DIR/completion.zsh
)

PACKAGES+=(
    # Source .zprofile every time to make sure the $PATH variable is correct.
    $HOME/.zprofile
    # Load the rest of the plugins.
    'rupa/z'
    'zsh-users/zsh-completions'
    'yramagicman/zsh-aliases'
    'Tarrasch/zsh-autoenv'
    'srijanshetty/zsh-pandoc-completion'
    'marzocchi/zsh-notify'
    )
#}}}
source $CONFIG_DIR/lib.zsh
prompt serenity
# {{{ lazy load stuff
if [[ "$TMUX" != '' ]]; then

    if [[ -z "$(pgrep tmuxcopy )" ]];
    then
        tmuxcopy &
    fi

fi
function workon() {
    echo " working.."
    if [[ -f $VIRTUALENVWRAPPER_SCRIPT ]] then
        source $VIRTUALENVWRAPPER_SCRIPT   &> /dev/null
        workon "$@"
    else
        echo "virtualenvwrapper.sh not at  /usr/bin/virtualenvwrapper.sh"
    fi
}
setopt NO_BEEP
#}}}
#{{{ key bindings,

# Allow command line editing in an external editor.
autoload -Uz edit-command-line
zle -N edit-command-line

bindkey -M emacs "\C-X\C-E" edit-command-line

#}}}
#{{{ virtualenv stuff
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Sites
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_SCRIPT=/usr/bin/virtualenvwrapper.sh
#}}}
#{{{ random user opions
export XDG_CONFIG_HOME=$HOME/.config
export BROWSER=firefox
#}}}
# {{{cdr, persistent cd
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
DIRSTACKFILE="$HOME/.cache/zsh/dirs"

# make DIRSTACKFILE if it's not there
if [[ ! -a $DIRSTACKFILE ]]; then
    mkdir -p $DIRSTACKFILE[0,-5]
    touch $DIRSTACKFILE
fi

if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
    dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
fi
chpwd() {
    print -l $PWD ${(u)dirstack} >>$DIRSTACKFILE
    d="$(sort -u $DIRSTACKFILE )"
    echo "$d" > $DIRSTACKFILE

}

DIRSTACKSIZE=20

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME

# Remove duplicate entries
setopt PUSHD_IGNORE_DUPS

# This reverts the +/- operators.
setopt PUSHD_MINUS
# }}}
#{{{ start tmux,
if [[ -z "$TMUX" && -z "$EMACS" && -z "$VIM" && -z "$SSH_TTY" ]]; then
    s tmux
fi
#}}}
