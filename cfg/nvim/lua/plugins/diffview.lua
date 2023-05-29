return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  config = true,
  keys = {
    { "<space>gd", "<cmd>DiffviewOpen<cr>",  desc = "DiffView Open" },
    { "<space>gD", "<cmd>DiffviewClose<cr>", desc = "DiffView Close" },
  },
}
