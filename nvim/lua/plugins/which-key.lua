--[[
which-key
https://github.com/folke/which-key.nvim

Pops up a menu of available keybinds after you press a prefix (e.g. <leader>).
To label a new <leader> prefix group, add a line to `spec` below.
]]

---@module 'lazy'
---@type LazySpec
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  ---@module 'which-key'
  ---@type wk.Opts
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    delay = 0, -- ms between keypress and popup
    icons = { mappings = vim.g.have_nerd_font },

    -- Names for key-chain groups shown in the popup
    spec = {
      { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
      { 'gr', group = 'LSP Actions', mode = { 'n' } },
    },
  },
}
