# nvim

Personal Neovim config, forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and split into small modules.
Requires **Neovim 0.12+** (uses `vim.lsp.config`, `vim.lsp.log.set_level` and the `main` branch of nvim-treesitter).

This directory is symlinked to `~/.config/nvim` from the dotfiles repo.

## Layout

```
init.lua              entry point: require() calls only
lazy-lock.json        pinned plugin commits (commit this)
.stylua.toml          Lua formatting rules (2 spaces, single quotes, 160 cols)
lua/
  options.lua         vim.g / vim.o / vim.opt (leader key, UI, search, LSP log level)
  keymaps.lua         global keymaps (plugin keymaps live in their plugin file)
  autocmds.lua        global autocommands (yank highlight)
  diagnostics.lua     how LSP/linter diagnostics are displayed
  lazy-setup.lua      bootstraps lazy.nvim and imports lua/plugins/*
  config/health.lua   custom :checkhealth checks (run `:checkhealth config`)
  plugins/            one file per plugin (or small group of related plugins)
    disabled/         parked specs; lazy.nvim ignores subdirectories
```

Load order in `init.lua` matters: `options` first (it sets the leader key before any plugin binds keys), then
`keymaps`, `autocmds`, `diagnostics`, and finally `lazy-setup`.

## Install

1. Install Neovim 0.12+ and the external dependencies below.
2. Clone/symlink this directory to `~/.config/nvim`.
3. Start `nvim`. lazy.nvim bootstraps itself and installs every plugin; Mason installs language servers.
4. Run `:checkhealth config` and `:checkhealth` to confirm everything is found.

### External dependencies

