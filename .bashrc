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

# Auto-completion for `git copy-commit-metadata` alias
_git_copy_commit_metadata() {
    local cur prev words cword
    _init_completion || return

    # List of available options
    local opts="--all --committer --author --committer-date --author-date --message"

    # If the current word starts with a dash, suggest options
    if [[ $cur == -* ]]; then
        COMPREPLY=($(compgen -W "$opts" -- "$cur"))
        return
    fi

    # Otherwise, suggest commit hashes using git's own completion
    __gitcomp_nl "$(__git_refs)"
}
complete -F _git_copy_commit_metadata git-copy-commit-metadata

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
