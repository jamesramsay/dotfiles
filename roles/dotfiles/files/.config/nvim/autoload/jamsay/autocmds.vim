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
function! jamsay#autocmds#blur_statusline() abort
  " Default blurred statusline (buffer number: filename).
  let l:blurred='%{jamsay#statusline#gutterpadding()}'
  let l:blurred.='\ ' " space
  let l:blurred.='\ ' " space
  let l:blurred.='\ ' " space
  let l:blurred.='\ ' " space
  let l:blurred.='%<' " truncation point
  let l:blurred.='%f' " filename
  let l:blurred.='%=' " split left/right halves (makes background cover whole)
  call s:update_statusline(l:blurred, 'blur')
endfunction

function! jamsay#autocmds#focus_statusline() abort
  " `setlocal statusline=` will revert to global 'statusline' setting.
  call s:update_statusline('', 'focus')
endfunction

function! s:update_statusline(default, action) abort
  let l:statusline = s:get_custom_statusline(a:action)
  if type(l:statusline) == type('')
    " Apply custom statusline.
    execute 'setlocal statusline=' . l:statusline
  elseif l:statusline == 0
    " Do nothing.
    "
    " Note that order matters here because of Vimscript's insane coercion rules:
    " when comparing a string to a number, the string gets coerced to 0, which
    " means that all strings `== 0`. So, we must check for string-ness first,
    " above.
    return
  else
    execute 'setlocal statusline=' . a:default
  endif
endfunction

function! s:get_custom_statusline(action) abort
  if &ft ==# 'command-t'
    " Will use Command-T-provided buffer name, but need to escape spaces.
    return '\ \ ' . substitute(bufname('%'), ' ', '\\ ', 'g')
  elseif &ft ==# 'diff' && exists('t:diffpanel') && t:diffpanel.bufname ==# bufname('%')
    return 'Undotree\ preview' " Less ugly, and nothing really useful to show.
  elseif &ft ==# 'undotree'
    return 0 " Don't override; undotree does its own thing.
  elseif &ft ==# 'nerdtree'
    return 0 " Don't override; NERDTree does its own thing.
  elseif &ft ==# 'qf'
    if a:action ==# 'blur'
      return 'Quickfix'
    else
      return g:JamsayQuickfixStatusline
    endif
  endif

  return 1 " Use default.
endfunction

function! jamsay#autocmds#idleboot() abort
  " Make sure we automatically call jamsay#autocmds#idleboot() only once.
  augroup JamsayIdleboot
    autocmd!
  augroup END

  " Make sure we run deferred tasks exactly once.
  doautocmd User JamsayDefer
  autocmd! User JamsayDefer
endfunction
