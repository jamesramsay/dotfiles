" Manage plugins using vim-plug
call plug#begin('~/.local/share/nvim/plugged')

Plug 'w0rp/ale'
Plug 'tpope/vim-surround'

" Initialize plugin system
call plug#end()

" Basic settings
syntax enable               " syntax highlighting
filetype on                 " detect filetypes
filetype plugin indent on   " enable loading indent file for filetype
set number                  " display line numbers
set numberwidth=1           " use only 1 column where possible
set title                   " show title in console title
set colorcolumn=119         " show line at column 119
set cursorline               " highlight line with cursor

" Editing
set autoindent              " always set autoindenting on
set tabstop=2               " <Tab> inserts 2 spaces
set shiftwidth=2            " indent 2 spaces
set softtabstop=2           " <BS> over an autoindent deletes both spaces
set expandtab               " use spaces, not tabs, for autoindent/tab key
set shiftround              " rounds indent to a multiple of shiftwidth

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

" Auto-reload
" So that I can keep tweaking fast!
if has('autocmd')
  augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
  augroup END " }
endif
