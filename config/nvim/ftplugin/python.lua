local vim = vim

vim.api.nvim_command('set colorcolumn=100')
vim.api.nvim_command('set textwidth=100')

vim.api.nvim_create_user_command('Black', '!black %', {})
vim.api.nvim_create_user_command('Isort', '!isort %', {})
