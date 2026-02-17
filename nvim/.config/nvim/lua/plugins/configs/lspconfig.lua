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

local function no_format_on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  M.on_attach(client, bufnr)
end

local shared = {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

vim.lsp.config("lua_ls", {
  on_attach = no_format_on_attach,
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

vim.lsp.config("ts_ls", {
  capabilities = M.capabilities,
  root_markers = { "tsconfig.json" },
  on_attach = no_format_on_attach,
})

vim.lsp.config("sourcekit", {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  filetypes = { "swift", "objective-c", "objective-cpp" },
})

vim.lsp.config("nginx_language_server", shared)
vim.lsp.config("dockerls", shared)
vim.lsp.config("cssls", shared)
vim.lsp.config("cssmodules_ls", shared)
vim.lsp.config("bashls", shared)
vim.lsp.config("clangd", shared)
vim.lsp.config("gopls", shared)
vim.lsp.config("cmake", shared)
vim.lsp.config("pyright", shared)
vim.lsp.config("eslint", shared)
vim.lsp.config("biome", shared)

vim.lsp.config("yamlls", {
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

for _, server in ipairs({
  "lua_ls",
  "ts_ls",
  "sourcekit",
  "nginx_language_server",
  "dockerls",
  "cssls",
  "cssmodules_ls",
  "bashls",
  "clangd",
  "gopls",
  "cmake",
  "pyright",
  "eslint",
  "biome",
  "yamlls",
}) do
  vim.lsp.enable(server)
end

local rust_tools = require("rust-tools")

rust_tools.setup({
  server = {
    on_attach = M.on_attach,
    standalone = false,
  },
})

return M
