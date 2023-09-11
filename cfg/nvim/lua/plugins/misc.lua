return {
  {
    "echasnovski/mini.splitjoin",
    version = "*",
    config = function()
      require("mini.splitjoin").setup({
        mappings = {
          toggle = "J",
          split = "",
          join = "",
        },
        detect = {
          brackets = nil,
          separator = ",",
          exclude_regions = nil,
        },
        split = {
          hooks_pre = {},
          hooks_post = {},
        },
        join = {
          hooks_pre = {},
          hooks_post = {},
        },
      })
    end,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy"
  },
  -- Vim Plugins
  {
    "tpope/vim-sleuth",
  },
}
