return {
  "ruifm/gitlinker.nvim",
  enabled = false,
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    { "<leader>gy", "<CMD>GitLink!<CR>", desc = "Git Link" },
    { "<leader>gY", "<CMD>GitLink blam<CR>", desc = "Git Link Blame" },
  },
  config = function()
    require("gitlinker").setup({
      message = false,
      console_log = false,
    })
  end,
}
