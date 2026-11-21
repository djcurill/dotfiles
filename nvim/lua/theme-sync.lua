--[[
theme-sync
Keeps Ghostty and tmux in sync with the active nvim colorscheme.

On every `ColorScheme` event:
  - Ghostty: map the nvim colorscheme to a Ghostty theme name, write it to
    ~/.config/ghostty/theme.conf (included by ghostty/config via
    `config-file = ?theme.conf`), and send Ghostty SIGUSR2 to reload live.
  - tmux: read colors from nvim's highlight groups (no mapping needed), write
    ~/.config/tmux/theme.conf (sourced by ~/.tmux.conf), and `source-file` it.

To support a new theme: add a line to `ghostty` below. Themes whose
`vim.g.colors_name` is the same for every variant (gruvbox, everforest) set
`vim.g.ghostty_theme` in their Themery `before` hook instead
(see lua/plugins/colorscheme.lua).
]]

local ghostty = {
  -- catppuccin
  ['catppuccin'] = 'Catppuccin Mocha',
  ['catppuccin-mocha'] = 'Catppuccin Mocha',
  ['catppuccin-macchiato'] = 'Catppuccin Macchiato',
  ['catppuccin-frappe'] = 'Catppuccin Frappe',
  ['catppuccin-latte'] = 'Catppuccin Latte',
  -- tokyonight
  ['tokyonight'] = 'TokyoNight',
  ['tokyonight-night'] = 'TokyoNight Night',
  ['tokyonight-storm'] = 'TokyoNight Storm',
  ['tokyonight-moon'] = 'TokyoNight Moon',
  ['tokyonight-day'] = 'TokyoNight Day',
  -- kanagawa
  ['kanagawa'] = 'Kanagawa Wave',
  ['kanagawa-wave'] = 'Kanagawa Wave',
  ['kanagawa-dragon'] = 'Kanagawa Dragon',
  ['kanagawa-lotus'] = 'Kanagawa Lotus',
  -- nord
  ['nord'] = 'Nord',
  -- rose-pine
  ['rose-pine'] = 'Rose Pine',
  ['rose-pine-main'] = 'Rose Pine',
  ['rose-pine-moon'] = 'Rose Pine Moon',
  ['rose-pine-dawn'] = 'Rose Pine Dawn',
  -- nightfox
  ['nightfox'] = 'Nightfox',
  ['carbonfox'] = 'Carbonfox',
  ['dawnfox'] = 'Dawnfox',
  ['dayfox'] = 'Dayfox',
  ['duskfox'] = 'Duskfox',
  ['nordfox'] = 'Nordfox',
  ['terafox'] = 'Terafox',
  -- single-theme families
  ['dracula'] = 'Dracula',
  ['onedark'] = 'Atom One Dark',
  ['solarized-osaka'] = 'Solarized Osaka Night',
  ['sonokai'] = 'Sonokai',
  ['oxocarbon'] = 'Oxocarbon',
  ['poimandres'] = 'Poimandres',
  ['vesper'] = 'Vesper',
  -- github
  ['github_dark'] = 'GitHub Dark',
  ['github_dark_default'] = 'GitHub Dark Default',
  ['github_dark_dimmed'] = 'GitHub Dark Dimmed',
  ['github_dark_high_contrast'] = 'GitHub Dark High Contrast',
  ['github_dark_colorblind'] = 'GitHub Dark Colorblind',
  ['github_light'] = 'GitHub Light Default',
  ['github_light_default'] = 'GitHub Light Default',
  ['github_light_high_contrast'] = 'GitHub Light High Contrast',
  ['github_light_colorblind'] = 'GitHub Light Colorblind',
  -- ayu
  ['ayu'] = 'Ayu',
  ['ayu-dark'] = 'Ayu',
  ['ayu-mirage'] = 'Ayu Mirage',
  ['ayu-light'] = 'Ayu Light',
}

local function resolve(name)
  if name == 'gruvbox' or name == 'everforest' then
    return vim.g.ghostty_theme -- set by the Themery entry's `before` hook
  elseif name == 'melange' then
    return vim.o.background == 'light' and 'Melange Light' or 'Melange Dark'
  end
  return ghostty[name]
end

local ghostty_path = vim.fn.expand '~/.config/ghostty/theme.conf'
local tmux_path = vim.fn.expand '~/.config/tmux/theme.conf'

-- Write `text` to `path` only if it changed. Returns true when it wrote.
local function write_if_changed(path, text)
  local f = io.open(path, 'r')
  local current = f and f:read '*a'
  if f then f:close() end
  if current == text then return false end

  f = io.open(path, 'w')
  if not f then
    vim.notify('theme-sync: cannot write ' .. path, vim.log.levels.WARN)
    return false
  end
  f:write(text)
  f:close()
  return true
end

local function sync_ghostty()
  local theme = resolve(vim.g.colors_name)
  if not theme then return end
  if write_if_changed(ghostty_path, ('theme = "%s"\n'):format(theme)) then
    vim.system { 'pkill', '-USR2', '-x', 'ghostty' } -- live reload
  end
end

-- tmux colors come from nvim's own highlight groups, so every theme works
-- without a mapping table.
local function hl_color(group, attr)
  local h = vim.api.nvim_get_hl(0, { name = group, link = false })
  return h[attr] and ('#%06x'):format(h[attr]) or nil
end

local function is_light(hex)
  local r, g, b = hex:match '#(%x%x)(%x%x)(%x%x)'
  return (0.299 * tonumber(r, 16) + 0.587 * tonumber(g, 16) + 0.114 * tonumber(b, 16)) / 255 > 0.5
end

local function sync_tmux()
  local dark = vim.o.background ~= 'light'
  local bg = hl_color('Normal', 'bg') or (dark and '#1e1e1e' or '#f5f5f5')
  local fg = hl_color('Normal', 'fg') or (dark and '#d4d4d4' or '#222222')
  local accent = hl_color('Function', 'fg') or hl_color('Directory', 'fg') or fg
  local dim = hl_color('Comment', 'fg') or fg
  local warn = hl_color('DiagnosticWarn', 'fg') or accent
  local on_accent = is_light(accent) and '#000000' or '#ffffff'

  local conf = table.concat({
    ('set -g @t_bg "%s"'):format(bg),
    ('set -g @t_fg "%s"'):format(fg),
    ('set -g @t_accent "%s"'):format(accent),
    ('set -g @t_on_accent "%s"'):format(on_accent),
    ('set -g @t_dim "%s"'):format(dim),
    ('set -g @t_warn "%s"'):format(warn),
    ('set -g status-style "bg=%s,fg=%s"'):format(bg, fg),
    ('set -g pane-border-style "fg=%s"'):format(dim),
    ('set -g pane-active-border-style "fg=%s"'):format(accent),
    ('set -g message-style "bg=%s,fg=%s"'):format(bg, warn),
    ('set -g mode-style "bg=%s,fg=%s"'):format(accent, on_accent),
    '',
  }, '\n')

  if write_if_changed(tmux_path, conf) then
    vim.system { 'tmux', 'source-file', tmux_path } -- no-op if no server runs
  end
end

vim.api.nvim_create_autocmd('ColorScheme', {
  desc = 'Sync Ghostty and tmux themes with nvim colorscheme',
  callback = function()
    sync_ghostty()
    sync_tmux()
  end,
})
