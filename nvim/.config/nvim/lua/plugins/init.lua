local present, packer = pcall(require, "plugins.packerinit")

if not present then
  return false
end

return packer.startup(function(use)
  use("nvim-lua/plenary.nvim")
  use("lewis6991/impatient.nvim")

  use({
    "wbthomason/packer.nvim",
    event = "VimEnter",
  })

  use({
    "kyazdani42/nvim-web-devicons",
    after = "theme",
  })

  use({
    "rose-pine/neovim",
    as = "theme",
    config = function()
      require("plugins.configs.theme").setup()
    end,
  })

  use({
    "nvim-lualine/lualine.nvim",
    after = "theme",
    config = function()
      require("plugins.configs.statusline")
    end,
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    run = ":TSUpdate",
    config = function()
      require("plugins.configs.treesitter")
    end,
  })

  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      -- HACK: #104 Invalid in command-line window
      local hl = require("todo-comments.highlight")
      local highlight_win = hl.highlight_win
      hl.highlight_win = function(win, force)
        pcall(highlight_win, win, force)
      end
      require("todo-comments").setup({
        highlight = {
          before = "fg",
          keyword = "wide",
          after = "fg",
        },
      })
    end,
  })

  use({
    "lewis6991/gitsigns.nvim",
    opt = true,
    config = function()
      require("plugins.configs.gitsigns")
    end,
    setup = function()
      require("core.utils").packer_lazy_load("gitsigns.nvim")
    end,
  })

  use({
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.autopairs")
    end,
  })

  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    module = "telescope",
    requires = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-github.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-project.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    },
    setup = function()
      require("core.mappings").telescope()
    end,

    config = function()
      require("plugins.configs.telescope")
    end,
  })

  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.configs.cmp")
    end,
  })

  use({
    "L3MON4D3/LuaSnip",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.luasnip")
    end,
  })

  use({
    "saadparwaiz1/cmp_luasnip",
    after = "LuaSnip",
  })

  use({
    "hrsh7th/cmp-nvim-lua",
    after = "cmp_luasnip",
  })

  use({
    "hrsh7th/cmp-nvim-lsp",
    after = "cmp-nvim-lua",
  })

  use({
    "hrsh7th/cmp-buffer",
    after = "cmp-nvim-lsp",
  })

  use({
    "hrsh7th/cmp-path",
    after = "cmp-buffer",
  })

  use({
    "andymass/vim-matchup",
    opt = true,
    setup = function()
      require("core.utils").packer_lazy_load("vim-matchup")
    end,
  })

  use({
    "ray-x/lsp_signature.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("plugins.configs.lsp_signature")
    end,
  })

  use({
    "williamboman/nvim-lsp-installer",
    opt = true,
    setup = function()
      require("core.utils").packer_lazy_load("nvim-lsp-installer")
      -- reload the current file so lsp actually starts for it
      vim.defer_fn(function()
        vim.cmd('if &ft == "packer" | echo "" | else | silent! e %')
      end, 0)
    end,
  })

  use({
    "neovim/nvim-lspconfig",
    after = "nvim-lsp-installer",
    module = "lspconfig",
    requires = { "jose-elias-alvarez/null-ls.nvim" },
    config = function()
      require("plugins.configs.lsp_installer")
      require("plugins.configs.lspconfig")
    end,
  })

  use({
    "tpope/vim-fugitive",
    setup = function()
      require("core.mappings").fugitive()
    end,
  })
end)
