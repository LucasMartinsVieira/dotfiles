return {
  "f-person/git-blame.nvim",
  event = "BufRead",
  keys = {
    { "<leader>gb", "<CMD>GitBlameToggle<CR>", "Git Blame Toggle" },
  },
  opts = {
    enabled = false,
  },
}
