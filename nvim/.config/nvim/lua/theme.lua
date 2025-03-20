local M = {}

local telescopeBorderless = function(flavor)
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
    latte = telescopeBorderless("latte"),
    frappe = telescopeBorderless("frappe"),
    macchiato = telescopeBorderless("macchiato"),
    mocha = telescopeBorderless("mocha"),
  },
  background = {
    light = "latte",
    dark = "mocha",
  },
})

function M.set_color_scheme()
  vim.cmd([[
      let theme = system("defaults read -g AppleInterfaceStyle")
      echom theme
      if theme =~ 'Dark'
          set background=dark
      else
          set background=light
      endif
      colorscheme catppuccin
    ]])
end

require("lualine").setup({})

M.set_color_scheme()

return M
