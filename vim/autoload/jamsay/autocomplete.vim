function! jamsay#autocomplete#setup_mappings() abort
  " One additional mapping of our own: accept completion with <CR>.
  imap <expr> <buffer> <silent> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
  smap <expr> <buffer> <silent> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

function! jamsay#autocomplete#teardown_mappings() abort
  silent! iunmap <expr> <buffer> <CR>
  silent! sunmap <expr> <buffer> <CR>
endfunction

let s:deoplete_init_done=0
function! jamsay#autocomplete#deoplete_init() abort
  if s:deoplete_init_done || !has('nvim')
    return
  endif
  let s:deoplete_init_done=1
  call deoplete#enable()
endfunction
