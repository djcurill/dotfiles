--[[
autopairs
https://github.com/windwp/nvim-autopairs

Auto-inserts the closing bracket/quote when you type the opening one.
]]

---@module 'lazy'
---@type LazySpec
return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {},
}
