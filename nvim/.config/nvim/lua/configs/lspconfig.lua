local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

local M = {}

-- local function lspSymbol(name, icon)
--   local hl = "DiagnosticSign" .. name
--   vim.fn.sign_define(hl, {
--     text = icon,
--     numhl = hl,
--     texthl = hl,
--   })
-- end

-- lspSymbol("Error", "")
-- lspSymbol("Info", "")
-- lspSymbol("Hint", "")
-- lspSymbol("Warn", "")

-- vim.diagnostic.config({
--   virtual_text = {
--     prefix = "",
--   },
--   signs = true,
--   underline = true,
--   update_in_insert = false,
-- })

-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--   border = "single",
-- })
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
--   border = "single",
-- })

function M.on_attach(_, bufnr)
  require("mappings").lspconfig(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = {
  valueSet = { 1 },
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

lspconfig.sumneko_lua.setup({
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    M.on_attach(client, bufnr)
  end,
  capabilities = capabilities,

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
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    M.on_attach(client, bufnr)
  end,
})

-- lspconfig.sourcekit.setup({
--   on_attach = M.on_attach,
--   capabilities = capabilities,
-- })
--
lspconfig.dockerls.setup({
  on_attach = M.on_attach,
  capabilities = capabilities,
})

lspconfig.bashls.setup({
  on_attach = M.on_attach,
  capabilities = capabilities,
})

lspconfig.clangd.setup({
  on_attach = M.on_attach,
  capabilities = capabilities,
})

lspconfig.cmake.setup({
  on_attach = M.on_attach,
  capabilities = capabilities,
})

lspconfig.ltex.setup({ filetypes = { "bib", "markdown", "org", "plaintex", "rst", "rnoweb", "tex" } })

lspconfig.eslint.setup({})

lspconfig.yamlls.setup({
  on_attach = M.on_attach,
  capabilities = capabilities,
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

local null_ls = require("null-ls")

null_ls.setup({
  on_attach = M.on_attach,
  sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.sqlformat,

    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.diagnostics.cfn_lint,
  },
})

vim.api.nvim_create_user_command("NullLsToggle", function()
  null_ls.toggle({})
end, {})

local rust_tools = require("rust-tools")

rust_tools.setup({
  server = {
    on_attach = M.on_attach,
    standalone = false,
  },
})

return M
