" Automatic, language-dependent indentation, syntax coloring and other
" functionality.
filetype indent plugin on
syntax on

" Manage plugins using vim-plug
call plug#begin('~/.local/share/nvim/plugged')

Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
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

" Theme
colorscheme Tomorrow-Night-Eighties

" Cursor
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

