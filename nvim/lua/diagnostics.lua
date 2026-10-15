--[[
diagnostics.lua

How errors/warnings (from LSP and linters) are displayed.
Toggle keymap lives in keymaps.lua (<leader>td).
Reference: `:help vim.diagnostic.Opts`
]]

vim.diagnostic.config {
  update_in_insert = false, -- don't refresh while typing
  severity_sort = true, -- errors before warnings
  float = { border = 'rounded', source = 'if_many' }, -- floating window style; show source when >1 tool reports
  underline = { severity = { min = vim.diagnostic.severity.WARN } }, -- only underline warnings and errors

  virtual_text = true, -- message at end of line
  virtual_lines = false, -- alternative: message on virtual lines underneath

  jump = { float = true }, -- open the float when jumping with [d / ]d
}
