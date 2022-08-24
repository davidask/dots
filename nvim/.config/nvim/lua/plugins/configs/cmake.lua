local present, cmake = pcall(require, "cmake")

if not present then
  return
end

CMakeProgress = ""

cmake.setup({
  dap_open_command = require("dapui").open,
  dap_configuration = {
    type = "lldb",
    request = "launch",
    stopOnEntry = false,
    runInTerminal = false,
  },
  quickfix = {
    pos = "botright", -- Where to open quickfix
    height = 10, -- Height of the opened quickfix.
    only_on_error = true, -- Open quickfix window only if target build failed.
  },
})
