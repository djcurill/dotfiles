--[[
keymaps.lua

Global keymaps that don't belong to a plugin. Plugin keymaps live in the
plugin's spec (`keys = {}` or its `config`), which also lets lazy.nvim
load the plugin on first keypress. Press <leader>sk to search all keymaps.
]]

local map = vim.keymap.set

-- [[ Search ]] ----------------------------------------------------------------
-- Clear search highlights with <Esc> (`:help hlsearch`)
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- [[ Terminal ]] --------------------------------------------------------------
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('n', '<leader>e', ':split | term<CR>i', { desc = 'Open terminal (horizontal)' })
map('n', '<leader>ev', ':vsplit | term<CR>', { desc = 'Open terminal (vertical)' })

-- [[ Diagnostics ]] -----------------------------------------------------------
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- [[ Buffers ]] ---------------------------------------------------------------
-- Save then close; terminal buffers are force-closed (nothing to save).
map('n', '<leader>bd', function()
  if vim.bo.buftype == 'terminal' then
    vim.cmd 'bdelete!'
  else
    vim.cmd 'w | bdelete'
  end
end, { desc = 'Close buffer' })
map('n', '<Tab>', ':bnext<CR>', { desc = 'Next buffer' })

-- [[ Windows ]] ---------------------------------------------------------------
-- Focus movement (<C-h/j/k/l>) is owned by lua/plugins/nvim-tmux.lua.
-- Resize with Ctrl+Shift+hjkl (needs a terminal that sends distinct keycodes).
map('n', '<C-S-h>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-S-l>', ':vertical resize +2<CR>', { desc = 'Increase window width' })
map('n', '<C-S-k>', ':resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-S-j>', ':resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<leader>w', ':w<CR>', { desc = 'Save window' })
map('n', '<leader>x', ':q<CR>', { desc = 'Exit window' })
map('n', '<leader>X', ':qa<CR>', { desc = 'Exit all windows' })

-- [[ Toggles (<leader>t) ]] ---------------------------------------------------
-- More toggles are defined by plugins: <leader>th (LSP inlay hints, lsp.lua),
-- <leader>tb / <leader>tw (git blame / word diff, gitsigns.lua).
map('n', '<leader>td', function()
  local current = vim.diagnostic.config().virtual_text
  vim.diagnostic.config { virtual_text = not current }
end, { desc = 'Toggle diagnostic virtual text' })
