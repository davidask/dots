local M = {}

function M.setup()
  local key_map = vim.api.nvim_set_keymap

  key_map("", "<Space>", "<Nop>", { noremap = true, silent = true })

  key_map("n", "<C-j>", "<C-W>j", {
    noremap = true,
    silent = true,
  })
  key_map("n", "<C-k>", "<C-W>k", {
    noremap = true,
    silent = true,
  })
  key_map("n", "<C-h>", "<C-W>h", {
    noremap = true,
    silent = true,
  })
  key_map("n", "<C-l>", "<C-W>l", {
    noremap = true,
    silent = true,
  })

  key_map("t", "<C-[><C-[>", "<C-\\><C-n>", {
    noremap = true,
  })
end

return M
