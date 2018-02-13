source ~/.zsh_modules/yramagicman/zsh-aliases/aliases/aliases.plugin.zsh
source ~/.zsh_modules/yramagicman/zsh-aliases/functions/functions.plugin.zsh
source ~/.bash_prompt
# auto ls on cd
function cd() {
    builtin cd $@ && ls
}
