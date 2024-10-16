return {
  "stevearc/oil.nvim",
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      float = {
        max_height = 30,
        max_width = 85,
      },
    })

    vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open Parent Directory" })
  end,
}
