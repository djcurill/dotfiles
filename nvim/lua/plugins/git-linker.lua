--[[
gitlinker
https://github.com/linrongbin16/gitlinker.nvim

Permalinks to the current line/selection on GitHub. <leader>gy yanks the
link, <leader>gY opens it in the browser.
]]
---@module 'lazy'
---@type LazySpec
return {
  'linrongbin16/gitlinker.nvim',
  cmd = 'GitLink',
  keys = {
    { '<leader>gy', '<cmd>GitLink<cr>', mode = { 'n', 'v' }, desc = 'Yank git link' },
    { '<leader>gY', '<cmd>GitLink!<cr>', mode = { 'n', 'v' }, desc = 'Open git link' },
  },
}
