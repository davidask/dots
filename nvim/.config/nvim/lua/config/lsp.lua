-- Inspiration: https://github.com/elken/nvim/blob/master/lua/config/lspconfig.lua
local whichkey = require("which-key")
local M = {}

-- Borrowed from https://github.com/kabouzeid/nvim-lspinstall/wiki
-- keymaps
local on_attach = function(client, bufnr)
  -- require("lsp_signature").on_attach({
  --   bind = true,
  --   handler_opts = {
  --     border = "single",
  --   },
  -- }, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings
  local which_key_opts = { noremap = true, silent = true, buffer = bufnr }
  whichkey.register({
    K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show documentation for symbol" },
    g = {
      name = "LSP Goto",
      d = { "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", "LSP Type Definitions" },
      D = { "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>", "LSP Type Definitions" },
      i = { "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", "LSP Implementations" },
      r = { "<cmd>lua require('telescope.builtin').lsp_references<CR>", "LSP References" },
      ["["] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Jump to previous error" },
      ["]"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Jump to next error" },
    },
    ["<leader>"] = {
      c = {
        name = "Code",
        a = { "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", "LSP Code Actions" },
        w = {
          name = "Workspaces",
          a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add workspace folder" },
          r = {
            "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
            "Remove workspace folder",
          },
          l = {
            "<cmd> lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
            "List workspace folders",
          },
        },
        x = {
          "<cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>",
          "Show diagnostics for line",
        },
      },
      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "LSP Rename" },
    },
  }, which_key_opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    whichkey.register({
      ["<leader>ff"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format buffer" },
    }, which_key_opts)
  elseif client.resolved_capabilities.document_range_formatting then
    whichkey.register({
      ["<leader>ff"] = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format buffer/region" },
    }, which_key_opts)
  end
end

function M.setup()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  -- Include rtp for nvim
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  -- Register a handler that will be called for all installed servers.
  -- Alternatively, you may also register handlers on specific server instances instead (see example below).
  local lsp_installer = require("nvim-lsp-installer")
  lsp_installer.on_server_ready(function(server)
    local opts = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- (optional) Customize the options passed to the server
    if server.name == "rust_analyzer" then
      opts.standalone = false

      local dbg_path = require("dap-install.config.settings").options["installation_path"] .. "codelldb/extension/"
      local codelldb_path = dbg_path .. "adapter/codelldb"
      local liblldb_path = dbg_path .. "lldb/lib/liblldb.dylib"

      require("rust-tools").setup({
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
      })
      server:attach_buffers()
      return
    elseif server.name == "tsserver" then
      -- https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c
      local ts_utils = require("nvim-lsp-ts-utils")
      opts.on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        on_attach(client, bufnr)
        ts_utils.setup({ enable_import_on_completion = true })
        ts_utils.setup_client(client)
      end
    elseif server.name == "sumneko_lua" then
      opts.settings = {
        filetypes = { "lua" },
        Lua = {
          runtime = {
            -- LuaJIT in the case of Neovim
            version = "LuaJIT",
            path = runtime_path,
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim", "awesome", "client", "root" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
              ["/usr/share/nvim/runtime/lua"] = true,
              ["/usr/share/awesome/lib"] = true,
            },
          },
        },
      }
    elseif server.name == "yamlls" then
      opts.settings = {
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
      }
    end
    server:setup(opts)
  end)

  local null_ls = require("null-ls")

  null_ls.setup({
    on_attach = on_attach,
    sources = {
      null_ls.builtins.diagnostics.eslint.with({
        prefer_local = "node_modules/.bin",
      }),
      null_ls.builtins.diagnostics.eslint_d.with({
        only_local = "node_modules/.bin",
      }),
      null_ls.builtins.formatting.prettier.with({ prefer_local = "node_modules/.bin" }),
      null_ls.builtins.formatting.prettierd.with({ only_local = "node_modules/.bin" }),
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.formatting.sqlformat,
      null_ls.builtins.formatting.fish_indent,
    },
  })

  -- nvim_lsp.efm.setup {
  --     capabilities = capabilities,
  --     filetypes = {"yaml", "lua"},
  --     settings = {
  --       rootMarkers = {".git/"},
  --       languages = {
  --           lua = {{
  --               formatCommand = "lua-format -i",
  --               formatStdin = true
  --           }},
  --           yaml = {{
  --               lintCommand = "cfn-lint",
  --               lintStdin = true
  --           }}
  --       }
  --   }
  -- }

  -- nvim_lsp.yamlls.setup {
  --     capabilities = capabilities,
  --     settings = {
  --         yaml = {
  --             schemas = {
  --               'https://raw.githubusercontent.com/awslabs/goformation/v4.18.2/schema/cloudformation.schema.json'
  --             }
  --           }
  --     }
  -- }
end

return M
