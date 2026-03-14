return {
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
    "dmmulroy/ts-error-translator.nvim",
    config = function()
      require("ts-error-translator").setup()
    end,
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
  },
  "L3MON4D3/LuaSnip",
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          go = { "goimports", "gofmt" },
          json = { "biome", "prettierd", stop_after_first = true },
          jsonc = { "biome", "prettierd", stop_after_first = true },
          lua = { "stylua" },
          sh = { "shfmt" },
          typescript = { "biome", "prettierd", stop_after_first = true },
          typescriptreact = { "biome", "prettierd", stop_after_first = true },
          css = { "biome", "prettierd", stop_after_first = true },
          sql = { "pg_format" },
          rust = { "rustfmt", lsp_format = "fallback" },
          ["_"] = { "trim_whitespace" },
        },
        default_format_opts = {
          lsp_format = "fallback",
        },
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          return { timeout_ms = 500 }
        end,
      })

      require("mappings").formatter()
    end,
  },
  "andymass/vim-matchup",
}
