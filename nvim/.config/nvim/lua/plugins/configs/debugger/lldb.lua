local dap = require("dap")

dap.adapters.lldb = function(cb, config)
  if config.preLaunchCmd then
    vim.fn.system(config.preLaunchCmd)
  end
  local adapter = {
    type = "executable",
    command = "lldb-vscode",
    name = "lldb",
  }
  cb(adapter)
end

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
