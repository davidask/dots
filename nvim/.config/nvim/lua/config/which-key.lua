local M = {}

function M.setup()
  local whichkey = require("which-key")
  whichkey.setup({
    plugins = {
      spelling = {
        enabled = true,
      },
    },
  })

  local normal_binds = {
    b = {
      name = "Buffer",
      d = { "<cmd>bdelete<CR>", "Kill buffer" },
      p = { "<cmd>bp<CR>", "Previous buffer" },
      n = { "<cmd>bn<CR>", "Next buffer" },
    },
    d = {
      b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint" },
      B = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "Toggle breakpoint with condition" },
      l = { "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", "Log breakpoint" },
      ui = { "<cmd>lua require'dapui'.toggle()<CR>", "Toggle DAP UI" },
    },
    f = {
      name = "File",
      y = { "<cmd>let @+ = expand('%:p')<CR>", "Yank file path" },
      Y = { "<cmd>let @+ = expand('%:~:.')<CR>", "Yank file path from project" },
    },
    h = {
      name = "Hunk",
      b = { "<cmd>Gitsigns blame_line<CR>", "Blame line" },
      n = { "<cmd>Gitsigns next_hunk<CR>", "Next hunk" },
      p = { "<cmd>Gitsigns prev_hunk<CR>", "Previous hunk" },
      P = { "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk" },
      s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage current hunk" },
      S = { "<cmd>Gitsigns stage_buffer<CR>", "Stage current buffer" },
      r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset current hunk" },
      R = { "<cmd>Gitsigns reset_buffer<CR>", "Reset current buffer" },
      u = { "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk" },
      U = { "<cmd>Gitsigns reset_buffer_index<CR>", "Reset buffer index" },
    },
    o = {
      name = "Open",
      gh = { "<cmd>!gh pr view --web || gh repo view --web<CR><CR>", "GitHub open" },
    },
    g = {
      b = {
        "<cmd>lua require('telescope.builtin').git_branches()<CR>",
        "Git branches",
      },
      s = {
        "<cmd>lua require('telescope.builtin').git_status()<CR>",
        "Git status",
      },
      c = {
        "<cmd>lua require('telescope.builtin').git_commits()<CR>",
        "Git commits",
      },
    },
    ["<space>"] = { "<cmd>nohl<CR>", "Turn off search highlight" },
  }

  local visual_binds = {
    g = {
      y = {
        "<cmd>lua require('gitlinker').get_buf_range_url('v')<CR>",
        "Yank link to current selection",
      },
    },
  }

  local direct_binds = {
    ["<F5>"] = { "<cmd>lua require'dap'.continue()<CR>", "DAP Continue" },
    ["<F10>"] = { "<cmd>lua require'dap'.step_over()<CR>", "DAP Step over" },
    ["<F11>"] = { "<cmd>lua require'dap'.step_into()<CR>", "DAP Step into" },
    ["<F12>"] = { "<cmd>lua require'dap'.step_out()<CR>", "DAP Step out" },
    ["<C-g>"] = { "<cmd>Telescope live_grep<CR>", "Search in project" },
    ["<C-f>"] = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", "Search in file" },
    ["<C-p>"] = {
      "<cmd>lua require('telescope.builtin').find_files()<CR>",
      "Find file in project",
    },
    ["<C-e>"] = { "<cmd>lua require('telescope').extensions.file_browser.file_browser()<CR>", "Find file" },
    ["<C-b>"] = { "<cmd>Telescope buffers<CR>", "Switch buffer" },
  }

  whichkey.register(normal_binds, { prefix = "<leader>", mode = "n", silent = true })
  whichkey.register(visual_binds, { prefix = "<leader>", mode = "v", silent = true })
  whichkey.register(direct_binds)
end

return M
