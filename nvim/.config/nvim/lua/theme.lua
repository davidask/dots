local M = {}

local telescope_borderless = function(flavor)
  local cp = require("catppuccin.palettes").get_palette(flavor)

  return {
    TelescopeBorder = { fg = cp.mantle, bg = cp.mantle },
    TelescopeSelectionCaret = { fg = cp.lavender, bg = cp.crust },
    TelescopeMatching = { fg = cp.lavender },
    TelescopeNormal = { bg = cp.mantle },
    TelescopeSelection = { fg = cp.text, bg = cp.crust },
    TelescopeMultiSelection = { fg = cp.text, bg = cp.crust },
    TelescopeTitle = { fg = cp.lavender, bg = cp.mantle },
    TelescopePreviewTitle = { fg = cp.lavender, bg = cp.base },
    TelescopePromptTitle = { fg = cp.lavender, bg = cp.crust },
    TelescopePromptPrefix = { fg = cp.lavender, bg = cp.crust },
    TelescopePromptNormal = { fg = cp.lavender, bg = cp.crust },
    TelescopePromptBorder = { fg = cp.crust, bg = cp.crust },
  }
end

require("catppuccin").setup({
  highlight_overrides = {
    latte = telescope_borderless("latte"),
    frappe = telescope_borderless("frappe"),
    macchiato = telescope_borderless("macchiato"),
    mocha = telescope_borderless("mocha"),
  },
  background = {
    light = "latte",
    dark = "macchiato",
  },
})

function M.set_color_scheme()
  local background = "light"

  if vim.fn.executable("defaults") == 1 then
    local result = vim.system({ "defaults", "read", "-g", "AppleInterfaceStyle" }, { text = true }):wait()
    if result.code == 0 and result.stdout:match("Dark") then
      background = "dark"
    end
  end

  vim.o.background = background
  vim.cmd.colorscheme("catppuccin")
end

require("lualine").setup({})

M.set_color_scheme()

return M
