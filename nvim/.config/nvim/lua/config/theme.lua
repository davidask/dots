local M = {}
-- https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications/

function M.setup()
  vim.o.termguicolors = true

  function M.set_color_scheme()
    vim.cmd([[
        if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
            set background=dark
        else
            set background=light
        endif
        colorscheme tokyonight
    ]])
  end

  M.set_color_scheme()
  require("lualine").setup()
end

return M
