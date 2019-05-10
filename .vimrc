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




if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin()

Plug 'ludovicchabant/vim-gutentags'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
call plug#end()


