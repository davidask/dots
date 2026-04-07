local M = {}

function M.set_color_scheme()
  local background = "light"

  if vim.fn.executable("defaults") == 1 then
    local result = vim.system({ "defaults", "read", "-g", "AppleInterfaceStyle" }, { text = true }):wait()
    if result.code == 0 and result.stdout:match("Dark") then
      background = "dark"
    end
  end

  vim.o.background = background
  
  require("catppuccin").setup({
    background = {
      light = "latte",
      dark = "mocha",
    },
  })
  
  vim.cmd.colorscheme("catppuccin")
end

require("lualine").setup({})

M.set_color_scheme()

return M