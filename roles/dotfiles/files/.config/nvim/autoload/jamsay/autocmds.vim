let g:JamsayColorColumnBlacklist = ['diff', 'undotree', 'nerdtree']
let g:JamsayCursorlineBlacklist = ['command-t']

function! jamsay#autocmds#attempt_select_last_file() abort
  let l:previous=expand('#:t')
  if l:previous !=# ''
    call search('\v<' . l:previous . '>')
  endif
endfunction

function! jamsay#autocmds#should_colorcolumn() abort
  return index(g:JamsayColorColumnBlacklist, &filetype) == -1
endfunction

function! jamsay#autocmds#should_cursorline() abort
  return index(g:JamsayCursorlineBlacklist, &filetype) == -1
endfunction
