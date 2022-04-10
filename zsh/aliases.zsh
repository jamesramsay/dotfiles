#
# Command aliases
#
alias python=/usr/local/bin/python3

if command -v exa &> /dev/null; then
  alias l='exa -F'
  alias ll='exa --long -F'
else
  alias l='ls -F'
  alias ll='ls -laF'
fi

if command -v nvim &> /dev/null; then
  alias vim=nvim # Use `\vim` or `command vim` to get the real vim.
fi

