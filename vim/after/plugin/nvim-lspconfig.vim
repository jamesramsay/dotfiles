if !has('nvim')
  finish
endif

:lua << END
  require'lspconfig'.gopls.setup{}
  require'lspconfig'.jsonls.setup{}
  require'lspconfig'.vimls.setup{}
  require'lspconfig'.yamlls.setup{
    settings = {
      yaml = {
        schemas = {
          ["data/schemas/releasepost.schema.json"] = "data/release_posts/*/*.yml",
          ["data/schemas/features.schema.json"] = "data/features.yml"
        }
      }
    }
  }
END

function! s:Bind()
  try
    if nvim_win_get_var(0, 'textDocument/hover')
      nnoremap <buffer> <silent> K :call nvim_win_close(0, v:true)<CR>
      nnoremap <buffer> <silent> <Esc> :call nvim_win_close(0, v:true)<CR>

      setlocal nocursorline

      " I believe this is supposed to happen automatically because I can see
      " this in lsp/util.lua:
      "
      "     api.nvim_buf_set_option(floating_bufnr, 'modifiable', false)
      "
      " but it doesn't seem to be working.
      setlocal nomodifiable
    endif
  catch /./
    " Not a hover window.
  endtry
endfunction

function! s:ConfigureBuffer()
    nnoremap <buffer> <silent> <Leader>ld <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
    nnoremap <buffer> <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <buffer> <silent> gd <cmd>lua vim.lsp.buf.declaration()<CR>

    if exists('+signcolumn')
      setlocal signcolumn=yes
    endif
endfunction

function! s:SetUpLspHighlights()
  if !jamsay#pinnacle#active()
    return
  endif

  execute 'highlight LspDiagnosticsError ' . pinnacle#decorate('italic,underline', 'ModeMsg')

  execute 'highlight LspDiagnosticsHint ' . pinnacle#decorate('bold,italic,underline', 'Type')

  execute 'highlight LspDiagnosticsHintSign ' . pinnacle#highlight({
        \   'bg': pinnacle#extract_bg('ColorColumn'),
        \   'fg': pinnacle#extract_fg('Type')
        \ })

  execute 'highlight LspDiagnosticsErrorSign ' . pinnacle#highlight({
        \   'bg': pinnacle#extract_bg('ColorColumn'),
        \   'fg': pinnacle#extract_fg('ErrorMsg')
        \ })
endfunction

sign define LspDiagnosticsErrorSign text=✖
sign define LspDiagnosticsWarningSign text=⚠
sign define LspDiagnosticsInformationSign text=ℹ
sign define LspDiagnosticsHintSign text=➤

if has('autocmd')
  augroup WincentLanguageClientAutocmds
    autocmd!

    autocmd WinEnter * call s:Bind()

    autocmd FileType vim,yaml  call s:ConfigureBuffer()

    autocmd ColorScheme * call s:SetUpLspHighlights()
  augroup END
endif
