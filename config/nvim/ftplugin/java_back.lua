local vim = vim
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- define text options
vim.api.nvim_command("set colorcolumn=120")
vim.api.nvim_command("set textwidth=120")

-- Lsp config
local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
    return
end

-- define paths
local mason_path = vim.fn.stdpath('data') .. '/mason'
local jdtls_dir = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local launcher_path = vim.fn.glob(jdtls_dir .. '/plugins/org.eclipse.equinox.launcher_*.jar')

local config_dir = jdtls_dir .. '/config_linux'
if vim.loop.os_uname().sysname == "Darwin" then
    config_dir = jdtls_dir .. '/config_darwin'
end

local root_dir = require('jdtls.setup').find_root({'packageInfo'}, 'Config')

if root_dir == '' then
    return
end

local home = vim.env.HOME
local WORKSPACE_PATH = home .. "/.cache/jdtls/workspace/"

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = WORKSPACE_PATH .. project_name

local ws_folders_jdtls = {}
if root_dir then
    local file = io.open(root_dir .. '/.bemol/ws_root_folders')
    if file then
        for line in file:lines() do
            table.insert(ws_folders_jdtls, "file://" .. line)
        end

        file:close()
    end
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Debug bundles
local bundles = { vim.fn.glob(mason_path .. "/packages/java-test/extension/server/*.jar", true) }
if #bundles == 0 then
    bundles = { vim.fn.glob(mason_path .. "/packages/java-test/extension/server/*.jar", true) }
end
local extra_bundles = vim.fn.glob(
    mason_path .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
    true
)
if #extra_bundles == 0 then
    extra_bundles = vim.fn.glob(
        mason_path .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
        true
    )
end
vim.list_extend(bundles, { extra_bundles })

-- LSP configuration.
local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. mason_path .. "/packages/jdtls/lombok.jar",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-jar", launcher_path,
        "-configuration", config_dir,
        "-data", workspace_dir,
    },

    on_attach = function(client, bufnr)
        local _, _ = pcall(vim.lsp.codelens.refresh)
        require("jdtls").setup_dap { hotcodereplace = "auto" }
        --require("jdtls.dap").setup_dap_main_class_configs()

        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>i', '<cmd>lua require("jdtls").organize_imports()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>s', '<cmd>lua require("jdtls").super_implementation()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>m', '<cmd>lua require("jdtls").extract_method()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>,', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gc', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
    end,

    capabilities = capabilities,

    settings = {
        java = {
            -- jdt = {
            --   ls = {
            --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
            --   }
            -- },
            saveActions = {
                organizeImports = true,
            },
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            inlayHints = {
                parameterNames = {
                    enabled = "all", -- literals, all, none
                },
            },
            format = {
                enabled = true,
                settings = {
                    profile = "GoogleStyle",
                    url = home .. "/.config/lvim/.java-google-formatter.xml",
                },
            },
        },
        signatureHelp = { enabled = true },
        completion = {},
        contentProvider = { preferred = "fernflower" },
        extendedClientCapabilities = extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
    },
    flags = {
        allow_incremental_sync = true,
        server_side_fuzzy_completion = true,
    },
    init_options = {
        bundles = bundles,
        workspaceFolders = ws_folders_jdtls,
    },
}

jdtls.start_or_attach(config)
