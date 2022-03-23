local vim = vim

if vim.fn.has('termguicolors') then
    vim.cmd('let &t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"')
    vim.cmd('let &t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"')
    vim.cmd('set termguicolors')
end

-- theme
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.background = 'dark'

vim.cmd('colorscheme gruvbox')
-- vim.cmd('colorscheme codedark')
