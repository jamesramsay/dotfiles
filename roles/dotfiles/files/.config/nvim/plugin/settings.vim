scriptencoding utf-8

set autoindent                        " maintain indent of current line
set backspace=indent,start,eol        " allow unrestricted backspacing in insert mode

if exists('$SUDO_USER')
  set nobackup                        " don't create root-owned files
  set nowritebackup                   " don't create root-owned files
  set noswapfile                      " don't create root-owned files
else
  set backupdir=~/local/.vim/tmp/backup
  set backupdir+=~/.vim/tmp/backup    " keep backup files out of the way
  set backupdir+=.
  set directory=~/local/.vim/tmp/swap//
  set directory+=~/.vim/tmp/swap//    " keep swap files out of the way
  set directory+=.
endif

if exists('&belloff')
  set belloff=all                     " never ring the bell for any reason
endif

set textwidth=120                     " automatically hard wrap at 120 columns

if exists('+colorcolumn')
  " Highlight up to 255 columns (this is the current Vim max) beyond 'textwidth'
  let &l:colorcolumn='+' . join(range(0, 254), ',+')
endif

set cursorline                        " highlight current line

set tabstop=2                         " spaces per tab
set shiftwidth=2                      " spaces per tab (when shifting)
set expandtab                         " always use spaces instead of tabs
set smarttab                          " <tab>/<BS> indent/dedent in leading whitespace
set shiftround                        " always indent by a multiple of shift width

set highlight+=@:ColorColumn          " ~/@ at end of window, 'showbreak'
"set highlight+=N:DiffText             " make current line number stand out a little
"set highlight+=c:LineNr               " blend vertical separators with line numbers
set laststatus=2                      " always show status line
set lazyredraw                        " don't bother updating screen during macro playback

if exists('+relativenumber')
  set relativenumber                  " show relative numbers in gutter
endif

