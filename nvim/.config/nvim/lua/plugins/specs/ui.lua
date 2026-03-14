return {
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
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      auto_preview = false,
      focus = true,
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
    },
  },
}
