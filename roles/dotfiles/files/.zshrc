# Fast minimal zsh (less than 100ms)
#
# Performance test:
#   $ for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
#
# 2017-06-20: 120ms (2015 MacBook Air)

#
# Completions
#

fpath=($HOME/.zsh/bundles/zsh-completions/src $fpath)
fpath=($HOME/.zsh/completions $fpath)

autoload -U compinit
compinit -u

# Make completion:
# - Case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''


#
# Prompt
# - Pure, Sindre Sorhus
#

fpath=($HOME/.zsh/functions $fpath)
autoload -U promptinit; promptinit
prompt pure

export CLICOLOR=1 # enable file type colors

# Color
# - variable used by color script for setting tmux focus
export COLORSCHEME_FILE=$HOME/.zsh/base16-shell/scripts/base16-snazzy.sh
source $COLORSCHEME_FILE

# Syntax highlighting bundle.
source $HOME/.zsh/bundles/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# FZF - prefer ripgrep to native
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi


#
# History
#

export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

setopt share_history        # share command history data
setopt append_history       # multiple sessions write to shared history
setopt extended_history     # save timestamps... why
setopt hist_ignore_all_dups # ignore sequential duplicate commands
setopt hist_ignore_space    # ignore commands starting with space
setopt hist_verify          # confirm history expansion (!$, !!, !foo)


#
# Options
#

setopt autocd               # .. is shortcut for cd .. (etc)
setopt autoparamslash       # tab completing directory appends a slash
setopt autopushd            # cd automatically pushes old dir onto dir stack
setopt correct              # command auto-correction
setopt correctall           # argument auto-correction
setopt interactivecomments  # allow comments, even in interactive shells
setopt printexitvalue       # for non-zero exit status
setopt pushdignoredups      # don't push multiple copies of same dir onto stack
setopt pushdsilent          # don't print dir stack after pushing/popping


#
# Other
#

source $HOME/.zsh/aliases
source $HOME/.zsh/colors
source $HOME/.zsh/exports
source $HOME/.zsh/path

CHRUBY=/usr/local/opt/chruby/share/chruby
test -e "$CHRUBY/chruby.sh" && . "$CHRUBY/chruby.sh"
test -e "$CHRUBY/auto.sh" && . "$CHRUBY/auto.sh"
