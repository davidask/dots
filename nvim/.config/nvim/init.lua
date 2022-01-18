local fn = vim.fn

-- Only run these settings once
if not packer_plugins then
  require("config.mappings").setup()
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "
  vim.opt.termguicolors = true
  vim.opt.clipboard = "unnamed"
  vim.opt.encoding = "utf-8"
  vim.opt.fileencoding = "utf-8"
  vim.opt.compatible = false
end

vim.opt.path:append({ "**" })
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildmenu = true
vim.opt.wildignore:append({ "**/.git/", "**/node_modules/" })

-- vim.opt.showmode = false
vim.opt.timeoutlen = 500
vim.opt.updatetime = 300
vim.wo.signcolumn = "yes"
vim.opt.scrolloff = 12
vim.opt.wrap = false
vim.opt.ttimeoutlen = 5
vim.opt.undofile = true
vim.opt.undodir = fn.stdpath("data") .. "undo"
vim.opt.shell = "/bin/zsh"
vim.opt.cursorline = false

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Search
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- -- Shorter messages
-- vim.opt.shortmess:append({ c = true })
-- vim.opt.cmdheight = 2

-- Indent Settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- Completion
vim.opt.completeopt = "menu,menuone,noselect"

--  No annoying sound on errors
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Turn backup off, since most stuff is in SVN, git etc. anyway...
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

-- Netrw
vim.g.netrw_banner = 0 -- Hide banner
vim.g.netrw_liststyle = 4

-- Fillchars
vim.opt.fillchars = {
  vert = "│",
  fold = "⠀",
  eob = " ", -- suppress ~ at EndOfBuffer
  --diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸",
}

local map = vim.api.nvim_set_keymap

map("n", "Q", "<nop>", { silent = true, noremap = true })

-- Prefer ripgrep if it exists
if fn.executable("rg") > 0 then
  vim.o.grepprg = "rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*"
  vim.opt.grepformat = vim.opt.grepformat ^ { "%f:%l:%c:%m" }
end

-- Run PackerCompile after saving init.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])

-- Hide line numbers in terminal
vim.cmd([[
  augroup term
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
  augroup end
]])

-- Auto reload buffers when changed outside of Vim
vim.opt.autoread = true

vim.cmd([[
  au FocusGained * :checktime
]])

-- Make containing directory if missing
vim.cmd("autocmd BufWritePre * silent! Mkdir! ")

-- Install packer if not installed
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

return require("packer").startup({
  function(use)
    -- Packer (needed to manage packer packages to manage packages to manage...)
    use("wbthomason/packer.nvim")

    -- Theme
    use({
      "folke/tokyonight.nvim",
      requires = "folke/lsp-colors.nvim",
      config = function()
        require("config.theme").setup()
      end,
    })

    use({
      "projekt0n/github-nvim-theme",
    })

    -- Pointless rice project; the statusline. Pick a nice one that works
    -- ootb and leave it there.
    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("config.theme").setup()
      end,
    })

    -- Which key is that? Which-key!
    use({
      "folke/which-key.nvim",
      config = function()
        require("config.which-key").setup()
      end,
    })

    use({
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup({ map_cr = true })
      end,
      modue = "nvim-autopairs",
    })

    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup({
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        })
      end,
    })

    -- Lua
    use({
      "folke/twilight.nvim",
      config = function()
        require("twilight").setup({
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        })
      end,
    })

    -- The big daddy
    use({
      "nvim-telescope/telescope.nvim",
      config = function()
        require("config.telescope").setup()
      end,
      event = "VimEnter",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-dap.nvim",
        "nvim-telescope/telescope-github.nvim",
        "kyazdani42/nvim-web-devicons",
      },
    })

    -- 􏿽
    -- use("chrisbra/unicode.vim")

    -- Comment all the things
    use("tpope/vim-commentary")

    -- Add "end" in ruby, lua, etc
    use("tpope/vim-endwise")

    -- Unix helpers
    use("tpope/vim-eunuch")

    -- The git plugin so good, it should be illegal
    use("tpope/vim-fugitive")

    -- Enable repeating supported plugin maps with "."
    use("tpope/vim-repeat")

    -- GitHub extension for fugitive.vim
    use("tpope/vim-rhubarb")

    use("tpope/vim-vinegar")

    --  Quoting/parenthesizing made simple
    use("tpope/vim-surround")

    use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })

    -- Syntax and speed
    -- Sitting in a tree
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      requires = {
        "nvim-treesitter/playground", -- Debug tool for treesitter
      },
      config = function()
        require("config.treesitter").setup()
      end,
    })

    -- Git changes in the gutter
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup({
          keymaps = {},
        })
      end,
      requires = "nvim-lua/plenary.nvim",
    })

    use({
      "mfussenegger/nvim-dap",
      config = function()
        require("config.dap").setup()
        -- require("nvim-dap-virtual-text").setup()
      end,
      module = "dap",
      requires = { "jbyuki/one-small-step-for-vimkind", "theHamsta/nvim-dap-virtual-text" },
    })

    -- UI for above
    use({ "rcarriga/nvim-dap-ui", module = "dapui" })

    -- EZ installer for DAP servers
    use({
      "Pocco81/DAPInstall.nvim",
      module = "dap-install",
    })

    -- Fancy IDE stuff
    use({
      "neovim/nvim-lspconfig",
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        "williamboman/nvim-lsp-installer",
        "ray-x/lsp_signature.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        "jose-elias-alvarez/nvim-lsp-ts-utils",
      },
      after = { "which-key.nvim" },
    })

    use({
      "simrat39/rust-tools.nvim",
      module = "rust-tools",
    })

    -- Completion framework
    use({
      "hrsh7th/nvim-cmp",
      config = function()
        require("config.cmp").setup()
      end,
      requires = {
        "nvim-treesitter",
        "hrsh7th/cmp-nvim-lsp",
        "onsails/lspkind-nvim",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
      },
    })

    use({
      "stevearc/dressing.nvim",
      config = function()
        require("dressing").setup({
          input = {
            default_prompt = "❯ ",
          },
        })
      end,
    })

    -- -- -- Faster-than-light jumping
    -- -- use("ggandor/lightspeed.nvim")

    -- Free real estate for startup perf
    use("nathom/filetype.nvim")

    -- -- Delete buffers without wiping layout
    -- use("famiu/bufdelete.nvim")

    -- -- Improve word motions
    -- -- CamelCaseACRONYMWords_underscore1234
    -- -- w--------------------------------->w
    -- -- e--------------------------------->e
    -- -- b<---------------------------------b
    -- --
    -- -- to
    -- --
    -- -- CamelCaseACRONYMWords_underscore1234
    -- -- w--->w-->w----->w---->w-------->w->w
    -- -- e-->e-->e----->e--->e--------->e-->e
    -- -- b<---b<--b<-----b<----b<--------b<-b
    -- use("chaoren/vim-wordmotion")

    -- -- Link lines from repo host
    use({
      "ruifm/gitlinker.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("gitlinker").setup()
      end,
    })

    -- Sync packer if just installed
    if Packer_bootstrap then
      require("packer").sync()
    end
    -- -- Named well, tree of undos
    -- use("mbbill/undotree")
  end,
  config = {
    max_jobs = 50,
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
      log = { level = "warn" },
    },
  },
})
