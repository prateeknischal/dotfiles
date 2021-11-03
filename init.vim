lua << EOF
require('options')
require('keymap')

require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'scrooloose/nerdcommenter'
    use 'airblade/vim-gitgutter'
    use 'morhetz/gruvbox'
    use 'itchyny/lightline.vim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'

    --use 'hrsh7th/cmp-nvim-lsp'
    --use 'hrsh7th/cmp-buffer'
    --use 'hrsh7th/cmp-path'
    --use 'hrsh7th/cmp-cmdline'
    --use 'hrsh7th/nvim-cmp'
    --use 'hrsh7th/vim-vsnip'

    use 'google/vim-maktaba'
    use 'google/vim-codefmt'
    use 'google/vim-glaive'
    use { 'fatih/vim-go', run = ':GoUpdateBinaries' }
    use { 'rust-lang/rust.vim' }
    use { 'neoclide/coc.nvim', run = 'yarn install --frozen-lockfile' }
end)

require('plugins.nerd')
require('plugins.vim-go')
require('plugins.coc-nvim')
--require('plugins.lsp')
EOF

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
