local vim = vim
local set_options = require('common').set_options
local set_keymap = require('common').set_keymap

vim.g.mapleader = ' '
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

vim.api.nvim_command([[
augroup TrimWhitespace
autocmd BufWritePre * :%s/\s\+$//e
augroup END
]])

set_options({
    -- buffer
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    textwidth = 80,
    autoindent = true,

    -- window
    colorcolumn = 80,
    relativenumber = true,
    number = true,

    -- splits
    --splitbelow = true,
    --splitright = true,

    -- editing
    swapfile = false,
    undofile = true,
    backup = false,
    showmatch = true,
    ignorecase = true,
    foldmethod = 'manual',
    undodir = '~/.vimundo',
    termguicolors = true,
    completeopt = 'menu,menuone,noselect',
    hidden = true,
    incsearch = true,
    mouse = 'nv'
})

-- rg derive root
vim.g.rg_derive_root = 'true'

-- rust globals
vim.g.rustfmt_autosave = 1

-- telescope key bindings
set_keymap('n', '<C-p>', ':Telescope find_files<CR>', {})
