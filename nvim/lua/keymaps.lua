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
-- The window stays open and shows the next source buffer. Plain `:bdelete`
-- closes the window, which leaves only the neo-tree sidebar.
local function next_source_buffer(current)
  local bufs = vim.tbl_filter(function(b)
    return b.listed == 1 and b.bufnr ~= current and vim.bo[b.bufnr].buftype == '' and vim.bo[b.bufnr].filetype ~= 'neo-tree'
  end, vim.fn.getbufinfo { buflisted = 1 })
  -- Prefer the first buffer after the current one, else wrap to the first.
  for _, b in ipairs(bufs) do
    if b.bufnr > current then return b.bufnr end
  end
  return bufs[1] and bufs[1].bufnr
end

map('n', '<leader>bd', function()
  local current = vim.api.nvim_get_current_buf()
  local is_term = vim.bo[current].buftype == 'terminal'
  -- Unnamed buffers can't be written (E32). Skip the save for them.
  if not is_term and vim.api.nvim_buf_get_name(current) ~= '' then vim.cmd 'w' end

  local target = next_source_buffer(current)
  if target then
    vim.api.nvim_win_set_buf(0, target)
  else
    vim.cmd 'enew'
  end
  if vim.api.nvim_buf_is_valid(current) then
    vim.cmd((is_term and 'bdelete! ' or 'bdelete ') .. current)
  end
end, { desc = 'Close buffer' })
-- <Tab> / <S-Tab> buffer cycling is owned by lua/plugins/bufferline.lua.

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

-- [[ LSP ]] -------------------------------------------------------------------
map('n', '<leader>i', function()
  vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' }, diagnostics = {} }, apply = true }
end, { desc = 'Organize [I]mports' })

-- [[ Toggles (<leader>t) ]] ---------------------------------------------------
-- More toggles are defined by plugins: <leader>th (LSP inlay hints, lsp.lua),
-- <leader>tb / <leader>tw (git blame / word diff, gitsigns.lua).
map('n', '<leader>td', function()
  local current = vim.diagnostic.config().virtual_text
  vim.diagnostic.config { virtual_text = not current }
end, { desc = 'Toggle diagnostic virtual text' })
