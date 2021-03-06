if has('autocmd')
  augroup JamsayAutocmds
    autocmd!

    autocmd VimResized * execute "normal! \<c-w>="

    " http://vim.wikia.com/wiki/Detect_window_creation_with_WinEnter
    autocmd VimEnter * autocmd WinEnter * let w:created=1
    autocmd VimEnter * let w:created=1

    " Disable paste mode on leaving insert mode.
    autocmd InsertLeave * set nopaste

    if has('nvim')
      " Sync with corresponding non-nvim settings in ~/.config/nvim/plugin/settings.vim:
      autocmd ColorScheme * highlight! link NonText ColorColumn
      autocmd ColorScheme * highlight! link CursorLineNr DiffText
      autocmd ColorScheme * highlight! link VertSplit LineNr
    endif

    " Make current window more obvious by turning off/adjusting some features in non-current windows.
    if exists('+colorcolumn')
      autocmd BufEnter,FocusGained,VimEnter,WinEnter * if jamsay#autocmds#should_colorcolumn() | let &l:colorcolumn='+' . join(range(0, 254), ',+') | endif
      autocmd FocusLost,WinLeave * if jamsay#autocmds#should_colorcolumn() | let &l:colorcolumn=join(range(1, 255), ',') | endif
    endif
    autocmd InsertLeave,VimEnter,WinEnter * if jamsay#autocmds#should_cursorline() | setlocal cursorline | endif
    autocmd InsertEnter,WinLeave * if jamsay#autocmds#should_cursorline() | setlocal nocursorline | endif
    if has('statusline')
      autocmd BufEnter,FocusGained,VimEnter,WinEnter * call jamsay#autocmds#focus_statusline()
      autocmd FocusLost,WinLeave * call jamsay#autocmds#blur_statusline()
    endif

    " Regenerate spell file
    autocmd BufWritePost */spell/*.add silent! :mkspell! %
  augroup END
endif

