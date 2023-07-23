local vim = vim
require("mason").setup()
require("mason-lspconfig").setup()
local on_attach = require("common").on_attach
local capabilities = require("common").capabilities


-- Setup nvim-cmp.
local cmp = require('cmp')

vim.cmd([[
set shortmess+=c
]])


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

require('lspconfig').gopls.setup {
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

require('lspconfig').clangd.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require('lspconfig').solargraph.setup {
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
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities,

    -- For further configuration: https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
    settings = {
        formatCommand = {"black"},
        pylsp = {
            plugins = {
                black = { enabled = true, line_length = 80 },
                flake8 = { enabled = true, indentSize = 4 },
                pyls_isort = { enabled = true },
                pyflakes = { enabled = true },
                pycodestyle = { enabled = false },
                pylint = { enabled = true, executable = "pylint" },
            },
        },
    },
}

require('lspconfig').pyright.setup {
    cmd = { 'pyright-langserver', '--stdio' },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
    settings = {
        pyright = {
            autoImportCompletions = true,
            typeCheckingMode = 'basic',
            useLibraryCodeForTypes = true,
        }
    }
}

require('lspconfig').lua_ls.setup {
    cmd = { 'lua-language-server' },
    capabilities = capabilities,
    on_attach = on_attach
}

require('lspconfig').bashls.setup {
    cmd = { 'bash-language-server', 'start' },
    single_file_support = true,
    capabilities = capabilities,
    on_attach = on_attach
}

require('lspconfig').eslint.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

require 'lspconfig'.tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require 'lspconfig'.zls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require('lspconfig').yamlls.setup {}

require('lint').linters_by_ft = {
    --markdown = {'vale'},
    sh = { 'shellcheck' },
}

vim.api.nvim_create_autocmd({'BufWritePre'}, {
    pattern = {"*.py", ".cc", ".cpp", ".java", ".sh"},
    callback = function()
        vim.lsp.buf.format({async = true})
    end
})
