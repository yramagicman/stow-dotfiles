#{{{ Set default, list packages to load

# Set the root directory for all zsh packages. If a github url is given it will
# be cloned into this directory. This directory is created automatically when
# zsh is loaded for the first time. Files that are refereced from disk will be
# left in place.
CONFIG_DIR="$HOME/.zsh"
MODULES_DIR="$HOME/.zsh_modules"

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
    $CONFIG_DIR/prompt.zsh
    $CONFIG_DIR/history.zsh
    $CONFIG_DIR/completion.zsh
)

# Your own packages here
PACKAGES+=(
    # If you want to use prezto themes, you may need to source this file
    # to get your current directory in the prompt
    # /prezto/init.zsh
    # /prezto/modules/prompt/functions/prompt-pwd
    #
    # These files are needed if you're going to use oh-my-zsh themes.'
    # 'robbyrussell/oh-my-zsh/lib/spectrum.zsh' # color support
    # 'robbyrussell/oh-my-zsh/lib/git.zsh' # git support
    # 'robbyrussell/oh-my-zsh/lib/promt_info_functions.zsh' # rvm and ruby support
    # 'robbyrussell/oh-my-zsh/lib/nvm.zsh' # nvm support
    # 'robbyrussell/oh-my-zsh/plugins/themes' # theming functions
    )
#}}}


# Load everything. Don't delete this line, Everything hinges on lib.zsh.
source $HOME/.zsh/lib.zsh


# Add whatever you want here!
