--[[
conform (formatting)
https://github.com/stevearc/conform.nvim

Formats on save and on <leader>f. Formatters are binaries (install via :Mason
or add to `ensure_installed` in lsp.lua). Check status with :ConformInfo.
To add a language: add an entry to `formatters_by_ft` below.
]]

---@module 'lazy'
---@type LazySpec
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function() require('conform').format { async = true, lsp_format = 'fallback' } end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = {
    notify_on_error = false,
    -- Skip format-on-save for filetypes without a standard style
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback', -- use the LSP formatter when no conform formatter is set
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Run several in sequence:   python = { 'isort', 'black' },
      -- First available only:      javascript = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}
