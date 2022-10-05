local M = {}
-- https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications/

function M.set_color_scheme()
  require("rose-pine").setup({
    -- dark_variant = "moon",
  })

  vim.cmd([[

      " Everforest specific
      let g:everforest_background = 'hard'

      if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
          set background=dark
      else
          set background=light
      endif
      colorscheme rose-pine
    ]])
end

M.set_color_scheme()

return M
