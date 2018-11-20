" Helpers to get the commit SHA of the current line
let s:begin = '^[^0-9]*[0-9]\{4}-[0-9]\{2}-[0-9]\{2}\s\+'

function! gv#sha(...)
  return matchstr(get(a:000, 0, getline('.')), s:begin.'\zs[a-f0-9]\+')
endfunction
