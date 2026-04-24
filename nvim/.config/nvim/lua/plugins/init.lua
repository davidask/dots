local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local spec_modules = {
  "plugins.specs.core",
  "plugins.specs.ui",
  "plugins.specs.editor",
  "plugins.specs.lsp",
  "plugins.specs.testing",
}

local specs = {}

for _, module in ipairs(spec_modules) do
  vim.list_extend(specs, require(module))
end

require("lazy").setup(specs)

require("plugins.configs.treesitter")
require("todo-comments").setup()
require("nvim_comment").setup()
require("plugins.configs.blink")

require("plugins.configs.mason")
require("plugins.configs.mason-lspconfig")
require("plugins.configs.lspconfig")
require("plugins.configs.telescope")
require("luatab").setup({})
