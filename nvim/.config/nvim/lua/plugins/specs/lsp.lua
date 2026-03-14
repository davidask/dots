return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  "ray-x/lsp_signature.nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
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
  "neovim/nvim-lspconfig",
}
