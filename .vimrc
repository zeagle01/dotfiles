set nocompatible

filetype on
filetype plugin on
let mapleader = "\\"
set hlsearch incsearch
set relativenumber
set number
set wrap
set shiftwidth=4
set shiftround


set path+=**
set wildmenu

nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>

nnoremap <leader>" ea"<esc>bi"<esc>


colorscheme industry
