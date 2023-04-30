-- https://github.com/crisidev/dotfiles/blob/main/home/.config/lvim/lua/user/lsp/java.lua
local vim = vim
local capabilities = require('common').capabilities

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

local root_markers = { '.git', 'Config', 'pom.xml', 'build.xml', 'build.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)

if root_dir == '' then
    return
end

local home = vim.env.HOME
local WORKSPACE_PATH = home .. "/.cache/jdtls/workspace"

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = WORKSPACE_PATH .. project_name

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
        require("jdtls.dap").setup_dap_main_class_configs()
        require("jdtls").setup_dap { hotcodereplace = "auto" }

        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>i', '<cmd>lua require("jdtls").organize_imports()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>s', '<cmd>lua require("jdtls").super_implementation()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>m', '<cmd>lua require("jdtls").extract_method()<CR>', opts)

        -- call the base on_attach handler
        require('common').on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    root_dir = root_dir,
    settings = {
        java = {
            -- jdt = {
            --   ls = {
            --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
            --   }
            -- },
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
                --settings = {
                    --profile = "GoogleStyle",
                    --url = home .. "/.config/lvim/.java-google-formatter.xml",
                --},
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
    },
}

jdtls.start_or_attach(config)
