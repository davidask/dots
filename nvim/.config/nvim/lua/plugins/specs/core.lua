return {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  "alvarosevilla95/luatab.nvim",
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end,
  },
  {
    "stevearc/resession.nvim",
    opts = {},
  },
}
