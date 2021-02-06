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
fpath=($HOME/.zsh/functions $fpath)
autoload -U promptinit; promptinit
prompt pure

# Color
# TODO: move back to shell driven color control rather than emulator
export CLICOLOR=1 # enable file type colors

# Syntax highlighting bundle.
source $HOME/.zsh/bundles/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

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
setopt interactivecomments  # allow comments, even in interactive shells
setopt printexitvalue       # for non-zero exit status
setopt pushdignoredups      # don't push multiple copies of same dir onto stack
setopt pushdsilent          # don't print dir stack after pushing/popping

DISABLE_AUTO_TITLE="true"

#
# Completions
#

source $HOME/.zsh/bundles/zsh-autosuggestions/zsh-autosuggestions.zsh


ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=magenta'

#
# Other
#

source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/bindings.zsh
source $HOME/.zsh/colors.zsh
source $HOME/.zsh/exports.zsh
source $HOME/.zsh/functions.zsh
source $HOME/.zsh/path.zsh

#
# FZF
#

if _has brew; then
  BREWPREFIX=$(brew --prefix)
fi

if [ -e $BREWPREFIX/opt/fzf/shell/completion.zsh ]; then
  source $BREWPREFIX/opt/fzf/shell/key-bindings.zsh
  source $BREWPREFIX/opt/fzf/shell/completion.zsh
fi

if _has fzf && _has rg; then
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.git,node_modules}/*" 2> /dev/null'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

#
# fasd
#
if _has fasd; then
  eval "$(fasd --init auto)"
fi

#
# Ruby
#
CHRUBY=/usr/local/opt/chruby/share/chruby
if [ -d "$CHRUBY" ]; then
  test -e "$CHRUBY/chruby.sh" && source "$CHRUBY/chruby.sh"
  test -e "$CHRUBY/auto.sh" && source "$CHRUBY/auto.sh"
fi
