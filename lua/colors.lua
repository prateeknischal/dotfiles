local vim = vim

if vim.fn.has('termguicolors') then
    vim.cmd('let &t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"')
    vim.cmd('let &t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"')
    vim.cmd('set termguicolors')
end

-- theme
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.background = 'dark'

-- vim.cmd('colorscheme gruvbox')
-- vim.cmd('colorscheme gruvbox-material')
vim.g.gruvbox_material_palette = 'original'
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_visual = 'blue background'
vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
vim.g.gruvbox_material_statusline_style = 'original'
vim.g.gruvbox_material_better_performance = 1

-- Example config in Lua
require("github-theme").setup({
    theme_style = "dark",
    function_style = "italic",
    sidebars = { "qf", "vista_kind", "terminal", "packer" },

    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    colors = { hint = "orange", error = "#ff0000" },

    -- Overwrite the highlight groups
    overrides = function(c)
        return {
            htmlTag = { fg = c.red, bg = "#282c34", sp = c.hint, style = "underline" },
            DiagnosticHint = { link = "LspDiagnosticsDefaultHint" },
            -- this will remove the highlight groups
            TSField = {},
        }
    end
})

vim.cmd('colorscheme github_dark')
