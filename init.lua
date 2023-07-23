-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
local vim = vim

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
local packerpath = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false
if not vim.loop.fs_stat(packerpath) then
  vim.fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim.git',
    packerpath,
  }

  packer_bootstrap = true
end

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'scrooloose/nerdcommenter'
  use 'airblade/vim-gitgutter'
  use 'morhetz/gruvbox'
  use 'itchyny/lightline.vim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'ray-x/lsp_signature.nvim'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'winston0410/mark-radar.nvim'
  use 'hrsh7th/vim-vsnip'
  use 'L3MON4D3/LuaSnip'
  use 'simrat39/rust-tools.nvim'

  use 'mfussenegger/nvim-lint'
  use 'mfussenegger/nvim-jdtls'
  use 'mfussenegger/nvim-dap'

  use 'cespare/vim-toml'
  use 'vmchale/ion-vim'
  use 'jose-elias-alvarez/null-ls.nvim'
  --use { 'fatih/vim-go', run = ':GoUpdateBinaries' }
  --use { 'rust-lang/rust.vim' }
end)

if packer_bootstrap then
  require('packer').sync()
end

-- [[ Setting options ]]
-- See `:help vim.o`
local set_opts = function(opts)
  for key, val in pairs(opts) do
    if val == true then
      vim.api.nvim_command('set ' .. key)
    elseif val == false then
      vim.api.nvim_command('set no' .. key)
    else
      vim.api.nvim_command('set ' .. key .. '=' .. val)
    end
  end
end

set_opts({
  -- buffer
  tabstop = 4,
  shiftwidth = 4,
  expandtab = true,
  textwidth = 80,
  autoindent = true,

  -- window
  colorcolumn = 80,
  number = true,
  cmdheight = 2,

  -- editing
  swapfile = false,
  undofile = true,
  backup = false,
  foldmethod = 'manual',
  undodir = '~/.vimundo',
  hidden = true,
  incsearch = true,
  mouse = 'nv',
})

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.o.undodir = '~/.vimundo'

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Search options
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.hlsearch = false

vim.o.foldmethod = 'manual'
vim.o.hidden = true


-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.g.nerdspacedelims = 1
vim.g.nerdcommentemptylines = 1
vim.g.nerdtrimtrailingwhitespace = 1
vim.g.nerdtogglecheckalllines = 1

vim.cmd([[
  augroup TrimWhitespace
  autocmd BufWritePre * :%s/\s\+$//e
  augroup END
]])
-- [[ Editor color setup ]]

if vim.fn.has('termguicolors') then
  vim.cmd('let &t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"')
  vim.cmd('let &t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"')
  vim.cmd('set termguicolors')
end

-- [[ Gruvbox setup ]]
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.background = 'dark'

vim.g.gruvbox_material_palette = 'original'
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_visual = 'blue background'
vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
vim.g.gruvbox_material_statusline_style = 'original'
vim.g.gruvbox_material_better_performance = 1

vim.cmd('colorscheme ' .. 'gruvbox')

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Nvim Keymaps ]]

-- splits
vim.keymap.set('n', '<leader>f', ':wincmd h<CR>', { silent = true })
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>', { silent = true })
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>', { silent = true })
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>', { silent = true })
vim.keymap.set('n', '<leader>H', ':wincmd H<CR>', { silent = true })
vim.keymap.set('n', '<leader>K', ':wincmd K<CR>', { silent = true })

-- pinky keymaps
vim.keymap.set('n', ';w', ':w', { silent = true })
vim.keymap.set('n', ';q', ':q', { silent = true })

-- resize windows
vim.keymap.set('n', '<leader>=', ':vertical resize +5<CR>', { silent = true })
vim.keymap.set('n', '<leader>-', ':vertical resize -5<CR>', { silent = true })

-- buffers
vim.keymap.set('n', '<leader>;', ':Buffers<CR>', { silent = true })
vim.keymap.set('n', '<leader>]', 'bnext', { silent = true })
vim.keymap.set('n', '<leader>[', 'pnext', { silent = true })

-- tabs
vim.keymap.set('n', '<leader>a', 'gt', { silent = true })
vim.keymap.set('n', '<leader>f', 'gT', { silent = true })
vim.keymap.set('n', '<leader>t[', ':tabmove -1<CR>', { silent = true })
vim.keymap.set('n', '<leader>t]', ':tabmove +1<CR>', { silent = true })
vim.keymap.set('n', '<leader>1', '1gt', { silent = true })
vim.keymap.set('n', '<leader>2', '2gt', { silent = true })
vim.keymap.set('n', '<leader>3', '3gt', { silent = true })
vim.keymap.set('n', '<leader>4', '4gt', { silent = true })
vim.keymap.set('n', '<leader>5', '5gt', { silent = true })
vim.keymap.set('n', '<leader>6', '6gt', { silent = true })
vim.keymap.set('n', '<leader>7', '7gt', { silent = true })
vim.keymap.set('n', '<leader>8', '8gt', { silent = true })
vim.keymap.set('n', '<leader>9', '9gt', { silent = true })
vim.keymap.set('n', '<leader>0', ':tablast<CR>', { silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}


-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>m', require('telescope.builtin').marks, { desc = "Show all marks" });
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>p', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  pyright = {},
  pylsp = {
    formatCommand = { "black" },
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
  -- solargraph = {},
  rust_analyzer = {},
  tsserver = {},
  eslint = {},
  yamlls = {},
  bashls = {},


  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
require('mason').setup()
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

require('lsp_signature').setup({
  bind = true,
  handler_opts = {
    border = "rounded",
  },
  floating_window = true,
  hint_enable = false,        -- disable virtual text hint
  hi_parameter = "IncSearch", -- highlight group used to highlight the current parameter
  toggle_key = "<M-x>",       -- toggle signature on and off in insert mode
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
