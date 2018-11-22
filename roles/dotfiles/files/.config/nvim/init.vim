" Automatic, language-dependent indentation, syntax coloring and other
" functionality.
filetype indent plugin on
syntax on

" Manage plugins using vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" Styling
Plug 'jamesramsay/base16-vim', { 'branch': 'extended' }  " Colorscheme
Plug 'wincent/pinnacle', { 'tag': '0.3.1' }              " Required for italics

" Integration
Plug 'wincent/terminus'                " Improved terminal integration
Plug 'wincent/vim-clipper'             " Integrate OS X clipper the lazy way
Plug 'kopischke/vim-fetch'             " Open files with line and column numbers with a minimum of fuss
Plug 'christoomey/vim-tmux-navigator'

" Git
Plug 'tpope/vim-fugitive'              " Git integrations
Plug 'junegunn/gv.vim'
Plug 'jreybert/vimagit'
Plug 'airblade/vim-gitgutter'          " Show diff status in gutter

Plug 'w0rp/ale'                        " Async linting
Plug 'tpope/vim-eunuch'                " UNIX helpers including move and rename
Plug 'tpope/vim-surround'              " Surrounding quotes and parens

" Autocomplete
Plug 'autozimu/LanguageClient-neovim', {'tag': 'binary-*-x86_64-apple-darwin'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }   " Autocomplete
Plug 'ervandew/supertab'                                        " Tab to complete
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }

" Markdown
Plug 'junegunn/goyo.vim'               " Distraction free writing
Plug 'reedes/vim-pencil'               " Pleasantly write prose

" Languages and Syntax
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-markdown'
Plug 'kchmck/vim-coffee-script'
Plug 'vito-c/jq.vim'
Plug 'enomsg/vim-haskellConcealPlus'
Plug 'tpope/vim-sleuth'
Plug 'fatih/vim-go'

" Organisation and notes
Plug 'vimwiki/vimwiki'

" Navigiation
Plug 'scrooloose/nerdtree'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'wincent/ferret'

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
