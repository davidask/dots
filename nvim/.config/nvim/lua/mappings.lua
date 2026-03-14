local utils = require("utils")

local map = utils.map

-- use ESC to turn off search highlighting
vim.keymap.set("n", "<leader><Esc>", "<cmd>noh<cr>", { desc = "Clear highlights" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move focus left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move focus right" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move focus up" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move focus down" })

vim.keymap.set("n", "<TAB>", "<cmd>bnext<CR>", { desc = "Cycle buffer next" })
vim.keymap.set("n", "<S-TAB>", "<cmd>bprev<CR>", { desc = "Cycle buffer prev" })

vim.keymap.set("t", "<C-\\><C-w>", "<C-\\><C-n>", { desc = "Exit terminal" })

vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save" })
vim.keymap.set("i", "<C-s>", "<cmd>w<CR><esc>", { desc = "Save" })

vim.keymap.set("n", "<leader>yfn", '<cmd>let @+ = expand("%:t")<CR><cmd>echomsg "Yanked filename."<CR>', { desc = "Yank file name" })
vim.keymap.set("n", "<leader>yfa", '<cmd>let @+ = expand("%:p")<CR><cmd>echomsg "Yanked absolute file path."<CR>', { desc = "Yank absolute file path" })
vim.keymap.set("n", "<leader>yfr", '<cmd>let @+ = expand("%")<CR><cmd>echomsg "Yanked relative file path."<CR>', { desc = "Yank relative file path" })

vim.keymap.set("n", "<leader>tdm", '<cmd>exec &bg=="light"? "set bg=dark" : "set bg=light"<CR>', { desc = "Toogle background" })

local M = {}

M.formatter = function()
  vim.keymap.set("n", "<leader>fm", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
  end, { desc = "Format buffer" })
end

M.lspconfig = function(bufnr)
  local telescope_builtins = require("telescope.builtin")

  local opt = {
    buffer = bufnr,
    noremap = true,
    silent = true,
  }

  map("n", "gd", function()
    telescope_builtins.lsp_definitions()
  end, opt)

  map("n", "gD", function()
    telescope_builtins.lsp_type_definitions()
  end, opt)

  map("n", "gi", function()
    telescope_builtins.lsp_implementations()
  end, opt)

  map("n", "gr", function()
    telescope_builtins.lsp_references()
  end, opt)

  map("n", "K", function()
    vim.lsp.buf.hover()
  end, opt)

  map("n", "<leader>ra", function()
    vim.lsp.buf.rename()
  end, opt)

  map("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, opt)

  map("n", "<leader>c", function()
    vim.diagnostic.open_float({ focusable = false })
  end, opt)

  map("n", "g]", function()
    vim.diagnostic.goto_next()
  end, opt)

  map("n", "g[", function()
    vim.diagnostic.goto_prev()
  end, opt)
end

return M
