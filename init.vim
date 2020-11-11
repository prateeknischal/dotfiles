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

set wildignore+=*/target/*
set wildignore+=*/node_modules/*

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

highlight ColorColumn ctermbg=LightGrey ctermfg=Black
syntax enable
filetype plugin indent on

" YAML spacing
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab

" Remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

let g:rustfmt_autosave = 1
let g:go_fmt_command = "goimports"

" autocmd BufEnter * call ncm2#enable_for_buffer()

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'

Plug 'itchyny/lightline.vim'
Plug 'rust-lang/rust.vim',{ 'for': 'rust' }

Plug 'davidhalter/jedi-vim', { 'for': 'python' }

Plug 'valloric/youcompleteme', { 'do': './install.py --rust-completer --go-completer', 'for': ['rust','go'] }
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
" Plug 'vim-syntastic/syntastic'

"Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
call plug#end()

let g:gruvbox_contrast_dark = 'hard'
"let g:gruvbox_invert_selection='0'

colorscheme gruvbox

let g:nerdspacedelims = 1
let g:nerdcommentemptylines = 1
let g:nerdtrimtrailingwhitespace = 1
let g:nerdtogglecheckalllines = 1

let g:ctrlp_use_caching = 1
let g:ctrlp_root_markers = ['pom.xml', '.gitignore', 'Cargo.toml', 'go.mod']

" Syntastic config start
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
" Syntastic config end

let mapleader = " "

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap ;w :w
nnoremap ;q :q

nnoremap <silent> <Leader>= :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

nmap <leader>; :Buffers<CR>

if executable('rg')
    let g:rg_derive_root='true'
endif

nnoremap <Leader>pf :Rg<SPACE>

nnoremap <leader>pg :GoDef<CR>
" Ctrl-o or Ctrl-t to go back

set tags=./tags;
let g:ctrlp_extensions = ['tag', 'quickfix']
nnoremap <leader>. :CtrlPTag<cr>
