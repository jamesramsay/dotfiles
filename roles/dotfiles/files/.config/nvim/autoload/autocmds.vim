let g:WincentColorColumnBlacklist = ['diff']
let g:WincentCursorlineBlacklist = ['command-t']

function! autocmds#should_colorcolumn() abort
  return index(g:WincentColorColumnBlacklist, &filetype) == -1
endfunction

function! autocmds#should_cursorline() abort
  return index(g:WincentCursorlineBlacklist, &filetype) == -1
endfunction


