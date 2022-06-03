local present, lualine = pcall(require, "lualine")

if not present then
  return false
end

lualine.setup({
  options = {
    globalstatus = true,
  },
  sections = {
    lualine_c = {
      {
        "filename",
        file_status = false,
        path = 2,
      },
    },
    lualine_x = { "encoding", "filesize", "filetype", "diff" },
  },
})
