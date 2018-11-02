#
# Bindings
#

# zsh-autosuggestions
bindkey '^ ' autosuggest-accept

# git + fzf
join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local char
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}

# Git + FZF bindings
# - C-g C-f: modified files
# - C-g C-b: branches
# - C-g C-t: tags
# - C-g C-h: history
# - C-g C-r: remotes
bind-git-helper f b t r h
unset -f bind-git-helper
