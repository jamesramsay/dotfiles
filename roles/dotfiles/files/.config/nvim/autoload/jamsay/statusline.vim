scriptencoding utf-8

function! jamsay#statusline#gutterpadding() abort
  let l:minwidth=2
  let l:gutterWidth=max([strlen(line('$')) + 1, &numberwidth, l:minwidth])
  let l:padding=repeat(' ', l:gutterWidth - 1)
  return l:padding
endfunction

function! jamsay#statusline#fileprefix() abort
  let l:basename=expand('%:h')
  if l:basename ==# '' || l:basename ==# '.'
    return ''
  else
    " Make sure we show $HOME as ~.
    return substitute(l:basename . '/', '\C^' . $HOME, '~', '')
  endif
endfunction

function! jamsay#statusline#ft() abort
  if strlen(&ft)
    return ',' . &ft
  else
    return ''
  endif
endfunction

function! jamsay#statusline#fenc() abort
  if strlen(&fenc) && &fenc !=# 'utf-8'
    return ',' . &fenc
  else
    return ''
  endif
endfunction

function! jamsay#statusline#lhs() abort
  let l:line=jamsay#statusline#gutterpadding()
  let l:line.=&modified ? '+ ' : '  '
  return l:line
endfunction

function! jamsay#statusline#rhs() abort
  let l:rhs=' '
  if winwidth(0) > 80
    let l:column=virtcol('.')
    let l:width=virtcol('$')
    let l:line=line('.')
    let l:height=line('$')

    " Add padding to stop rhs from changing too much as we move the cursor.
    let l:padding=len(l:height) - len(l:line)
    if (l:padding)
      let l:rhs.=repeat(' ', l:padding)
    endif

    let l:rhs.='l ' " (Literal, \u2113 "SCRIPT SMALL L").
    let l:rhs.=l:line
    let l:rhs.='/'
    let l:rhs.=l:height
    let l:rhs.=' c ' " (Literal, \u1d68c "MATHEMATICAL MONOSPACE SMALL C").
    let l:rhs.=l:column
    let l:rhs.='/'
    let l:rhs.=l:width
    let l:rhs.=' '

    " Add padding to stop rhs from changing too much as we move the cursor.
    if len(l:column) < 2
      let l:rhs.=' '
    endif
    if len(l:width) < 2
      let l:rhs.=' '
    endif
  endif
  return l:rhs
endfunction

let s:default_lhs_color='Identifier'
let s:async_lhs_color='Constant'
let s:modified_lhs_color='ModeMsg'
let s:jamsay_statusline_status_highlight=s:default_lhs_color
let s:async=0

function! jamsay#statusline#async_start() abort
  let s:async=1
  call jamsay#statusline#check_modified()
endfunction

function! jamsay#statusline#async_finish() abort
  let s:async=0
  call jamsay#statusline#check_modified()
endfunction

function! jamsay#statusline#check_modified() abort
  if &modified && s:jamsay_statusline_status_highlight != s:modified_lhs_color
    let s:jamsay_statusline_status_highlight=s:modified_lhs_color
    call jamsay#statusline#update_highlight()
  elseif !&modified
    if s:async && s:jamsay_statusline_status_highlight != s:async_lhs_color
      let s:jamsay_statusline_status_highlight=s:async_lhs_color
      call jamsay#statusline#update_highlight()
    elseif !s:async && s:jamsay_statusline_status_highlight != s:default_lhs_color
      let s:jamsay_statusline_status_highlight=s:default_lhs_color
      call jamsay#statusline#update_highlight()
    endif
  endif
endfunction

function! jamsay#statusline#update_highlight() abort
  " Update StatusLine to use italics (used for filetype).
  let l:highlight=pinnacle#italicize('StatusLine')
  execute 'highlight User1 ' . l:highlight

  " Update MatchParen to use italics (used for blurred statuslines).
  let l:highlight=pinnacle#italicize('MatchParen')
  execute 'highlight User2 ' . l:highlight

  " StatusLine + bold (used for file names).
  let l:highlight=pinnacle#embolden('StatusLine')
  execute 'highlight User3 ' . l:highlight

  " Inverted Error styling, for left-hand side "Powerline" triangle.
  let l:fg=pinnacle#extract_fg(s:jamsay_statusline_status_highlight)
  let l:bg=pinnacle#extract_bg('StatusLine')
  execute 'highlight User4 ' . pinnacle#highlight({'bg': l:bg, 'fg': l:fg})

  " And opposite for the buffer number area.
  execute 'highlight User7 ' .
        \ pinnacle#highlight({
        \   'bg': l:fg,
        \   'fg': pinnacle#extract_fg('Normal'),
        \   'term': 'bold'
        \ })

  " Right-hand side section.
  let l:bg=pinnacle#extract_fg('Cursor')
  let l:fg=pinnacle#extract_fg('User3')
  execute 'highlight User5 ' .
        \ pinnacle#highlight({
        \   'bg': l:fg,
        \   'fg': l:bg,
        \   'term': 'italic'
        \ })

  " Right-hand side section + italic (used for %).
  execute 'highlight User6 ' .
        \ pinnacle#highlight({
        \   'bg': l:fg,
        \   'fg': l:bg,
        \   'term': 'bold,italic'
        \ })

  highlight clear StatusLineNC
  highlight! link StatusLineNC User1
endfunction
