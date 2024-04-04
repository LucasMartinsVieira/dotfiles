return {
  "sindrets/diffview.nvim",
  enabled = true,
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
  },
  config = true,
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView Open" },
    { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "DiffView Close" },
  },
}
