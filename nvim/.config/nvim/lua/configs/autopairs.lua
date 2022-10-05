local autopairs_present, autopairs = pcall(require, "nvim-autopairs")

if not autopairs_present then
  return
end

autopairs.setup({
  fast_wrap = {},
  disable_filetype = { "TelescopePrompt", "vim" },
})

local cmp_present, cmp = pcall(require, "cmp")

if cmp_present then
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end
