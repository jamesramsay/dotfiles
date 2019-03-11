#
# Colors
#

# Blur inactive tmux windows and panes
function() {
  BG=FAFAFA
  CC=F0F0F0
  if [ -n "$TMUX" ]; then
    if [ -n "$BG" -a -n "$CC" ]; then
      command tmux set -a window-active-style "bg=#$BG"
      command tmux set -a window-style "bg=#$CC"
      command tmux set -g pane-active-border-bg "#$CC"
      command tmux set -g pane-border-bg "#$CC"
    fi
  fi
}

