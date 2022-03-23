local vim = vim
local nvim_lsp = require('lspconfig')
local lsp_path = vim.fn.expand('$HOME/.local/share/nvim/lsp_servers')

-- Setup nvim-cmp.
local cmp = require('cmp')

vim.cmd([[
set shortmess+=c
]])

local on_attach = function(client, bufnr)
    vim.g.completion_matching_strategy_list = "['exact', 'substring', 'fuzzy']"

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader>,', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'buffer', keyword_length = 4 },
    { name = 'vsnip' },
  },
})

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = ""
        },
    },

    server = {
        --cmd = { lsp_path .. '/rust/rust-analyzer' },
        on_attach = on_attach,
        settings = {
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

-- setup rust-tools for code completion
require('rust-tools').setup(opts)

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig').gopls.setup{
    cmd = { 'gopls', "serve" },
    flags = {
        debounce_text_changes = 150,
    },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        },
    },
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
    }
}

require('lspconfig').clangd.setup{
    cmd = { lsp_path .. '/clangd/clangd' },
    capabilities = capabilities,
    on_attach = on_attach,
}

require('lspconfig').solargraph.setup{
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        solargraph = {
            --diagnostic = true,
            --formatting = true,
            logLevel = "debug"
        }
    }
}

require('lspconfig').pylsp.setup {
    cmd = { lsp_path .. 'pylsp/venv/bin/pylsp' },
    on_attach = on_attach,
    flags = {
    debounce_text_changes = 150,
    },
    capabilities = capabilities,

    -- For further configuration: https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
    settings = {
    pylsp = {
        configurationSources = "flake8",
        plugins = {
            flake8 = { enabled = true, indentSize = 4 },
            pylsp_black = { enabled = true },
            pyls_isort = { enabled = true },
            pycodestyle = { enabled = false },
            mccabe = { enabled = false },
            pyflakes = { enabled = false },
            yapf = { enabled = false },
            autopep8 = { enabled = false },
        },
    },
    },
}

require('lspconfig').sumneko_lua.setup {
    cmd = { lsp_path .. '/sumneko_lua/extension/server/bin/lua-language-server' },
    capabilities = capabilities,
    on_attach = on_attach
}

require('lspconfig').bashls.setup {
    cmd = { 'node', lsp_path .. '/bash/node_modules/bash-language-server/bin/main.js', 'start' },
    single_file_support = true,
    capabilities = capabilities,
    on_attach = on_attach
}

require('lspconfig').eslint.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

require('lint').linters_by_ft = {
  markdown = {'vale'},
  sh = {'shellcheck'},
}

vim.cmd[[
au BufWritePost <buffer> lua require('lint').try_lint()
]]
-- au filetype go inoremap <buffer> . .<C-x><C-o>
