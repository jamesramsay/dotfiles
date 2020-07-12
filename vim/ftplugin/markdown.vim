setlocal autoindent
setlocal linebreak
setlocal nonumber
setlocal wrap

call jamsay#functions#spell()

function Check()
    let l:line=getline('.')
    let l:curs=winsaveview()
    if l:line=~?'\s*-\s*\[\s*\].*'
        s/\[\s*\]/[x]/
    elseif l:line=~?'\s*-\s*\[x\].*'
        s/\[x\]/[ ]/
    endif
    call winrestview(l:curs)
endfunction

nnoremap <silent> - :call Check()<CR>

set textwidth=0

let g:vim_markdown_folding_disabled = 1 " Disable folding
let g:vim_markdown_frontmatter = 1 " Improved frontmatter handling
let g:markdown_syntax_conceal = 0 " Disable syntax concealing

" Prefer bold and italic fonts
" TODO: this screws up the rest of the syntax highlighting
"highlight markdownBold gui=bold cterm=bold
"highlight markdownItalic gui=italic cterm=italic
