local telescope = require("telescope")
local actions = require("telescope.actions")
local filebrowser_actions = require("telescope").extensions.file_browser.actions

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
      mappings = {
        ["i"] = {
          ["<C-h>"] = filebrowser_actions.goto_cwd,
          ["<C-u>"] = filebrowser_actions.goto_parent_dir,
        },
      },
    },
    project = {
      base_dirs = {
        {
          path = "~/Github",
          max_depth = 3,
        },
        {
          path = "~/Bitbucket",
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
    prompt_prefix = "  ",
    color_devicons = true,
    selection_caret = " ",
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
  },
}

telescope.setup(options)

-- load extensions
local extensions = { "file_browser", "ui-select", "project", "fzf" }

for _, ext in ipairs(extensions) do
  telescope.load_extension(ext)
end

vim.keymap.set("n", "<c-t>", "<cmd>Telescope project<cr>", { desc = "Live Grep" })
vim.keymap.set("n", "<c-b>", "<cmd>Telescope buffers<cr>", { desc = "Buffer Picker" })
vim.keymap.set("n", "<c-f>", "<cmd>Telescope live_grep<cr>", { desc = "File Picker" })
vim.keymap.set("n", "<c-p>", "<cmd>Telescope find_files<cr>", { desc = "Project picker" })
vim.keymap.set("n", "<c-e>", "<cmd>Telescope file_browser<cr>", { desc = "File browser" })
