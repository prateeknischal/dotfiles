local nvim_set_keymap = require('common').nvim_set_keymap
local set_keymap = require('common').set_keymap

local opt = {noremap = true}
local sn = {silent = true, noremap = true}

-- splits
nvim_set_keymap('n', '<leader>h', ':wincmd h<CR>', opt)
nvim_set_keymap('n', '<leader>j', ':wincmd j<CR>', opt)
nvim_set_keymap('n', '<leader>k', ':wincmd k<CR>', opt)
nvim_set_keymap('n', '<leader>l', ':wincmd l<CR>', opt)
nvim_set_keymap('n', '<leader>H', ':wincmd H<CR>', opt)
nvim_set_keymap('n', '<leader>K', ':wincmd K<CR>', opt)

-- tabs
nvim_set_keymap('n', '<leader>a', 'gt', opt)
nvim_set_keymap('n', '<leader>f', 'gT', opt)

-- something
nvim_set_keymap('n', ';w', ':w', opt)
nvim_set_keymap('n', ';q', ':q', opt)

-- resize
nvim_set_keymap('n', '<leader>=', ':vertical resize +5<CR>', sn)
nvim_set_keymap('n', '<leader>-', ':vertical resize -5<CR>', sn)

-- buffers
nvim_set_keymap('n', '<leader>;', ':Buffers<CR>', opt)
set_keymap('n', '<leader>]', 'bnext')
set_keymap('n', '<leader>[', 'bprev')

-- terminal mode
nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', opt) -- get out of terminal mode

-- tab
set_keymap('n', '<leader>t[', ':tabmove -1<CR>')
set_keymap('n', '<leader>t]', ':tabmove +1<CR>')
set_keymap('n', '<leader>1', '1gt')
set_keymap('n', '<leader>2', '2gt')
set_keymap('n', '<leader>3', '3gt')
set_keymap('n', '<leader>4', '4gt')
set_keymap('n', '<leader>5', '5gt')
set_keymap('n', '<leader>6', '6gt')
set_keymap('n', '<leader>7', '7gt')
set_keymap('n', '<leader>8', '8gt')
set_keymap('n', '<leader>9', '9gt')
set_keymap('n', '<leader>0', ':tablast<CR>')

-- telescope key bindings
nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', opt)
nvim_set_keymap('n', '<leader>ff', ':Telescope live_grep<CR>', opt)
nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', opt)
nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', opt)
