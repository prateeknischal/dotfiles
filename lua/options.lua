local vim = vim
local set_options = require('common').set_options
local set_keymap = require('common').set_keymap

vim.g.mapleader = ' '
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')
vim.cmd('set background=dark')

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

if vim.fn.has('termguicolors') then
    vim.cmd('let &t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"')
    vim.cmd('let &t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"')
    vim.cmd('set termguicolors')
end

-- theme
vim.g.gruvbox_contrast_dark = 'hard'
vim.cmd('colorscheme gruvbox')

-- rg derive root
vim.g.rg_derive_root = 'true'

-- rust globals
vim.g.rustfmt_autosave = 1

-- telescope key bindings
set_keymap('n', '<C-p>', ':Telescope find_files<CR>', {})
