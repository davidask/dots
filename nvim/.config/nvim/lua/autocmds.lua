local autocmd = vim.api.nvim_create_autocmd

-- Open a file from its last left off position
autocmd("BufReadPost", {
  callback = function()
    if not vim.fn.expand("%:p"):match(".git") and vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g'\"")
      vim.cmd("normal zz")
    end
  end,
})

-- Highlight yanked text
-- autocmd("TextYankPost", {
--   callback = function()
--     vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
--   end,
-- })

-- Enable spellchecking in markdown, text and gitcommit files
autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
vim.cmd([[
  augroup autoread
    autocmd!
    " Triger `autoread` when files changes on disk
    " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
    " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
        autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
        \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | silent! checktime | endif

    " Notification after file change
    " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
      autocmd FileChangedShellPost *
      \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
  augroup end
]])

-- Hide line numbers in terminal
vim.cmd([[
  augroup term
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
  augroup end
]])

-- vim.cmd([[
--   augroup matchup_matchparen_highlight
--     autocmd!
--     autocmd ColorScheme * hi MatchParen cterm=underline gui=underline
--   augroup end
-- ]])

-- vim.cmd([[
--   autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
-- ]])
