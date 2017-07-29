" Automatic, language-dependent indentation, syntax coloring and other
" functionality.
filetype indent plugin on
syntax on

" Manage plugins using vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" Styling and syntax
Plug 'jamesramsay/base16-vim', { 'branch': 'extended' }  " Colorscheme
Plug 'wincent/pinnacle', { 'tag': '0.3.1' }              " Required for italics
Plug 'wincent/terminus'                                  " Improved terminal integration

Plug 'wincent/vim-clipper'             " Integrate OS X clipper the lazy way
Plug 'w0rp/ale'                        " Async linting

" Editing
Plug 'tpope/vim-surround'              " Surrounding quotes and parens

" Markdown
Plug 'junegunn/goyo.vim'               " Distraction free writing
Plug 'reedes/vim-pencil'               " Pleasantly write prose

" Syntax
Plug 'tpope/vim-markdown'
Plug 'kchmck/vim-coffee-script'
Plug 'vito-c/jq.vim'

" Organisation and notes
Plug 'vimwiki/vimwiki'

" Navigiation
Plug 'scrooloose/nerdtree'
Plug 'wincent/command-t', {
  \   'do': 'cd ruby/command-t && ruby extconf.rb && make'
  \ }

" Initialize plugin system
call plug#end()

" Messages, Info, Status
set laststatus=2            " allways show status line
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.
set statusline=%<%f\ (%{&ft})%=%-19(%3l,%02c%03V%)

" Cursor
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Colors
colorscheme base16-tomorrow-night
