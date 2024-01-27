return {
  "famiu/bufdelete.nvim",
  event = "VeryLazy",
  enabled = true,
  config = function()
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }
    keymap("n", "<S-d>", ":lua require('bufdelete').bufdelete(0, false)<cr>", opts)
  end,
}
