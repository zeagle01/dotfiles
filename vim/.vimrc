set nocompatible

filetype on
filetype plugin on
let mapleader = "\\"
set hlsearch incsearch
set relativenumber
set number
set shiftwidth=2
set shiftround


set path+=**
set wildmenu

nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>

nnoremap <leader>" ea"<esc>bi"<esc>


colorscheme industry


let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
