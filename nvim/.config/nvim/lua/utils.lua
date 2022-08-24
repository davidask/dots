local M = {}

local fn = vim.fn

-- Finding os name and packer instalation path.
M.plugins_path = fn.stdpath("data") .. "/site/pack/packer"
M.os = vim.loop.os_uname().sysname

-- Check for instalation status of plugin.
function M.is_plugin_installed(plugins_name)
  if
    fn.empty(fn.glob(M.plugins_path .. "/start/" .. plugins_name)) > 0
    and fn.empty(fn.glob(M.plugins_path .. "/opt/" .. plugins_name)) > 0
  then
    return false
  else
    return true
  end
end

M.map = function(mode, keys, command, opt)
  local options = { silent = true }

  if opt then
     options = vim.tbl_extend("force", options, opt)
  end

  if type(keys) == "table" then
     for _, keymap in ipairs(keys) do
        M.map(mode, keymap, command, opt)
     end
     return
  end

  vim.keymap.set(mode, keys, command, opt)
end

return M
