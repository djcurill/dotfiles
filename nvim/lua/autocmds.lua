--[[
autocmds.lua

Global autocommands and filetype detection that are not tied to a specific plugin.
(Plugin-specific autocmds stay in that plugin's spec under lua/plugins/.)
Reference: `:help lua-guide-autocommands`, `:help vim.filetype.add()`
]]

-- [[ Filetypes ]] -------------------------------------------------------------
-- Go HTML templates (*.gohtml) are treated as `html` so they get html indenting,
-- treesitter and the html/css language servers. Neovim does not detect .gohtml on
-- its own. Indent size comes from .editorconfig and formatting from djlint (see
-- lua/plugins/conform.lua). Other engines get their own extension and rule
-- (e.g. Jinja: *.html.j2) rather than sharing a generic *.tmpl mapping.
vim.filetype.add {
  extension = { gohtml = 'html' },
}

-- [[ Autocommands ]] ----------------------------------------------------------
-- Briefly highlight yanked text. Try it with `yap`.
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
