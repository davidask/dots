local M = {}

function M.setup()
  local dap = require("dap")
  local dap_install = require("dap-install")
  local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()
  for _, debugger in ipairs(dbg_list) do
    dap_install.config(debugger)
  end

  local dapui = require("dapui")

  dapui.setup({
    sidebar = {
      size = 45,
    },
    mappings = {
      expand = { "<CR>", "<space>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
    },
  })

  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
    },
  }

  dap.adapters.nlua = function(callback, config)
    callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8088 })
  end

  require("nvim-dap-virtual-text").setup()

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
  -- vim.cmd([[
  --     nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
  --     nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
  --     nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
  --     nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
  --     nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
  --     nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
  --     nnoremap <silent> <leader>dl :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
  -- ]])
end

return M
