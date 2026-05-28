local map = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('n', '<leader>e', ':split | term<CR>i', { desc = 'Open terminal (horizontal)' })
map('n', '<leader>ev', ':vsplit | term<CR>', { desc = 'Open terminal (vertical)' })

-- open diagnostics
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- buffers
map('n', '<leader>bd', function()
  if vim.bo.buftype == 'terminal' then
    vim.cmd 'bdelete!'
  else
    vim.cmd 'w | bdelete'
  end
end, { desc = 'Close buffer' })
map('n', '<Tab>', ':bnext<CR>', { desc = 'Next buffer' })

-- windows
-- map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
map('n', '<C-S-h>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-S-l>', ':vertical resize +2<CR>', { desc = 'Increase window width' })
map('n', '<C-S-k>', ':resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-S-j>', ':resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<leader>w', ':w<CR>', { desc = 'Save window' })
map('n', '<leader>x', ':q<CR>', { desc = 'Exit window' })
map('n', '<leader>X', ':qa<CR>', { desc = 'Exit all windows' })

-- toggles
-- enable / disable diagnostics
vim.keymap.set('n', '<leader>td', function()
  local current = vim.diagnostic.config().virtual_text
  vim.diagnostic.config { virtual_text = not current }
end, { desc = 'Toggle diagnostic virtual text' })
