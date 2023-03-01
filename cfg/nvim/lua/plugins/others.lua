return {
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
    "lunarvim/horizon.nvim",
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
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
  },
  {
    "norcalli/nvim-colorizer.lua",
    cmd = { "ColorizerToggle" },
    keys = {
      { "<space>C", "<CMD>ColorizerToggle<CR>", desc = "[C]olorizer Toggle" },
    },
  },
}
