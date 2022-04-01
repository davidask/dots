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
        respect_gitignore = false,
        file_ignore_patterns = {
          ".git/",
        },
      },
    },
    pickers = {
      lsp_code_actions = {
        theme = "cursor",
      },
      lsp_definitions = {
        hidden = true,
        -- Be explicit here, not to ignore e.g. `node_modules`
        file_ignore_patterns = {
          ".git/",
        },
      },
      lsp_type_definitions = {
        hidden = true,
        -- Be explicit here, not to ignore e.g. `node_modules`
        file_ignore_patterns = {
          ".git/",
        },
      },
      find_files = {
        hidden = true,
        previewer = false,
        shorten_path = true
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
          ["<C-k>"] = "which_key",
          ["<C-s>"] = actions.select_horizontal,
        },
        n = {
          ["<C-k>"] = "which_key",
        },
      },
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
