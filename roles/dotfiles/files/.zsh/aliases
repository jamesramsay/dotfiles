#
# Command aliases
#

# When I think I'm in vim
alias :q=exit
alias :wq=exit


if command -v exa &> /dev/null; then
  alias l='exa -F'
  alias ll='exa --long -F'
else
  alias l='ls -F'
  alias ll='ls -laF'
fi
alias gs='tig status'
alias gu=gitup
alias p='git patch'
alias o='git oneline -10'
alias v='f -e vim' # fasd
if command -v nvim &> /dev/null; then
  alias vim=nvim # Use `\vim` or `command vim` to get the real vim.
fi

# Git
function g {
  if [[ $# > 0 ]]; then
    git "$@"
  else
    echo "Last commit: $(time_since_last_commit) ago"
    git status --short --branch
  fi
}

function time_since_last_commit() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  git log -1 --pretty=format:"%ar" | sed 's/\([0-9]*\) \(.\).*/\1\2/'
}
