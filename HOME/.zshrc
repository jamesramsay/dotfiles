# Fast minimal zsh (less than 100ms)
#
# Performance test:
#   $ for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
fpath=( "$HOME/.zfunctions" $fpath )

# pure
autoload -U promptinit; promptinit
prompt pure

export CLICOLOR=1 # enable file type colors

# syntax highlighting bundle.
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# improved completions
fpath=( "$HOME/.zsh/zsh-completions/src" $fpath)

# history (based on: https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/history.zsh)
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Cabal
export PATH=$PATH:~/.cabal/bin

# Tufte-ness
# Default uses --latex-engine=pdflatex
tufte() {
  pandoc -r markdown+simple_tables+table_captions+yaml_metadata_block -s -S --latex-engine=pdflatex --template=/Users/james.ramsay/Development/jwr/pandoc/templates/tufte-latex.template.latex -o $1.pdf $1
  open $1.pdf
}
