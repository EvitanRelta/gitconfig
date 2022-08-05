stty -ixon -ixoff

bind -r '\C-S'
bind -r '\C-R'

bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward'
bind "set show-all-if-ambiguous on"

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

_git_branch_d_both () {
    _git_branch
}

_git_pull_all () {
    _git_branch
}

_git_rebase_from () {
    _git_branch
}