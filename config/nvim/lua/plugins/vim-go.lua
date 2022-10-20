local nvim_set_keymap = require('common').nvim_set_keymap
local nvim_lsp = require('lspconfig')
local vim = vim

--vim.g.go_fmt_autosave = 1
--vim.g.go_fmt_command = 'goimports'
--vim.g.go_info_mode = 'gopls'
--vim.g.go_auto_type_info = 1

---- vim-go specific key bindings
--nvim_set_keymap('n', '<leader>k', '<Plug>(go-info)', {})
--nvim_set_keymap('n', '<leader>e', '<Plug>(go-describe)', {})
--nvim_set_keymap('n', '<leader>c', '<Plug>(go-callers)', {})

nvim_set_keymap('n', '<leader>T', ':!go generate % 2>&1 1>/dev/null<CR><CR>', { silent = true })

-- https://www.getman.io/posts/programming-go-in-neovim/
function goimports(timeout_ms)
    local context = { source = { organizeImports = true } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
        if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit)
        end
        if type(action.command) == "table" then
            vim.lsp.buf.execute_command(action.command)
        end
    else
        vim.lsp.buf.execute_command(action)
    end
end



vim.cmd[[
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go lua goimports(1000)
]]
