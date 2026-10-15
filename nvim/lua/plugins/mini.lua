--[[
mini.nvim
https://github.com/nvim-mini/mini.nvim

A collection of small independent modules; each is enabled by a `setup()` call
below. To add another module, require and set it up in `config`.
]]

---@module 'lazy'
---@type LazySpec
return {
  'nvim-mini/mini.nvim',
  event = 'VeryLazy',
  config = function()
    -- mini.ai: better around/inside textobjects
    --   va)   select around parens      yinq  yank inside next quote
    --   ci'   change inside quotes
    require('mini.ai').setup { n_lines = 500 }

    -- mini.surround: add/delete/replace surroundings
    --   saiw)  add ) around word        sd'  delete surrounding quotes
    --   sr)'   replace ) with '
    require('mini.surround').setup()

    -- mini.statusline: simple statusline
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- Show the cursor location as LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function() return '%2l:%-2v' end
  end,
}
