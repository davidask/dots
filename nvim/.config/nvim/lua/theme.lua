local M = {}
-- https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications/

function M.set_color_scheme()

  vim.cmd([[
      if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
          set background=dark
          colorscheme tokyonight-moon
      else
          set background=light
          colorscheme tokyonight-day
      endif
    ]])
end

M.set_color_scheme()

return M
