--[[
colorscheme (themes + picker)
https://github.com/zaldih/themery.nvim

Installs several colorschemes and uses themery to pick one with <leader>cs.
Themery persists the choice itself (in stdpath('data')/themery), so no theme
file is needed in this repo. To add a theme: add the plugin below and list its
colorscheme name(s) in themery's `themes`.
]]

---@module 'lazy'
---@type LazySpec

-- gruvbox.nvim ships a single `gruvbox` colorscheme; its variants are
-- config-driven (`contrast`) plus `vim.o.background`. Build themery entries
-- that configure gruvbox *before* applying it.
local function gruvbox(name, background, contrast)
  return {
    name = name,
    colorscheme = 'gruvbox',
    before = string.format(
      'require("gruvbox").setup({ contrast = %q }); vim.o.background = %q',
      contrast,
      background
    ),
  }
end

return {
  -- colorschemes (add more here as you experiment)
  { 'folke/tokyonight.nvim' },
  { 'catppuccin/nvim', name = 'catppuccin' },
  { 'ellisonleao/gruvbox.nvim' },
  { 'rebelot/kanagawa.nvim' },
  { 'shaunsingh/nord.nvim' },

  -- themery manages which one is active + persists across sessions
  {
    'zaldih/themery.nvim',
    lazy = false,
    opts = {
      themes = {
        'tokyonight',
        'tokyonight-night',
        'tokyonight-storm',
        'catppuccin',
        'catppuccin-latte',
        'catppuccin-frappe',
        'catppuccin-macchiato',
        'catppuccin-mocha',
        gruvbox('gruvbox', 'dark', ''), -- default: dark + medium contrast
        gruvbox('gruvbox-dark-hard', 'dark', 'hard'),
        gruvbox('gruvbox-dark-soft', 'dark', 'soft'),
        gruvbox('gruvbox-light', 'light', ''),
        gruvbox('gruvbox-light-hard', 'light', 'hard'),
        gruvbox('gruvbox-light-soft', 'light', 'soft'),
        'kanagawa',
        'kanagawa-wave',
        'kanagawa-dragon',
        'kanagawa-lotus',
        'nord',
      },
    },
    keys = {
      { '<leader>cs', '<cmd>Themery<CR>', desc = '[C]olor[S]cheme picker' },
    },
  },
}
