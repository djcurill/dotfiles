---@module 'lazy'
---@type LazySpec
return {
  -- colorschemes (add more here as you experiment)
  { 'folke/tokyonight.nvim' },
  { 'catppuccin/nvim', name = 'catppuccin' },

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
      },
    },
    keys = {
      { '<leader>cs', '<cmd>Themery<CR>', desc = '[C]olor[S]cheme picker' },
    },
  },
}
