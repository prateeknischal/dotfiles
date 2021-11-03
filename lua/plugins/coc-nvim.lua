local nvim_set_keymap = require('common').nvim_set_keymap;
local silent = { silent = true }

nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', silent)
nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', silent)
nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', silent)
nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', silent)
nvim_set_keymap('n', 'gu', '<Plug>(coc-rename)', silent)

