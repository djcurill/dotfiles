lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "christoomey/vim-tmux-navigator" },
  {
    "tpope/vim-surround",
    setup = function()
      vim.o.timeoutlen = 500
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
}
