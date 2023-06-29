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
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end,
  },
  {
    "AckslD/nvim-trevJ.lua",
    config = function()
      require("trevj").setup({
        containers = {
          lua = {
            table_constructor = { final_separator = ",", final_end_line = true },
            arguments = { final_separator = false, final_end_line = true },
            parameters = { final_separator = false, final_end_line = true },
          },
          -- ... -- other filetypes
        },
      })
    end,
  },
  {
    "tpope/vim-sleuth",
    "opalmay/vim-smoothie",
  },
}
