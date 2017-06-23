" use markdown for vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

augroup JamsayVimwikiFtdetect
  autocmd! BufRead,BufNewFile */vimwiki/* set filetype=vimwiki
augroup END
