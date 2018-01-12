" Vundle config

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"From here other plugins from the original Vundle config
Plugin 'scrooloose/nerdtree'

Plugin 'rakr/vim-two-firewatch'
Plugin 'romainl/Apprentice'

"Colorscheme
" Plugin 'arcticicestudio/nord-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" End of Vundle config        

" General config

" colorscheme nord
"set background=dark " or light if you prefer the light version
"let g:two_firewatch_italics=1
"colo two-firewatch
colorscheme apprentice

syntax on
set number
set relativenumber
set linebreak     " Break lines at word (requires Wrap lines)
set showbreak=+++ " Wrap-broken line prefix

set showmatch     " Highlight matching brace
set visualbell    " Use visual bell (no beeping)

set hlsearch      " Highlight all search results
set smartcase     " Enable smart-case search
set ignorecase    " Always case-insensitive
set incsearch     " Searches for strings incrementally

" This will enable Vim's spell checking feature
" " for the English language (emerge -av vim-spell-en)
set spell spelllang=en

" We'll be using this option to modify files directly
" " inside NERDTree inside Vim, without having to exit Vim
set modifiable

" Vertical split on the right
set splitright

" This will highlight the current line your cursor is at
" set cursorline

" This will highlight the current column your cursor is at
" and it'll make it much easier to determine your closing tags
" (along with matchtagalways) when code is properly indented
" set cursorcolumn

" This will enable the usage of your mouse inside Vim in
" " terminal emulators that support it (gpm)
set mouse=a

" This option speeds up macro execution in Vim
" Some users may rarely experience glitches with this option
" enabled
set lazyredraw

" This enabled 256-color support in Vim, which is needed
" by many color schemes
set t_Co=256

" This will make Vim start searching the moment you start
" typing the first letter of your search keyword
set incsearch

" This will make Vim highlight all search results that
" matched the search keyword
set hlsearch

" This will make tabs 2 spaces wide
set tabstop=2

" This is needed to tree tabs as multiple spaces
set shiftwidth=2

" This option will enable you to enter a real Tab character
" by pressing Ctrl-V<Tab>
set expandtab

set softtabstop=2 " Number of spaces per Tab

" Advanced
" set ruler " Show row and column ruler information
 
set undolevels=1000 " Number of undo levels
set backspace=indent,eol,start  " Backspace behaviour

" " This will enable NERDTree to show hidden files
let NERDTreeShowHidden=1

" Autoload NERDTree if no file specified

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" directly open NERDTree on the file you-re editing
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

" Auto close NERDTree if no more files
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" enable copy to clipboard

set clipboard=unnamed

" copy to clipboard with Ctrl-C

map <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

" paste from clipboard with Ctrl-V

set pastetoggle=<F10>
inoremap <C-v> <F10><C-r>+<F10>

"""""""""""""""""""""""""""
" Git-gutter configuration
"""""""""""""""""""""""""""

let g:gitgutter_updatetime = 750
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1

"""""""""""""""""""""""""""
" Syntastic configuration
"""""""""""""""""""""""""""

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" so that syntastic uses .jshintrc files if present - http://stackoverflow.com/questions/28573553/how-can-i-make-syntastic-load-a-different-checker-based-on-existance-of-files-in

autocmd FileType javascript let b:syntastic_checkers = findfile('.jshintrc', '.;') != '' ? ['jshint'] : ['standard']

"""""""""""""""""""""""""""
" Custom (no plugin related)
"""""""""""""""""""""""""""

" show filename
set statusline+=%F

