local M = {}

M.on_attach = function(_, bufnr)
  require("mappings").lspconfig(bufnr)
end

M.capabilities = require("blink.cmp").get_lsp_capabilities()

local function no_format_on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  M.on_attach(client, bufnr)
end

local shared = {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

local js_root_markers = {
  "package.json",
  "tsconfig.json",
  "jsconfig.json",
  ".git",
}

local biome_root_markers = {
  "biome.json",
  "biome.jsonc",
  ".biome.json",
  ".biome.jsonc",
}

local eslint_root_markers = {
  "eslint.config.js",
  "eslint.config.cjs",
  "eslint.config.mjs",
  "eslint.config.ts",
  "eslint.config.cts",
  "eslint.config.mts",
  ".eslintrc",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.json",
  ".eslintrc.yaml",
  ".eslintrc.yml",
}

local function root_dir(bufnr, markers)
  return vim.fs.root(bufnr, markers)
end

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
  on_attach = no_format_on_attach,
  root_dir = function(bufnr, on_dir)
    on_dir(root_dir(bufnr, js_root_markers))
  end,
})

vim.lsp.config("sourcekit", {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  filetypes = { "swift", "objective-c", "objective-cpp" },
})

vim.lsp.config("rust_analyzer", {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
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
vim.lsp.config("eslint", vim.tbl_extend("force", shared, {
  root_dir = function(bufnr, on_dir)
    on_dir(root_dir(bufnr, eslint_root_markers))
  end,
}))

vim.lsp.config("biome", vim.tbl_extend("force", shared, {
  root_dir = function(bufnr, on_dir)
    on_dir(root_dir(bufnr, biome_root_markers))
  end,
}))

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
  "rust_analyzer",
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

return M
