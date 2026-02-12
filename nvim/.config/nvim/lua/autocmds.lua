-- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
-- vim.cmd([[
--   augroup autoread
--     autocmd!
--     " Triger `autoread` when files changes on disk
--     " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
--     " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
--         autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
--         \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | silent! checktime | endif
--
--     " Notification after file change
--     " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
--       autocmd FileChangedShellPost *
--       \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
--   augroup end
-- ]])

-- Hide line numbers in terminal
vim.cmd([[
  augroup term
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
  augroup end
]])

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
