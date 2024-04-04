return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_allowed_dirs = { "~/repos", "~/dev", "~/Documents" },
    })

    vim.keymap.set("n", "<leader>ws", "<CMD>SessionSave<CR>", { desc = "Save Session" })
    vim.keymap.set("n", "<leader>wr", "<CMD>SessionRestore<CR>", { desc = "Restore Session" })
  end,
}
