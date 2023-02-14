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
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'ray-x/lsp_signature.nvim'

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/vim-vsnip'
    use 'simrat39/rust-tools.nvim'
    use 'mfussenegger/nvim-lint'

    use 'cespare/vim-toml'
    use 'vmchale/ion-vim'
    use 'jose-elias-alvarez/null-ls.nvim'
    use { 'fatih/vim-go', run = ':GoUpdateBinaries' }
    use { 'rust-lang/rust.vim' }
end)

require('colors')
require('plugins.nerd')
require('plugins.lsp')
require('plugins.null-ls')
