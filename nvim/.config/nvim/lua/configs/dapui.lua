local present, dapui = pcall(require, "dapui")

if not present then
  return
end

dapui.setup({
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 60,
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      position = "bottom",
      size = 20,
    },
  },
})
