--[[
bufferline
https://github.com/akinsho/bufferline.nvim

Tab-style buffer list at the top of the screen. Keymaps: <Tab> / <S-Tab> next /
previous buffer, <leader>bp pin, <leader>bo close other buffers,
<leader>bh / <leader>bl close buffers to the left / right.
Closing a buffer is <leader>bd (lua/keymaps.lua).
]]

---@module 'lazy'
---@type LazySpec
return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<Tab>', '<cmd>BufferLineCycleNext<CR>', desc = 'Next buffer' },
    { '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Previous buffer' },
    { '<leader>bp', '<cmd>BufferLineTogglePin<CR>', desc = '[B]uffer [P]in' },
    { '<leader>bo', '<cmd>BufferLineCloseOthers<CR>', desc = '[B]uffer close [O]thers' },
    { '<leader>bh', '<cmd>BufferLineCloseLeft<CR>', desc = '[B]uffer close left' },
    { '<leader>bl', '<cmd>BufferLineCloseRight<CR>', desc = '[B]uffer close right' },
  },
  opts = {
    options = {
      separator_style = 'slant',
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
      -- Keep the bar clear of the neo-tree sidebar
      offsets = {
        { filetype = 'neo-tree', text = 'Explorer', highlight = 'Directory', text_align = 'left' },
      },
    },
  },
}
