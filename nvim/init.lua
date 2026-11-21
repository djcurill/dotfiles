--[[
init.lua

Entry point. Keep this file to require() calls only; each module documents
itself. Order matters: `options` sets the leader key and must run before
plugins load.

  options      vim.g / vim.o / vim.opt settings (leader key, UI, search...)
  keymaps      global keymaps (plugin keymaps live in lua/plugins/)
  autocmds     global autocommands
  diagnostics  how LSP/linter diagnostics are displayed
  lazy-setup   bootstraps lazy.nvim and loads every spec in lua/plugins/

See README.md for how to add plugins, troubleshoot, and run health checks.
]]

vim.loader.enable() -- cache compiled Lua for faster startup

require 'options'
require 'keymaps'
require 'autocmds'
require 'diagnostics'
require 'theme-sync'
require 'lazy-setup'
