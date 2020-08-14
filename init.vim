set nocompatible              " be iMproved, required
filetype off                  " required

set tabstop=4
set shiftwidth=4 
set expandtab
set backspace=indent,eol,start
set colorcolumn=80
set textwidth=80
set number
set relativenumber
set autoindent
set ignorecase smartcase
set showmatch


highlight ColorColumn ctermbg=LightGrey ctermfg=Black
syntax on


let g:rustfmt_autosave = 1
let g:go_fmt_command = "goimports"

" autocmd BufEnter * call ncm2#enable_for_buffer()

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'vim-airline/vim-airline'
Plug 'rust-lang/rust.vim',{ 'for': 'rust' }

Plug 'valloric/youcompleteme', { 'do': './install.py --rust-completer --go-completer', 'for': ['rust','go'] }
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'https://github.com/joshdick/onedark.vim.git'

call plug#end()

colorscheme onedark

let g:ctrlp_use_caching = 0

let mapleader = " "

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

nnoremap <silent> <Leader>= :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

if executable('rg')
    let g:rg_derive_root='true'
endif

nnoremap <Leader>pf :Rg<SPACE>

nnoremap <leader>pg :GoDef<CR>
" Ctrl-o or Ctrl-t to go back

