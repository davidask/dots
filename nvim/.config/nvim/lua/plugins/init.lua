local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  "nvim-lua/plenary.nvim",

  "kyazdani42/nvim-web-devicons",
  "alvarosevilla95/luatab.nvim",

  { "catppuccin/nvim", lazy = false, priority = 1000 },

  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
  },

  {
    "dmmulroy/ts-error-translator.nvim",

    config = function()
      require("ts-error-translator").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },

  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("octo").setup()
    end,
  },

  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end,
  },

  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "nvim-lualine/lualine.nvim",

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  "terrortylor/nvim-comment",

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },

  -- Completion

  "hrsh7th/nvim-cmp",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",

  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },

  {
    "stevearc/resession.nvim",
    opts = {},
  },

  -- LSP
  "ray-x/lsp_signature.nvim",

  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "simrat39/rust-tools.nvim",
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        yaml = { "cfn_lint" },
        go = { "golangcilint" },
        sh = { "shellcheck" },
      }
    end,
  },
  {
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup({
        filetype = {
          go = {
            require("formatter.filetypes.go").gofmt,
          },

          json = {
            require("formatter.filetypes.json").biome,
            require("formatter.filetypes.json").prettierd,
          },

          jsonc = {
            require("formatter.filetypes.json").biome,
            require("formatter.filetypes.json").prettierd,
          },

          lua = {
            require("formatter.filetypes.lua").stylua,
          },

          sh = {
            require("formatter.filetypes.sh").shfmt,
          },

          typescript = {
            require("formatter.filetypes.json").biome,
            require("formatter.filetypes.typescript").prettierd,
          },

          typescriptreact = {
            require("formatter.filetypes.json").biome,
            require("formatter.filetypes.typescriptreact").prettierd,
          },

          css = {
            require("formatter.filetypes.json").biome,
            require("formatter.filetypes.css").prettierd,
          },

          sql = {
            require("formatter.filetypes.sql").pgformat,
          },

          ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace,
          },
        },
      })

      require("mappings").formatter()
    end,
  },
  "neovim/nvim-lspconfig",

  "andymass/vim-matchup",
})

require("plugins.configs.treesitter")
require("todo-comments").setup()
require("nvim_comment").setup()
require("plugins.configs.cmp")

require("plugins.configs.lsp_signature")
require("plugins.configs.mason")
require("plugins.configs.mason-lspconfig")
require("plugins.configs.lspconfig")
require("plugins.configs.telescope")
require("luatab").setup({})
require("plugins.configs.debugger")
