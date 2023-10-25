stty -ixon -ixoff

bind "set completion-ignore-case on"
bind "set bell-style none"
bind 'c-h:backward-kill-word'
bind -x '"\C-t":vim .'
bind -r '\C-S'
bind -r '\C-R'

bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward'
bind "set show-all-if-ambiguous on"

bind '"\e[1;2A":history-search-backward'
bind '"\e[1;2B":history-search-forward'

_git_branch_d_both () {
    _git_branch
}

_git_pull_all () {
    _git_branch
}

_git_rebase_from () {
    _git_branch
}

_git_replace_with () {
    _git_branch
}

_git_rebase_preserve () {
    _git_rebase
}

_git_re() {
    _git_rebase
}

_git_cum() {
    _git_commit
}

_git_f() {
    _git_branch
}

_git_ff() {
    _git_fetch
}
