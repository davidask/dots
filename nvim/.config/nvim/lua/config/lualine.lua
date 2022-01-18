local M = {}

function M.setup()
  require("lualine").setup({
    options = {
      theme = "auto",
    },
  })
end

return M
