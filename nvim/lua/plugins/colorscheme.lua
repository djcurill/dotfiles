--[[
colorscheme (themes + picker)
https://github.com/zaldih/themery.nvim

Installs several colorschemes and uses themery to pick one with <leader>cs.
Themery persists the choice itself (in stdpath('data')/themery), so no theme
file is needed in this repo. To add a theme: add the plugin below, list its
colorscheme name(s) in themery's `themes`, and add a Ghostty mapping in
lua/theme-sync.lua (Ghostty follows the nvim colorscheme).
]]

---@module 'lazy'
---@type LazySpec

-- gruvbox.nvim ships a single `gruvbox` colorscheme; its variants are
-- config-driven (`contrast`) plus `vim.o.background`. Build themery entries
-- that configure gruvbox *before* applying it. `ghostty` is the matching
-- Ghostty theme (read by lua/theme-sync.lua).
local function gruvbox(name, background, contrast, ghostty)
  return {
    name = name,
    colorscheme = 'gruvbox',
    before = string.format(
      'require("gruvbox").setup({ contrast = %q }); vim.o.background = %q; vim.g.ghostty_theme = %q',
      contrast,
      background,
      ghostty
    ),
  }
end

-- everforest-nvim: same pattern as gruvbox (one colorscheme, config-driven).
local function everforest(name, background, contrast, ghostty)
  return {
    name = name,
    colorscheme = 'everforest',
    before = string.format(
      'require("everforest").setup({ background = %q }); vim.o.background = %q; vim.g.ghostty_theme = %q',
      contrast,
      background,
      ghostty
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
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'EdenEast/nightfox.nvim' },
  { 'neanias/everforest-nvim' },
  { 'Mofiqul/dracula.nvim' },
  { 'navarasu/onedark.nvim' },
  { 'projekt0n/github-nvim-theme', name = 'github-theme' },
  { 'craftzdog/solarized-osaka.nvim' },
  { 'sainnhe/sonokai' },
  { 'nyoom-engineering/oxocarbon.nvim' },
  { 'olivercederborg/poimandres.nvim' },
  { 'datsfilipe/vesper.nvim' },
  { 'savq/melange-nvim' },
  { 'Shatur/neovim-ayu' },

  -- themery manages which one is active + persists across sessions
  {
    'zaldih/themery.nvim',
    lazy = false,
    opts = {
      themes = {
        'tokyonight',
        'tokyonight-night',
        'tokyonight-storm',
        'tokyonight-moon',
        'tokyonight-day',
        'catppuccin',
        'catppuccin-latte',
        'catppuccin-frappe',
        'catppuccin-macchiato',
        'catppuccin-mocha',
        gruvbox('gruvbox', 'dark', '', 'Gruvbox Dark'), -- default: dark + medium contrast
        gruvbox('gruvbox-dark-hard', 'dark', 'hard', 'Gruvbox Dark Hard'),
        gruvbox('gruvbox-dark-soft', 'dark', 'soft', 'Gruvbox Dark'), -- no Ghostty soft theme
        gruvbox('gruvbox-light', 'light', '', 'Gruvbox Light'),
        gruvbox('gruvbox-light-hard', 'light', 'hard', 'Gruvbox Light Hard'),
        gruvbox('gruvbox-light-soft', 'light', 'soft', 'Gruvbox Light'), -- no Ghostty soft theme
        'kanagawa',
        'kanagawa-wave',
        'kanagawa-dragon',
        'kanagawa-lotus',
        'nord',
        'rose-pine',
        'rose-pine-moon',
        'rose-pine-dawn',
        'nightfox',
        'carbonfox',
        'dawnfox',
        'dayfox',
        'duskfox',
        'nordfox',
        'terafox',
        everforest('everforest-dark-hard', 'dark', 'hard', 'Everforest Dark Hard'),
        everforest('everforest-dark-medium', 'dark', 'medium', 'Everforest Dark Med'),
        everforest('everforest-dark-soft', 'dark', 'soft', 'Everforest Dark Soft'),
        everforest('everforest-light-hard', 'light', 'hard', 'Everforest Light Hard'),
        everforest('everforest-light-medium', 'light', 'medium', 'Everforest Light Med'),
        everforest('everforest-light-soft', 'light', 'soft', 'Everforest Light Soft'),
        'dracula',
        'onedark',
        'github_dark',
        'github_dark_default',
        'github_dark_dimmed',
        'github_dark_high_contrast',
        'github_dark_colorblind',
        'github_light_default',
        'github_light_high_contrast',
        'github_light_colorblind',
        'solarized-osaka',
        'sonokai',
        'oxocarbon',
        'poimandres',
        'vesper',
        'melange',
        'ayu-dark',
        'ayu-mirage',
        'ayu-light',
      },
    },
    keys = {
      { '<leader>cs', '<cmd>Themery<CR>', desc = '[C]olor[S]cheme picker' },
    },
  },
}
