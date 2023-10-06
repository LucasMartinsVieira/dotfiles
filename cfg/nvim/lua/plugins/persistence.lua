return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  enabled = false,
  keys = {
    { "<leader>ss", "<CMD>lua require('persistence').load({ last = true})<CR>", desc = "Session Load (last)" },
    { "<leader>sl", "<CMD>lua require('persistence').load()<CR>", desc = "Session Load" },
    { "<leader>sS", "<CMD>lua require('persistence').stop()<CR>", desc = "Session Stop" },
  },
  opts = {
    dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
    options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
    pre_save = nil, -- a function to call before saving the session
  },
}
