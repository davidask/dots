local present, dap = pcall(require, "dap")

if not present then
  return
end

dap.adapters.lldb = {
  type = "executable",
  command = "lldb-vscode",
  name = "lldb",
}

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
