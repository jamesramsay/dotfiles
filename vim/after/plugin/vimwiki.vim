augroup JamsayVimwikiFtdetect
  autocmd! BufRead,BufNewFile */vimwiki/* set filetype=vimwiki
  autocmd BufNewFile ~/Dropbox/vimwiki/diary/*.md :silent 0r !vim-wiki-template '%'
augroup END
