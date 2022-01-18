local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    highlight = {
      enable = true,
    },
  })

  local parsers = require("nvim-treesitter.parsers")
  function _G.ensure_treesitter_language_installed()
    local lang = parsers.get_buf_lang()
    if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
      vim.schedule_wrap(function()
        vim.cmd("TSInstall " .. lang)
      end)()
    end
  end

  vim.cmd([[autocmd FileType * :lua ensure_treesitter_language_installed()]])
end

return M
