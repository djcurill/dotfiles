--[[
indent-blankline (DISABLED: lives in plugins/disabled/, so lazy ignores it)

Adds indentation guides, even on blank lines. To enable, move this file up
into lua/plugins/.
]]

---@module 'lazy'
---@type LazySpec
return {
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help ibl`
  main = 'ibl',
  ---@module 'ibl'
  ---@type ibl.config
  opts = {},
}
