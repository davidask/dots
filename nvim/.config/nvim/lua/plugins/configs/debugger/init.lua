local function config()
  local ok, telescope = pcall(require, "telescope")
  if ok then
    telescope.load_extension("dap")
  end

  require("dapui").setup({
    mappings = { edit = "i", remove = "d" },
  })

  vim.cmd([[au FileType dap-repl setlocal wrap linebreak]])
  vim.cmd([[au FileType dap-repl lua require('dap.ext.autocompl').attach()]])

  _G.dap_close = function()
    require("dap").disconnect()
    require("dap").close()
    require("dap").repl.close()
    require("dapui").close()
  end

  local wk = require("which-key")

  wk.register({
    ["<leader>d"] = {
      name = "+debugger",
      d = { [[<cmd>lua require('dapui').toggle()<cr>]], "Open Debugger" },
      b = { [[<cmd>lua require('dap').toggle_breakpoint()<cr>]], "Toggle Breakpoints" },
      e = {
        [[<cmd>lua require('dap').set_exception_breakpoints({"all"})<cr>]],
        "Set Exception Breakpoints (All)",
      },
      n = { [[<cmd>lua require('dap').continue()<cr>]], "Start/Continue Debugger" },
      N = { [[<cmd>lua require('dap').run_last()<cr>]], "Run Last Debugger" },
      h = { [[<cmd>lua require('dap').step_out()<cr>]], "Step Out" },
      l = { [[<cmd>lua require('dap').step_over()<cr>]], "Step Over" },
      j = { [[<cmd>lua require('dap').step_into()<cr>]], "Step Into" },
      r = { [[<cmd>lua require('dap').repl.open({}, 'vsplit')<cr>]], "Open Repl" },
      K = { [[<cmd>silent! lua require('dap.ui.widgets').hover()<cr>]], "Debug Hover (Native)" },
      s = { [[<cmd>lua require('dap.ui.variables').scopes()<cr>]], "Scope" },
      S = { [[<cmd>lua _G.dap_close()<cr>]], "Stop Debugger" },
      B = { [[<cmd>lua require('telescope').extensions.dap.list_breakpoints({})<cr>]], "List Breakpoints" },
      x = { [[<cmd>lua require('telescope').extensions.dap.commands({})<cr>]], "List Commands" },
      v = { [[<cmd>lua require('telescope').extensions.dap.variables({})<cr>]], "List Variables" },
      f = { [[<cmd>lua require('telescope').extensions.dap.frames({})<cr>]], "List Frames" },
      m = { [[<cmd>lua require('telescope').extensions.dap.configurations({})<cr>]], "List Configurations" },
    },
  })

  require("plugins.configs.debugger.lldb")

  _G.load_launchjs = function()
    local root = vim.fn.finddir(".git/..", ";")

    require("dap.ext.vscode").load_launchjs(root .. "/.vim/launch.json")
    require("dap.ext.vscode").load_launchjs(root .. "/.vscode/launch.json")
  end

  vim.cmd([[
		augroup dap_load_vscode
			au!
			au DirChanged * silent! lua _G.load_launchjs()
		augroup end
	]])

  -- broken format due to emoji. have to be ignored.
  --
  vim.fn.sign_define("DapBreakpoint", { text = "⭕️", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "⛔️", texthl = "", linehl = "", numhl = "" })

  require("nvim-dap-virtual-text").setup({
    all_frames = true,
  })

  require("dap").listeners.after.event_initialized["dapui_config"] = function()
    require("dapui").open()
  end
end

return function(use)
  use({
    "tigorlazuardi/nvim-dap-ui",
    requires = {
      { "mfussenegger/nvim-dap" },
      { "theHamsta/nvim-dap-virtual-text" },
      { "nvim-telescope/telescope-dap.nvim" },
      { "jbyuki/one-small-step-for-vimkind" },
    },
    config = config,
  })
end
