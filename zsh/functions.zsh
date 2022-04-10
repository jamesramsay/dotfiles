# Returns whether the given command is executable or aliased.
_has() {
  return $( (( $+commands[$1] )) )
}

