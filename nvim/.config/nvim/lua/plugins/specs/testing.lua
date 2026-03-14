return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-go",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local neotest = require("neotest")

      neotest.setup({
        adapters = {
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
            args = { "-count=1" },
          }),
        },
      })

      vim.keymap.set("n", "<leader>tn", function()
        neotest.run.run()
      end, { desc = "Run nearest test" })
      vim.keymap.set("n", "<leader>tf", function()
        neotest.run.run(vim.fn.expand("%"))
      end, { desc = "Run file tests" })
      vim.keymap.set("n", "<leader>ts", function()
        neotest.summary.toggle()
      end, { desc = "Toggle test summary" })
      vim.keymap.set("n", "<leader>to", function()
        neotest.output_panel.toggle()
      end, { desc = "Toggle test output" })
    end,
  },
}
