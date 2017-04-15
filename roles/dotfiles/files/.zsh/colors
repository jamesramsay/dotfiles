#
# Colors
#

# Blur inactive tmux windows and panes
function() {
  if [ -n "${COLORSCHEME_FILE+set}" ]; then
    local FILE="$COLORSCHEME_FILE"

    if [[ -e "$FILE" ]]; then
      local BG=$(grep color_background= "$FILE" | cut -d \" -f2 | sed -e 's#/##g')
      local CC=$(grep color18= "$FILE" | cut -d \" -f2 | sed -e 's#/##g')

      if [ -n "$TMUX" ]; then
        if [ -n "$BG" -a -n "$CC" ]; then
          command tmux set -a window-active-style "bg=#$BG"
          command tmux set -a window-style "bg=#$CC"
          command tmux set -g pane-active-border-bg "#$CC"
          command tmux set -g pane-border-bg "#$CC"
        fi
      fi
    else
      echo "Colorscheme not found"
    fi
  fi
}

