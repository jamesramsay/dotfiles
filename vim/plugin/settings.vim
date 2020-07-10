scriptencoding utf-8

set autoindent                        " maintain indent of current line
set backspace=indent,start,eol        " allow unrestricted backspacing in insert mode

if exists('$SUDO_USER')
  set nobackup                        " don't create root-owned files
  set nowritebackup                   " don't create root-owned files
else
  set backup
  set backupdir=~/.local/vim/tmp/backup
  set backupdir+=~/.vim/tmp/backup    " keep backup files out of the way
  set backupdir+=.
endif

if exists('$SUDO_USER')
  set noswapfile                      " don't create root-owned files
else
  set directory=~/.local/vim/tmp/swap
  set directory+=~/.vim/tmp/swap    " keep swap files out of the way
  set directory+=.
endif

set hid
if exists('undodir')
  set undofile
  set undodir=~/.local/vim/tmp/undo
  set undodir+=~/.vim/tmp/undo
  set undodir+=.
endif

if has('windows')
  set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  set fillchars+=fold:·             " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
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
set scrolloff=3                       " start scrolling 3 lines before edge of viewport
set diffopt=vertical                  " always show diffs side-by-side
set noemoji                           " don't assume all emoji are double width

" Avoid use of highlight in nvim ^0.2.0
if !has('nvim')
  " Sync with corresponding nvim settings in ~/.config/nvim/plugin/autocmds.vim:
  set highlight+=@:ColorColumn          " ~/@ at end of window, 'showbreak'
  set highlight+=N:DiffText             " make current line number stand out a little
  set highlight+=c:LineNr               " blend vertical separators with line numbers
endif

set laststatus=2                      " always show status line
set lazyredraw                        " don't bother updating screen during macro playback

set list                              " show whitespace
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
                                      " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)
set nojoinspaces                      " don't autoinsert two spaces after '.', '?', '!' for join command
set number                            " show line numbers in gutter

if exists('+relativenumber')
  set relativenumber                  " show relative numbers in gutter
endif

set shortmess+=A                      " ignore annoying swapfile messages
set shortmess+=I                      " no splash screen
set shortmess+=O                      " file-read message overwrites previous
set shortmess+=T                      " truncate non-file messages in middle
set shortmess+=W                      " don't echo "[w]"/"[written]" when writing
set shortmess+=a                      " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=o                      " overwrite file-written messages
set shortmess+=t                      " truncate file messages at start

if has('linebreak')
  set linebreak                       " wrap long lines at characters in 'breakat'
  set breakindent                     " indent wrapped lines to match start
  let &showbreak='  ↳ '               " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)

  if exists('&breakindentopt')
    set breakindentopt=sbr            " put showbreak indicator before indent
  endif
endif

if has('windows')
  set splitbelow                      " open horizontal splits below current window
endif

if has('vertsplit')
  set splitright                      " open vertical splits to the right of the current window
endif

if exists('&belloff')
  set belloff=all                     " never ring the bell for any reason
endif

if has('termguicolors')
  set termguicolors                   " use guifg/guibg instead of ctermfg/ctermbg in terminal
endif
