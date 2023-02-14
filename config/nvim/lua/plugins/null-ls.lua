local null_ls = require('null-ls')
local nvim_set_keymap = require('common').nvim_set_keymap
local vim = vim

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.cfn_lint,
    },
})

nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', {noremap = true})

