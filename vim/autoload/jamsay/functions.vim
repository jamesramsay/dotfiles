" Turn on spell-checking.
function! jamsay#functions#spell() abort
  if has('syntax')
    setlocal spell
    setlocal spellfile=~/.vim/spell/en.utf-8.add
    setlocal spelllang=en
  endif
endfunction
