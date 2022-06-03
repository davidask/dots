local present, telescope = pcall(require, "telescope")

if not present then
  return
end

local options = {
  extensions = {
    file_browser = {
      path = "%:p:h",
      hidden = true,
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
      hidden_files = true
    },
    ["ui-select"] = {
      require("telescope.themes").get_cursor({}),
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
      hidden = true,
      shorten_path = true,
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
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
    mappings = {
      i = {
        -- ["<esc>"] = actions.close,
        ["<C-k>"] = "which_key",
        ["<C-s>"] = require("telescope.actions").select_horizontal,
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
      "--ignore-case",
      "--hidden",
      "--ignore",
      "--trim",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = {
      ".git/",
      "node_modules/",
    },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
  },
}

telescope.setup(options)

telescope.load_extension("file_browser")

-- load extensions
local extensions = { "ui-select", "file_browser", "gh", "project", "fzf" }

for _, ext in ipairs(extensions) do
  telescope.load_extension(ext)
end
