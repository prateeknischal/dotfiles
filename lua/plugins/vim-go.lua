local nvim_set_keymap = require('common').nvim_set_keymap

vim.g.go_fmt_autosave = 1
vim.g.go_fmt_command = 'goimports'
vim.g.go_info_mode = 'gopls'

-- vim-go specific key bindings
nvim_set_keymap('n', '<leader>k', '<Plug>(go-info)', {})
nvim_set_keymap('n', '<leader>e', '<Plug>(go-describe)', {})
nvim_set_keymap('n', '<leader>c', '<Plug>(go-callers)', {})
