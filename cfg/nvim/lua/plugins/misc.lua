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
    "norcalli/nvim-colorizer.lua",
    cmd = { "ColorizerToggle" },
    keys = {
      { "<space>C", "<CMD>ColorizerToggle<CR>", desc = "Colorizer Toggle" },
    },
  },
  {
    "psliwka/vim-smoothie",
  },
}
