require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "bashls",
        "yamlls",
        "omnisharp",
        "pylsp",
        "clangd",
        "tsserver",
        "jdtls",
    },
    automatic_installation = true,
})

