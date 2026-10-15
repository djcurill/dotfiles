--[[
blink.cmp (autocompletion) + LuaSnip (snippet engine)
https://github.com/saghen/blink.cmp

Completion popup fed by LSP, file paths and snippets.
Keys use the 'super-tab' preset: <Tab> accepts, <c-space> opens menu/docs,
<c-n>/<c-p> select, <c-e> hides. See `:h blink-cmp-config-keymap`.
]]

---@module 'lazy'
---@type LazySpec
return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      -- Build step enables regex in snippets; skipped on Windows / without `make`.
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
        return 'make install_jsregexp'
      end)(),
      -- Prebuilt snippet collection (optional):
      --   { 'rafamadriz/friendly-snippets', config = function() require('luasnip.loaders.from_vscode').lazy_load() end }
      opts = {},
    },
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'super-tab' }, -- or 'default' | 'enter' | 'none'

    appearance = { nerd_font_variant = 'mono' }, -- 'normal' for non-mono Nerd Font

    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 500 }, -- <c-space> to show docs
    },

    sources = { default = { 'lsp', 'path', 'snippets' } }, -- add sources here

    snippets = { preset = 'luasnip' },

    -- 'lua' needs no binary; 'prefer_rust_with_warning' downloads a faster matcher
    fuzzy = { implementation = 'lua' },

    signature = { enabled = true }, -- signature help while typing arguments
  },
}
