--[[
options.lua

Core editor settings (vim.g / vim.o / vim.opt). No plugin config lives here.
Loaded FIRST from init.lua: the leader key must be set before lazy.nvim
loads plugins, otherwise their keymaps bind to the wrong leader.

Reference: `:help option-list`, `:help lua-options`
]]

-- [[ Leader keys ]] -----------------------------------------------------------
-- `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Globals read by plugin specs ]] ------------------------------------------
-- Set to false if your terminal font is not a Nerd Font (plugins swap icons).
vim.g.have_nerd_font = true

-- [[ LSP ]] -------------------------------------------------------------------
-- Only log warnings and errors (see README for how to open the log). Use 'DEBUG' when troubleshooting.
-- (`vim.lsp.log.set_log_level` no longer exists on Neovim 0.12; it is `set_level`.)
vim.lsp.log.set_level 'WARN'

-- [[ UI ]] --------------------------------------------------------------------
vim.o.number = true -- line numbers
-- vim.o.relativenumber = true -- uncomment for relative line numbers
vim.o.mouse = 'a' -- mouse in all modes (handy for resizing splits)
vim.o.showmode = false -- mode is shown in the statusline instead
vim.o.signcolumn = 'yes' -- always show the sign column (avoids text shifting)
vim.o.cursorline = true -- highlight the cursor line
vim.o.scrolloff = 10 -- keep 10 lines visible above/below the cursor
vim.o.breakindent = true -- wrapped lines keep their indent
vim.o.list = true -- show whitespace characters...
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- ...as these symbols
vim.o.inccommand = 'split' -- live preview of :substitute in a split

-- [[ Splits ]] ----------------------------------------------------------------
vim.o.splitright = true
vim.o.splitbelow = true

-- [[ Search ]] ----------------------------------------------------------------
-- Case-insensitive unless the pattern contains a capital letter (or \C).
vim.o.ignorecase = true
vim.o.smartcase = true

-- [[ Behavior ]] --------------------------------------------------------------
vim.o.undofile = true -- persist undo history across sessions
vim.o.confirm = true -- prompt to save instead of failing on :q with unsaved changes
vim.o.updatetime = 250 -- faster CursorHold / swap writes (ms)
vim.o.timeoutlen = 300 -- how long to wait for a mapped key sequence (ms)

-- [[ Filetypes ]] --------------------------------------------------------------
vim.filetype.add {
  pattern = { ['.*/assets/html/.*%.tmpl'] = 'html' },
}

-- Sync clipboard with the OS. Scheduled because it can slow startup.
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