| Tool | Needed for |
| --- | --- |
| `git`, `make`, `unzip`, a C compiler (`gcc`/`clang`) | plugin installs, Mason, fzf-native, parser builds |
| [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`), [fd](https://github.com/sharkdp/fd) | Telescope file/grep search |
| [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md) | compiling treesitter parsers |
| [Nerd Font](https://www.nerdfonts.com/) | icons (set `vim.g.have_nerd_font = false` in `lua/options.lua` if you don't have one) |
| Clipboard tool (`pbcopy` on macOS, `xclip`/`xsel` on Linux) | `clipboard = unnamedplus` |
| `go`, `npm`, etc. | only for the languages you write |
| `golangci-lint`, `markdownlint`, `ruff`, `tflint` | linters in `lua/plugins/lint.lua` (install via `:Mason` or your package manager) |

## Daily use

Leader key is `<Space>`. Press it and wait: which-key shows what is available. `<leader>sk` searches every keymap.

| Keys | Action |
| --- | --- |
| `<leader>sf` / `sg` / `sw` | search files / grep / word under cursor |
| `<leader>sh` / `sk` / `sd` | search help / keymaps / diagnostics |
| `<leader>sr` / `s.` / `sn` | resume last search / recent files / nvim config files |
| `<leader><leader>` / `<leader>/` | switch buffer / fuzzy find in current buffer |
| `\` | reveal current file in neo-tree |
| `grn` / `gra` / `grr` / `grd` / `gri` / `grt` | LSP rename / code action / references / definition / implementation / type |
| `gO` / `gW` | document / workspace symbols |
| `<leader>f` | format buffer (also runs on save) |
| `]c` / `[c`, `<leader>gs` `gr` `gp` `gb` | git hunk nav, stage, reset, preview, blame (gitsigns) |
| `<leader>gy` / `gY` | yank / open GitHub permalink |
| `<leader>td` / `th` / `tb` | toggle diagnostics text / inlay hints / git blame |
| `<leader>cs` | colorscheme picker (themery) |
| `<leader>mp` | markdown preview |
| `<leader>w` / `x` / `X` / `bd` | save / quit window / quit all / close buffer |
| `<Tab>` | next buffer |
| `<C-h/j/k/l>` | move between splits and herdr/tmux panes |
| `<C-S-h/j/k/l>` | resize splits |
| `<leader>e` / `ev` | terminal in horizontal / vertical split (`<Esc><Esc>` leaves terminal mode) |

Indentation comes from `.editorconfig` (Neovim reads it natively and it wins), falling back to guess-indent.

## Changing things

### Change an option or keymap

- Editor setting: edit `lua/options.lua`.
- Global keymap: edit `lua/keymaps.lua`. Always pass a `desc` so it shows up in which-key and Telescope.
- Plugin keymap: put it in that plugin's `keys = {}` so lazy.nvim loads the plugin on first use.
- New `<leader>x` prefix: add a group name to `spec` in `lua/plugins/which-key.lua`.

### Add a plugin

1. Create `lua/plugins/<name>.lua` that returns a spec:

   ```lua
   -- myplugin: one line on what it does
   -- https://github.com/author/myplugin.nvim
   ---@module 'lazy'
   ---@type LazySpec
   return {
     'author/myplugin.nvim',
     event = 'VeryLazy',            -- or cmd = {...}, ft = {...}, keys = {...}
     opts = {},                     -- calls require('myplugin').setup(opts)
   }
   ```

2. Restart nvim (lazy.nvim installs it) or run `:Lazy install`.
3. Commit the updated `lazy-lock.json`.

`lua/lazy-setup.lua` imports the whole `plugins/` directory, so no registration step is needed.

Lazy-loading: give every plugin a trigger (`event`, `cmd`, `ft` or `keys`) unless it must run at startup (colorschemes,
neo-tree and treesitter use `lazy = false`). Use `opts = {}` when the defaults are fine and `config = function() ... end`
when you need to run code. Use `init = function() ... end` for `vim.g` settings a plugin reads before it loads.

### Remove or disable a plugin

- Remove: delete its file, then `:Lazy clean`.
- Park it: move the file into `lua/plugins/disabled/` (to re-enable, move it back up).
- Temporarily: add `enabled = false` to its spec.

### Add a language

Add the pieces you need; each is one line:

| Need | Where |
| --- | --- |
| Language server | add to the `servers` table in `lua/plugins/lsp.lua` (Mason installs it) |
| Formatter | add to `formatters_by_ft` in `lua/plugins/conform.lua` |
| Linter | add to `linters_by_ft` in `lua/plugins/lint.lua` |
| Syntax parser | add to `parsers` in `lua/plugins/treesitter.lua` |

Map an extension to a filetype (for example Go templates as HTML) in a `vim.filetype.add` call, e.g. in `lua/autocmds.lua`:

```lua
vim.filetype.add { extension = { tmpl = 'html' } }
```

Verify with `:set ft?`.

### Add a colorscheme

Add the plugin to `lua/plugins/colorscheme.lua` and list its colorscheme name in themery's `themes`. Pick it with `<leader>cs`.
Themery stores the active choice in `~/.local/share/nvim/themery`, not in this repo.

### Add a new core module

Create `lua/<name>.lua` and add `require '<name>'` to `init.lua`. Do not name a module after a plugin (`lazy.lua`, `telescope.lua`):
`require` would load your file instead of the plugin.

## Updating plugins

| Command | What it does |
| --- | --- |
| `:Lazy` | plugin UI (`?` for help) |
| `:Lazy update` | update everything and rewrite `lazy-lock.json` |
| `:Lazy restore` | reset plugins to the commits in `lazy-lock.json` (undo a bad update) |
| `:Lazy clean` | delete plugins no longer in the config |
| `:Mason` | install/update language servers and tools (`g?` for help) |
| `:TSUpdate` | update treesitter parsers |

Commit `lazy-lock.json` after an update so every machine gets the same versions.

## Health checks and troubleshooting

Start here:

```
:checkhealth config           this config's checks: nvim version, external tools
:checkhealth                  everything (long; read the ERROR and WARNING lines only)
:checkhealth lazy mason       plugin manager and Mason
:checkhealth vim.lsp          LSP clients and their state for the current buffer
:checkhealth nvim-treesitter  parsers and the tree-sitter CLI
```

Warnings for languages you don't use are fine.

| Symptom | Check |
| --- | --- |
| Error on startup | `:messages`, then `nvim --headless +qa` from a shell to see the error and traceback |
| Plugin misbehaves after an update | `:Lazy restore` |
| A key does nothing or does the wrong thing | `:verbose map <key>` shows who set it and where; `:checkhealth which-key` flags conflicts |
| No completions, diagnostics or hover | `:checkhealth vim.lsp`; `:lsp restart`; `:Mason` to confirm the server is installed |
| Need the LSP log | `:lua vim.cmd.edit(vim.lsp.log.get_filename())`. It only records `WARN`+ (set in `lua/options.lua`); use `'DEBUG'` temporarily |
| Not formatting on save | `:ConformInfo` (is the formatter installed and found?) |
| Linter not running | `:lua print(vim.inspect(require('lint').linters_by_ft[vim.bo.filetype]))`, and check the binary is on `$PATH` |
| No syntax highlighting | `:checkhealth nvim-treesitter`, then `:InspectTree`; make sure `tree-sitter` and a C compiler exist |
| Wrong filetype | `:set ft?` and `:verbose set ft?` |
| Wrong indent | `:verbose set shiftwidth? expandtab?` shows whether `.editorconfig`, guess-indent or a ftplugin set it |
| Slow startup | `nvim --startuptime /tmp/s.log +qa`, or `:Lazy profile` |
| Is it my config or a plugin bug? | `nvim --clean` starts with no config; bisect by moving files to `lua/plugins/disabled/` |
| Plugin install is corrupt | `rm -rf ~/.local/share/nvim/lazy/<plugin>`, then `:Lazy install` |
| Full reset | remove `~/.local/share/nvim`, `~/.local/state/nvim` and `~/.cache/nvim`, then start nvim (re-downloads everything) |

### Known gotchas

- **`lua/plugins/nvim-tmux.lua` hardcodes a path** to the herdr navigation plugin
  (`~/.config/herdr/plugins/github/vim-herdr-navigation-<hash>/editor/nvim.lua`). If herdr updates or reinstalls that plugin the
  hash changes and nvim errors on startup. Run `herdr plugin list` / `ls ~/.config/herdr/plugins/github/` and update the path.
- **`:checkhealth` only discovers `lua/<name>/health.lua`.** A `lua/health.lua` is silently ignored, which is why the custom
  checks live in `lua/config/`.
- **Neovim API names change between releases.** `vim.lsp.log.set_log_level` was removed in 0.12 (it is `set_level` now).
  If startup breaks right after upgrading nvim, check `:help news`.
- **`<C-S-hjkl>` resize** needs a terminal that sends distinct keycodes for Ctrl+Shift; some do not.
- **`:LspInfo` and `:LspLog` do not exist** in this setup; use `:checkhealth vim.lsp` and the log command above.

## Formatting this repo

Lua files are formatted with [StyLua](https://github.com/JohnnyMorganz/StyLua) using `.stylua.toml`. It is installed by Mason
and runs on save (`<leader>f` formats on demand). Keep a short `--[[ ... ]]` block comment at the top of every file saying what it does (inline `--` comments are for individual lines).

## Reference

- `:help` and `<leader>sh` (search help)
- `:help lua-guide`, `:help lazy.nvim.txt`
- [lazy.nvim spec reference](https://lazy.folke.io/spec)
