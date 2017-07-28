" Toggle using combining UTF-8 characters for ranges
function! jamsay#functions#combine_codepoint(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  if getline('.') =~? char
    " Combined characters are treated as one character requring substring manipulation
    execute a:line1.','.a:line2.'s/'.char.'/\=submatch(0)[0:(strlen(nr2char(char2nr(submatch(0))))-1)]/ge'
  else
    " Don't use \%V else can't toggle whole line
    " TODO: support visual ranges
    " a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
    execute a:line1.','.a:line2.'s/[^[:cntrl:]]/&'.char.'/ge'
  endif
endfunction
