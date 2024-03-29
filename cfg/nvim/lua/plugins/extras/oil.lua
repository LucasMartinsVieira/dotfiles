return {
  "stevearc/oil.nvim",
  enabled = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<CMD>Oil --float<CR>", desc = "Opens parent directory" },
  },
  opts = {
    float = {
      max_height = 20,
      max_width = 65,
    },
  },
}
