local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
  },
})

return packer.startup({
  function(use)
    use({ "wbthomason/packer.nvim" })

    use("nvim-lua/plenary.nvim")

    use({
      "lewis6991/impatient.nvim",
      config = function()
        require("impatient")
      end,
    })
    use({
      "antoinemadec/FixCursorHold.nvim",
      event = { "BufRead", "BufNewFile" },
    })

    use({
      "kyazdani42/nvim-web-devicons",
    })

    use({
      "folke/twilight.nvim",
      cmd = {
        "Twilight",
        "TwilightEnable",
        "TwiLightDisable",
      },
      config = function()
        require("twilight").setup({})
      end,
    })

    use({
      "folke/persistence.nvim",
      event = "BufReadPre",
      module = "persistence",
      config = function()
        require("persistence").setup()
      end,
    })

    use({
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
    })

    -- Themes

    use({ "rose-pine/neovim" })

    use({ "sainnhe/everforest" })

    -- use({
    --   "nvim-lualine/lualine.nvim",
    --   event = { "BufRead", "BufNewFile" },
    --   config = function()
    --     require("configs.statusline")
    --   end,
    -- })

    -- use({
    --   "nanozuki/tabby.nvim",
    --   config = function()
    --     require("tabby").setup()
    --   end,
    -- })

    use({
      "nvim-treesitter/nvim-treesitter",
      event = { "BufRead", "BufNewFile" },
      run = ":TSUpdate",
      config = function()
        require("configs.treesitter")
      end,
    })

    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup()
      end,
    })

    use({
      "lewis6991/gitsigns.nvim",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("configs.gitsigns")
      end,
    })

    use({
      "windwp/nvim-autopairs",
      config = function()
        require("configs.autopairs")
      end,
    })

    use({
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    })

    -- Telescope

    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        "nvim-telescope/telescope-project.nvim",
      },
      setup = function()
        require("mappings").telescope()
      end,
      config = function()
        require("configs.telescope")
      end,
    })

    -- use({
    --   "windwp/nvim-ts-autotag",
    --   ft = {
    --     "html",
    --     "javascript",
    --     "typescript",
    --     "javascriptreact",
    --     "typescriptreact",
    --     "svelte",
    --     "vue",
    --     "tsx",
    --     "jsx",
    --     "rescript",
    --     "xml",
    --     "php",
    --     "markdown",
    --     "glimmer",
    --     "handlebars",
    --     "hbs",
    --   },
    -- })

    -- Completion

    -- use({
    --   "hrsh7th/nvim-cmp",
    --   requires = {
    --     "L3MON4D3/LuaSnip",
    --     "saadparwaiz1/cmp_luasnip",
    --     "hrsh7th/cmp-nvim-lua",
    --     "hrsh7th/cmp-buffer",
    --     "hrsh7th/cmp-nvim-lsp",
    --     "hrsh7th/cmp-path",
    --   },
    --   after = {
    --     "nvim-lspconfig",
    --   },
    --   config = function()
    --     require("configs.cmp")
    --   end,
    -- })

    use({
      "andymass/vim-matchup",
      event = { "BufRead", "BufNewFile" },
      config = function()
        vim.g.matchup_matchparen_offscreen = {}
      end,
    })

    use({
      "ray-x/lsp_signature.nvim",
      event = "InsertEnter",
      config = function()
        require("configs.lsp_signature")
      end,
    })

    use({
      "williamboman/mason.nvim",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("mason").setup()
      end,
    })

    use({
      "williamboman/mason-lspconfig.nvim",
      after = {
        "mason.nvim",
      },
      config = function()
        require("mason-lspconfig").setup()
      end,
    })

    use({
      "neovim/nvim-lspconfig",
      requires = { "jose-elias-alvarez/null-ls.nvim", "simrat39/rust-tools.nvim" },
      after = "mason-lspconfig.nvim",
      config = function()
        require("configs.lspconfig")
      end,
    })

    use({
      "Shatur/neovim-cmake",
      after = { "plenary.nvim", "nvim-dap" },
      config = function()
        require("cmake").setup({
          dap_configuration = {
            type = "lldb",
            request = "launch",
            stopOnEntry = false,
            runInTerminal = false,
          },
        })
      end,
    })

    use({
      "tpope/vim-fugitive",
    })

    use({
      "mfussenegger/nvim-dap",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("configs.dap")
      end,
    })

    use({
      "rcarriga/nvim-dap-ui",
      after = { "mason.nvim", "nvim-dap" },
      config = function()
        require("configs.dapui")
      end,
      setup = function()
        require("mappings").dap()
      end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      packer.sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
