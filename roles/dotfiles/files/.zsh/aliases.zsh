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
alias g='git'
alias gs='tig status'
alias gu=gitup
alias p='git patch'
alias o='git oneline -10'
alias v='f -e vim' # fasd
if command -v nvim &> /dev/null; then
  alias vim=nvim # Use `\vim` or `command vim` to get the real vim.
fi

