local M = {}
-- https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications/

function M.setup()
  function M.set_color_scheme()
    require("rose-pine").setup({
      dark_variant = "moon",
    })
    vim.cmd([[
        if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
            set background=dark
        else
            set background=light
        endif
        colorscheme rose-pine
    ]])
  end

  M.set_color_scheme()
end

return M
