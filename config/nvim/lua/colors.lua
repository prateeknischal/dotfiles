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
vim.g.gruvbox_material_palette = 'original'
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_visual = 'blue background'
vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
vim.g.gruvbox_material_statusline_style = 'original'
vim.g.gruvbox_material_better_performance = 1

