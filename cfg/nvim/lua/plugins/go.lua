return {
  "olexsmir/gopher.nvim",
  dependencies = { -- dependencies
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = "go",
  enabled = false,
  build = function()
    vim.cmd([[silent! GoInstallDeps]])
  end,
  config = function(_, opts)
    require("gopher").setup(opts)
    require("dap-go").setup()
  end,
}
