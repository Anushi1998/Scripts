parse_git_branch() {
  git branch 2>/dev/null | sed -n 's/^\* \(.*\)/\/\1/p'
}
PS1="\[\033[7;37m\]\w\[\033[0m\]\[\033[44;30m\]\$(parse_git_branch)\[\033[0m\]\[\033[7;37m\] >>\[\033[0m\] "
# Source bash config and key bindings on every login shell (iTerm2)
[ -f ~/.bashrc ] && source ~/.bashrc
[ -f ~/.inputrc ] && bind -f ~/.inputrc
