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
set foldmethod=manual
set mouse=a

set wildignore+=*/target/*
set wildignore+=*/node_modules/*
set wildignore+=*/dist/*

set undodir=~/.vimundo
set undofile

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

highlight ColorColumn ctermbg=LightGrey ctermfg=Black
syntax enable
filetype plugin indent on

" YAML spacing
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType c,cpp setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType rust setlocal colorcolumn=100 textwidth=100

autocmd FileType markdown setlocal spell

" Remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

" CPP setup done using this tutorial https://xuechendi.github.io/2019/11/11/VIM-CPP-IDE-2019-111-11-VIM_CPP_IDE
" Code formatting
autocmd FileType c,cpp,proto AutoFormatBuffer clang-format
autocmd FileType python AutoFormatBuffer autopep8


call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'

Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'rust-lang/rust.vim',{ 'for': 'rust' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Code formatting (for c++)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

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

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

" Coc settings
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gu <Plug>(coc-rename)
nmap <silent> gt <Plug>(coc-type-definition)

let g:rustfmt_autosave = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_info_mode = "gopls"

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
nnoremap gb :GoDoc<CR>

" https://pmihaylov.com/vim-for-go-development/
autocmd BufEnter *.go nmap <leader>i <Plug>(go-info)
autocmd BufEnter *.go nmap <leader>gi <Plug>(go-implements)
autocmd BufEnter *.go nmap <leader>ge <Plug>(go-describe)
autocmd BufEnter *.go nmap <leader>gc <Plug>(go-callers)

" Using telescope for CtrlP file finder
nnoremap <silent> <C-p> :Telescope find_files<CR>

" To use ESC to get out of terminal mode in :terminal
tnoremap <Esc> <C-\><C-n>
