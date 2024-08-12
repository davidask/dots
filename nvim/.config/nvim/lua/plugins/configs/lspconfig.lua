local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

local M = {}

M.on_attach = function(_, bufnr)
  require("mappings").lspconfig(bufnr)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

lspconfig.lua_ls.setup({
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    M.on_attach(client, bufnr)
  end,
  capabilities = M.capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

lspconfig.tsserver.setup({
  capabilities = M.capabilities,
  root_dir = require("lspconfig.util").root_pattern("tsconfig.json"),
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    M.on_attach(client, bufnr)
  end,
})

lspconfig.sourcekit.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  filetypes = { "swift", "objective-c", "objective-cpp" },
})

lspconfig.nginx_language_server.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

lspconfig.dockerls.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

lspconfig.cssls.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

lspconfig.cssmodules_ls.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

lspconfig.bashls.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

lspconfig.clangd.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

lspconfig.gopls.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

lspconfig.cmake.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

lspconfig.pyright.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

lspconfig.eslint.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

lspconfig.biome.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

lspconfig.yamlls.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  settings = {
    yaml = {
      format = {
        enable = true,
      },
      hover = true,
      completion = true,
      customTags = {
        "!And",
        "!And sequence",
        "!If",
        "!If sequence",
        "!Condition",
        "!Condition sequence",
        "!Not",
        "!Not sequence",
        "!Equals",
        "!Equals sequence",
        "!Or",
        "!Or sequence",
        "!FindInMap",
        "!FindInMap sequence",
        "!Base64",
        "!Join",
        "!Join sequence",
        "!Cidr",
        "!Ref",
        "!Sub",
        "!Sub sequence",
        "!GetAtt",
        "!GetAZs",
        "!ImportValue",
        "!ImportValue sequence",
        "!Select",
        "!Select sequence",
        "!Split",
        "!Split sequence",
      },
    },
  },
})

local rust_tools = require("rust-tools")

rust_tools.setup({
  server = {
    on_attach = M.on_attach,
    standalone = false,
  },
})

return M
