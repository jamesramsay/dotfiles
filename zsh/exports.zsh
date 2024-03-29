export PAGER=less

if which nvim &> /dev/null; then
  export EDITOR=$(which nvim)
elif [ -x "$HOME/bin/vim" ]; then
  # PATH isn't set yet (.zsh/path depends on this file), so we do this check
  # instead of a simple `export EDITOR=$(which vim)`:
  export EDITOR=$HOME/bin/vim
else
  export EDITOR=vim
fi

# filename (if known), line number if known, falling back to percent if known,
# falling back to byte offset, falling back to dash
export LESSPROMPT='?f%f .?ltLine %lt:?pt%pt\%:?btByte %bt:-...'

# i = case-insensitive searches, unless uppercase characters in search string
# F = exit immediately if output fits on one screen
# M = verbose prompt
# R = ANSI color support
# S = chop long lines (rather than wrap them onto next line)
# X = suppress alternate screen
export LESS=iFMRSX

# Color man pages.
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;208m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;111m'

# Colour ls listings
export CLICOLOR=true

export GPG_TTY=$(tty)
