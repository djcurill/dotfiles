--[[
nvim-tmux (split/pane navigation)
https://github.com/christoomey/vim-tmux-navigator

Seamless <C-h/j/k/l> movement between nvim splits and herdr/tmux panes.
]]
---@module 'lazy'
---@type LazySpec
--
-- <C-h/j/k/l> are owned by vim-herdr-navigation (installed as a herdr plugin:
-- `herdr plugin list`), not by vim-tmux-navigator directly. Its editor/nvim.lua
-- does wincmd first and falls back to `herdr pane focus` at a split edge when
-- inside a herdr pane, or to vim-tmux-navigator's :TmuxNavigate* commands when
-- $TMUX is set instead (e.g. plain tmux over SSH, no herdr involved) — so tmux
-- keeps working unchanged outside herdr. `tmux_navigator_no_mappings = 1` just
-- stops this plugin from also binding <C-h/j/k/l> itself; its :TmuxNavigate*
-- commands stay fully defined for nvim.lua to call. `lazy = false` is required:
-- nvim.lua's keymaps must exist at startup, not only after a :TmuxNavigate*
-- command has already fired once (which would otherwise be a chicken-and-egg
-- problem under lazy.nvim's cmd-triggered lazy loading).
return {
  'christoomey/vim-tmux-navigator',
  lazy = false,
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    dofile(vim.fn.expand '~/.config/herdr/plugins/github/vim-herdr-navigation-a8bf42123d81/editor/nvim.lua')
  end,
}
