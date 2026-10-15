--[[
autocmds.lua

Global autocommands that are not tied to a specific plugin.
(Plugin-specific autocmds stay in that plugin's spec under lua/plugins/.)
Reference: `:help lua-guide-autocommands`
]]

-- Briefly highlight yanked text. Try it with `yap`.
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
