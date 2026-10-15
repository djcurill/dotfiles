--[[
guess-indent
https://github.com/NMAC427/guess-indent.nvim

Detects tabs vs spaces and indent width from the file being opened.
Note: .editorconfig (read natively by Neovim) still takes precedence.
]]

---@module 'lazy'
---@type LazySpec
return {
  'NMAC427/guess-indent.nvim',
  event = 'BufReadPost',
  opts = {},
}
