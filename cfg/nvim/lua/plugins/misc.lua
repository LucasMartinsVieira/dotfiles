return {
  {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  {
    "LucasMartinsVieira/vim-nightfly-colors",
    priority = 1000,
  },
  {
    "LucasMartinsVieira/vim-moonfly-colors",
    name = "moonfly",
    lazy = true,
  },
  {
    "lunarvim/lunar.nvim",
    lazy = true,
  },
  {
    "Mofiqul/dracula.nvim",
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
  {
    "tpope/vim-sleuth",
    "opalmay/vim-smoothie",
  },
}
