local present, mason_lspconfig = pcall(require, "mason-lspconfig")

if not present then
  return
end

mason_lspconfig.setup({
  -- ensure_installed = {
  --   "lua-language-server",
  --   "typescript-language-server",
  --   "eslint-lsp",
  --   "clangd",
  --   "cfn-lint",
  -- },
})
