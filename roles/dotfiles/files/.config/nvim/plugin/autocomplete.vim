if has('nvim')
  " Don't forget to run :UpdateRemotePlugins to populate
  " `~/.local/share/nvim/rplugin.vim`.
  " TODO: packadd! deoplete
  call jamsay#defer#defer('call jamsay#autocomplete#deoplete_init()')

  inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
  inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
  inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-j>"
  inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"

  " TODO: packadd! LanguageClient-neovim
endif
