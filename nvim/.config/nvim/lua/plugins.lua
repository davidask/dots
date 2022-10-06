local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer = require("packer")

return packer.startup({
  function(use)
    use({
      "wbthomason/packer.nvim",
      config = function()
        require("plugins")
      end,
    })
    use("lewis6991/impatient.nvim")

    use({ "nvim-lua/plenary.nvim", module = "plenary" })

    use({
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
    })

    use({
      "iamcco/markdown-preview.nvim",
      cmd = {
        "MarkdownPreview",
      },
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
    })

    -- Themes

    use("rose-pine/neovim")

    use("sainnhe/everforest")

    use("folke/tokyonight.nvim")

    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("configs.statusline")
      end,
    })

    use({
      "nanozuki/tabby.nvim",
      config = function()
        require("tabby").setup()
      end,
    })

    use({
      "nvim-treesitter/nvim-treesitter",
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
      config = function()
        require("configs.gitsigns")
      end,
    })

    use({
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
        require("configs.autopairs")
      end,
    })

    use({
      "numToStr/Comment.nvim",
      module = "Comment",
      keys = { "gc", "gb" },
      config = function()
        require("Comment").setup()
      end,
    })

    -- Telescope

    use({ "nvim-telescope/telescope-project.nvim", cmd = "Telescope" })
    use({ "nvim-telescope/telescope-file-browser.nvim", after = "telescope-project.nvim" })
    use({ "nvim-telescope/telescope-ui-select.nvim", after = "telescope-file-browser.nvim" })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", after = "telescope-ui-select.nvim" })

    use({
      "nvim-telescope/telescope.nvim",
      after = "telescope-fzf-native.nvim",
      setup = function()
        require("mappings").telescope()
      end,
      config = function()
        require("configs.telescope")
      end,
    })

    -- Completion

    use({
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      config = function()
        require("configs.cmp")
      end,
    })

    use({ "L3MON4D3/LuaSnip", after = "nvim-cmp" })
    use({ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" })
    use({ "hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" })
    use({ "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" })
    use({ "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-path", after = "cmp-buffer" })

    use({
      "ray-x/lsp_signature.nvim",
      event = "InsertEnter",
      config = function()
        require("configs.lsp_signature")
      end,
    })

    use({
      "williamboman/mason.nvim",
      config = function()
        require("configs.mason")
      end,
    })

    use({
      "williamboman/mason-lspconfig.nvim",
      requires = {
        "williamboman/mason.nvim",
      },
      config = function()
        require("configs.mason-lspconfig")
      end,
    })

    use({ "jose-elias-alvarez/null-ls.nvim", after = "mason-lspconfig.nvim",
      events = { "BufRead", "BufWinEnter", "BufNewFile" } })
    use({ "simrat39/rust-tools.nvim", after = "null-ls.nvim" })

    use({
      "neovim/nvim-lspconfig",
      after = "rust-tools.nvim",
      config = function()
        require("configs.lspconfig")
      end,
    })
    --
    -- use({
    --   "Shatur/neovim-cmake",
    --   after = { "plenary.nvim", "nvim-dap" },
    --   config = function()
    --     require("cmake").setup({
    --       dap_configuration = {
    --         type = "lldb",
    --         request = "launch",
    --         stopOnEntry = false,
    --         runInTerminal = false,
    --       },
    --     })
    --   end,
    -- })
    --
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

    if packer_bootstrap then
      packer.sync()
    end
  end,
  config = {
    auto_clean = true,
    compile_on_sync = true,
    git = { clone_timeout = 6000 },
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
