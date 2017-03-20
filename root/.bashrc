source ~/.bash_prompt
# auto ls on cd
# blah
function cd() {
    builtin cd $@ && ls
}
