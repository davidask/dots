vim.api.nvim_create_user_command("ToggleVimDarkMode", function()
  vim.cmd("exec &bg=='light'? 'set bg=dark' : 'set bg=light'")
end, {})

vim.api.nvim_create_user_command("ToggleOSDarkMode", function()
  vim.cmd("!tdm")
end, {})

vim.api.nvim_create_user_command("ToggleDarkMode", function()
  vim.cmd("ToggleVimDarkMode")
  vim.cmd("ToggleOSDarkMode")
end, {})
