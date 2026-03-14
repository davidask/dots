local present, blink = pcall(require, "blink.cmp")

if not present then
  return
end

blink.setup({
  keymap = {
    preset = "enter",
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  },
  appearance = {
    nerd_font_variant = "mono",
    kind_icons = require("plugins.configs.lspkind_icons"),
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 150,
    },
    menu = {
      border = "rounded",
    },
    ghost_text = {
      enabled = false,
    },
  },
  signature = {
    enabled = true,
  },
  snippets = {
    preset = "luasnip",
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
})
