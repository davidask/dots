local utils = require("utils")

local fn = vim.fn

-- Disable some builtin plugins.
local disabled_built_ins = {
  "2html_plugin",
  "gzip",
  "matchit",
  "rrhelper",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "logipat",
  "spellfile_plugin",
}
for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Install packer.nvim if it's not installed.
local packer_bootstrap
if not utils.is_plugin_installed("packer.nvim") then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    utils.plugins_path .. "/start/packer.nvim",
  })
  vim.cmd([[packadd packer.nvim]])
end

return require("packer").startup({
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
      event = { "BufRead", "BufNewFile" },
    })

    use({
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
    })

    -- Themes

    use({
      "rose-pine/neovim",
      config = function() end,
    })

    use({
      "sainnhe/everforest",
    })

    use({
      "nvim-lualine/lualine.nvim",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("plugins.configs.statusline")
      end,
    })

    use({
      "crispgm/nvim-tabline",
      config = function()
        require("tabline").setup({})
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

    use({ "folke/todo-comments.nvim" })

    use({
      "lewis6991/gitsigns.nvim",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("plugins.configs.gitsigns")
      end,
    })

    use({
      "windwp/nvim-autopairs",
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

    -- Telescope

    use({
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      cmd = "Telescope",
      setup = function()
        require("mappings").telescope()
      end,
    })

    use({ "nvim-telescope/telescope-file-browser.nvim", after = "telescope-fzf-native.nvim" })

    use({ "nvim-telescope/telescope-github.nvim", after = "telescope-file-browser.nvim" })

    use({ "nvim-telescope/telescope-ui-select.nvim", after = "telescope-github.nvim" })

    use({ "nvim-telescope/telescope-project.nvim", after = "telescope-ui-select.nvim" })

    use({
      "nvim-telescope/telescope.nvim",
      after = "telescope-project.nvim",
      config = function()
        require("plugins.configs.telescope")
      end,
    })

    -- use({
    --   "lukas-reineke/indent-blankline.nvim",
    --   event = { "BufRead", "BufNewFile" },
    --   config = function()
    --     require("indent_blankline").setup({
    --       show_trailing_blankline_indent = false,
    --       indent_blankline_use_treesitter = true,
    --       show_first_indent_level = true,
    --       show_current_context = true,
    --     })
    --   end,
    -- })

    use({
      "windwp/nvim-ts-autotag",
      ft = {
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "svelte",
        "vue",
        "tsx",
        "jsx",
        "rescript",
        "xml",
        "php",
        "markdown",
        "glimmer",
        "handlebars",
        "hbs",
      },
    })

    -- Completion

    use({
      "hrsh7th/nvim-cmp",
      config = function()
        require("plugins.configs.cmp")
      end,
    })

    use({
      "L3MON4D3/LuaSnip",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    })

    use({
      "saadparwaiz1/cmp_luasnip",
      after = "LuaSnip",
    })

    use({
      "hrsh7th/cmp-nvim-lua",
      ft = "lua",
      after = "cmp_luasnip",
    })

    use({
      "hrsh7th/cmp-buffer",
      after = "nvim-cmp",
    })

    use({
      "hrsh7th/cmp-nvim-lsp",
      after = { "nvim-cmp", "nvim-lspconfig" },
    })

    use({
      "hrsh7th/cmp-path",
      after = "cmp-buffer",
    })

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
        require("plugins.configs.lsp_signature")
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
      "jose-elias-alvarez/null-ls.nvim",
      after = "mason.nvim",
    })

    use({
      "neovim/nvim-lspconfig",
      after = "null-ls.nvim",
      config = function()
        require("plugins.configs.lspconfig")
      end,
    })

    use({
      "williamboman/mason-lspconfig",
      after = {
        "nvim-lspconfig",
        "mason.nvim",
      },
      config = function()
        require("mason-lspconfig").setup()
      end,
    })

    use({
      "tpope/vim-fugitive",
      setup = function()
        require("mappings").fugitive()
      end,
    })

    use({
      "mfussenegger/nvim-dap",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("plugins.configs.dap")
      end,
    })

    use({
      "rcarriga/nvim-dap-ui",
      after = { "mason.nvim", "nvim-dap" },
      config = function()
        require("plugins.configs.dapui")
      end,
      setup = function()
        require("mappings").dap()
      end,
    })

    use({
      "Shatur/neovim-cmake",
      event = { "BufRead", "BufNewFile" },
      cmd = { "CMake", "CM" },
      ft = { "c", "cpp", "cmake" },
      after = { "nvim-dap", "telescope.nvim" },
      config = function()
        require("plugins.configs.cmake")
      end,
      setup = function()
        require("mappings").cmake()
      end,
    })

    if packer_bootstrap then
      require("packer").sync()
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
