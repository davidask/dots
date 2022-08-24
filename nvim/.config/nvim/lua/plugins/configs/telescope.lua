local present, telescope = pcall(require, "telescope")

if not present then
  return
end

local actions = require("telescope.actions")

local options = {
  extensions = {
    file_browser = {
      path = "%:p:h",
      hidden = true,
      select_buffer = true,
      respect_gitignore = false,
      file_ignore_patterns = {
        ".git/",
      },
    },
    project = {
      base_dirs = {
        {
          path = "~/Github",
          max_depth = 3,
        },
      },
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
  pickers = {
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
      shorten_path = true,
      find_command = { "fd", "--type=file", "--exclude=.git", "--strip-cwd-prefix", "--hidden" },
    },
    buffers = {
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer,
        },
        n = {
          ["d"] = actions.delete_buffer,
        },
      },
    },
  },
  defaults = {
    mappings = {
      i = {
        -- ["<esc>"] = actions.close,
        ["<C-k>"] = "which_key",
        ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-s>"] = actions.select_horizontal,
      },
      n = {
        ["<C-k>"] = "which_key",
        ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
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
      "--glob=!.git/",
    },
    prompt_prefix = "   ",
    color_devicons = true,
    selection_caret = "  ",
  },
}

telescope.setup(options)

-- load extensions
local extensions = { "file_browser", "ui-select", "file_browser", "gh", "project", "fzf" }

for _, ext in ipairs(extensions) do
  telescope.load_extension(ext)
end
