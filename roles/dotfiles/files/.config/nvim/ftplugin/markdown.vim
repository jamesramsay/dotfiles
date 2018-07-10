setlocal autoindent
setlocal linebreak
setlocal nonumber
setlocal spell
setlocal wrap

" Fix funky frontmatter highlighting for Jekyll posts and the like
let g:vim_markdown_frontmatter = 1

" Disable syntax concealing
let g:markdown_syntax_conceal = 0

" Prefer bold and italic fonts
" TODO: this screws up the rest of the syntax highlighting
"highlight markdownBold gui=bold cterm=bold
"highlight markdownItalic gui=italic cterm=italic

PencilSoft

let b:ale_markdown_prettier_use_global = 1
let b:ale_markdown_prettier_options = '--prose-wrap always --print-width 80'
let b:ale_fixers = ['prettier']
