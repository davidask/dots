vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

require("options")
require("plugins")


require("autocmds")
require("theme")
require("mappings")


