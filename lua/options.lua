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
    clipboard = 'unnamed',

    -- window
    colorcolumn = 80,
    relativenumber = true,
    number = true,
    cmdheight = 2,

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
    mouse = 'nv',
})

-- rg derive root
vim.g.rg_derive_root = 'true'

-- rust globals
vim.g.rustfmt_autosave = 1

-- vim-go options
vim.g.go_fmt_command = 'goimports'
vim.g.go_auto_type_info = 1
vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_generate_tags = 1
vim.g.go_doc_popup_window = 1

