local M = {}

function M.setup()
  require("lspkind").init()
  local cmp = require("cmp")
  -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
  cmp.setup({
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "luasnip" },
    }, {
      { name = "buffer" },
    }),
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<C-k>"] = cmp.mapping({
        i = function()
          if cmp.visible() then
            cmp.abort()
          else
            cmp.complete()
          end
        end,
        c = function()
          if cmp.visible() then
            cmp.close()
          else
            cmp.complete()
          end
        end,
      }),
    },
    formatting = {
      format = require("lspkind").cmp_format({
        with_text = true,
        maxwidth = 150,
        menu = {
          path = "[Path]",
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[Snippet]",
        },
      }),
    },
    documentation = {
      border = "single",
    },
  })
end

return M
