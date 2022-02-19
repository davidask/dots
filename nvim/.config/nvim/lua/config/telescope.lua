local M = {}

function M.setup()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local themes = require("telescope.themes")

  telescope.setup({
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "ignore_case",
      },
      ["ui-select"] = {
        themes.get_dropdown({}),
      },
      file_browser = {
        path = "%:p:h",
        hidden = true,
      },
    },
    pickers = {
      lsp_code_actions = {
        theme = "cursor",
      },
      find_files = {
        hidden = true,
        previewer = false,
      },
      buffers = {
        mappings = {
          i = {
            ["<c-d>"] = require("telescope.actions").delete_buffer,
          },
        },
      },
    },
    defaults = {
      winblend = 10,
      borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      mappings = {
        i = {
          -- ["<esc>"] = actions.close,
          ["<C-h>"] = "which_key",
          ["<C-s>"] = actions.select_horizontal,
        },
      },
      layout_config = { height = 0.75, width = 0.5 },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--ignore",
      },
      prompt_prefix = "❯ ",
      selection_caret = "❯ ",
      sorting_strategy = "ascending",
      color_devicons = true,
      file_ignore_patterns = {
        ".git/",
        "node_modules/",
      },
    },
  })

  telescope.load_extension("fzf")
  telescope.load_extension("ui-select")
  telescope.load_extension("dap")
  telescope.load_extension("gh")
end

return M
