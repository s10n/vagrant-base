# Git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Prompt
PS1='\[\033[01;33m\]\u@\h \[\033[00m\]\[\033[01;37m\]\w$(parse_git_branch)\[\033[00m\] '
