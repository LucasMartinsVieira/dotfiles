return {
  {
    "bluz71/vim-nightfly-colors",
    priority = 1000,
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    enabled = false,
    lazy = true,
  },
  {
    "lunarvim/lunar.nvim",
    enabled = false,
    lazy = true,
  },
  {
    "Mofiqul/dracula.nvim",
    enabled = false,
    lazy = true,
  },
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
  -- Vim Plugins
  {
    "tpope/vim-sleuth",
  },
}
