local utils = require("core.utils")

local map = utils.map
local user_cmd = vim.api.nvim_create_user_command

vim.g.mapleader = " "

-- This is a wrapper function made to disable a plugin mapping from chadrc
-- If keys are nil, false or empty string, then the mapping will be not applied
-- Useful when one wants to use that keymap for any other purpose

-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
map("v", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true })

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http<cmd> ://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour

map({ "n", "x", "o" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map({ "n", "x", "o" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
map("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

-- use ESC to turn off search highlighting
map("n", "<Esc>", "<cmd> :noh <CR>")

-- Escape terminal with "w"
map("t", "<C-\\><C-w>", "<C-\\><C-n>")

-- move cursor within insert mode
map("i", "<C-h>", "<Left>")
map("i", "<C-e>", "<End>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-a>", "<ESC>^i")

-- navigation between windows
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")

map("n", "<leader>x", function()
  require("core.utils").close_buffer()
end)

map("n", "<C-c>", "<cmd> :%y+ <CR>") -- copy whole file content
map("n", "<S-t>", "<cmd> :enew <CR>") -- new buffer
map("n", "<C-t>b", "<cmd> :tabnew <CR>") -- new tabs
map("n", "<leader>n", "<cmd> :set nu! <CR>")
map("n", "<leader>rn", "<cmd> :set rnu! <CR>") -- relative line numbers
map("n", "<C-s>", "<cmd> :w <CR>") -- ctrl + s to save file


map("n", "Q", "<nop>")

-- Add Packer commands because we are not loading it at startup

local packer_cmd = function(callback)
  return function()
    require("plugins")
    require("packer")[callback]()
  end
end

user_cmd("PackerClean", packer_cmd("clean"), {})
user_cmd("PackerCompile", packer_cmd("compile"), {})
user_cmd("PackerInstall", packer_cmd("install"), {})
user_cmd("PackerStatus", packer_cmd("status"), {})
user_cmd("PackerSync", packer_cmd("sync"), {})
user_cmd("PackerUpdate", packer_cmd("update"), {})

local M = {}

M.lspconfig = function()
  local telescope_builtins = require("telescope.builtin")

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  map("n", "gd", function()
    telescope_builtins.lsp_definitions()
  end)

  map("n", "gD", function()
    telescope_builtins.lsp_type_definitions()
  end)

  map("n", "gi", function()
    telescope_builtins.lsp_implementations()
  end)

  map("n", "gr", function()
    telescope_builtins.lsp_references()
  end)

  map("n", "K", function()
    vim.lsp.buf.hover()
  end)

  map("n", "<leader>k", function()
    vim.lsp.buf.signature_help()
  end)

  map("n", "<leader>ra", function()
    vim.lsp.buf.rename()
  end)

  map("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end)

  map("n", "<leader>c", function()
    vim.diagnostic.open_float({ focusable = false })
  end)

  map("n", "g]", function()
    vim.diagnostic.goto_next()
  end)

  map("n", "g[", function()
    vim.diagnostic.goto_prev()
  end)

  map("n", "<leader>gq", function()
    vim.diagnostic.setloclist()
  end)

  map("n", "<leader>fm", function()
    vim.lsp.buf.formatting()
  end)

  map("n", "<leader>wa", function()
    vim.lsp.buf.add_workspace_folder()
  end)

  map("n", "<leader>wr", function()
    vim.lsp.buf.remove_workspace_folder()
  end)

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end)
end

M.telescope = function()
  map("n", "<leader>,", "<cmd> :Telescope find_files <CR>")
  map("n", "<leader>.", "<cmd> :Telescope file_browser <CR>")
  map("n", "<leader>/", "<cmd> :Telescope live_grep <CR>")
  map("n", "<leader>;", "<cmd> :Telescope buffers <CR>")
  map("n", "<leader>'", "<cmd> :Telescope oldfiles <CR>")
  map("n", "<leader>p", "<cmd> :Telescope project <CR>")

  map("n", "<leader>GC", "<cmd> :Telescope git_commits <CR>")
  map("n", "<leader>GCB", "<cmd> :Telescope git_bcommits <CR>")
  map("n", "<leader>GS", "<cmd> :Telescope git_status <CR>")
  map("n", "<leader>GB", "<cmd> :Telescope git_branches <CR>")

  map("n", "<leader>fh", "<cmd> :Telescope help_tags <CR>")
  map("n", "<leader>tk", "<cmd> :Telescope keymaps <CR>")
end

M.fugitive = function()
  map("n", "<leader>G", "<cmd> :tab G <CR>")
  map("n", "<leader>GP", "<cmd> :G push <CR>")
end

return M
