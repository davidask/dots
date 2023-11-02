local M = {}

local telescopeBorderless = function(flavor)
  local cp = require("catppuccin.palettes").get_palette(flavor)

  return {
    TelescopeBorder = { fg = cp.surface2, bg = cp.base },
    TelescopeSelectionCaret = { fg = cp.mauve, bg = cp.crust },
    TelescopeMatching = { fg = cp.mauve },
    TelescopeNormal = { bg = cp.base },
    TelescopeSelection = { fg = cp.text, bg = cp.crust },
    TelescopeMultiSelection = { fg = cp.text, bg = cp.crust },
    TelescopeTitle = { fg = cp.mauve, bg = cp.base },
    TelescopePreviewTitle = { fg = cp.mauve, bg = cp.base },
    TelescopePromptTitle = { fg = cp.mauve, bg = cp.crust },
    TelescopePromptPrefix = { fg = cp.mauve, bg = cp.crust },
    TelescopePromptNormal = { fg = cp.mauve, bg = cp.crust },
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
