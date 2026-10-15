--[[
lazy-setup.lua

Bootstraps lazy.nvim (the plugin manager) and loads every plugin spec.
NOTE: do not rename this to `lazy.lua` — `require('lazy')` would resolve to
this file instead of the plugin.

Commands: `:Lazy` (UI, press `?` for help), `:Lazy sync`, `:Lazy update`,
`:Lazy restore` (reset to lazy-lock.json), `:Lazy profile`.
Reference: `:help lazy.nvim.txt`, https://lazy.folke.io
]]

-- [[ Bootstrap: clone lazy.nvim on first run ]] -------------------------------
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Load plugins ]] ----------------------------------------------------------
-- `{ import = 'plugins' }` loads every lua/plugins/*.lua file; each returns one
-- spec (or a list of specs). Subdirectories (e.g. plugins/disabled/) are ignored.
require('lazy').setup({
  { import = 'plugins' },
}, {
  ui = {
    -- With a Nerd Font, use lazy's default icons; otherwise fall back to unicode.
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
