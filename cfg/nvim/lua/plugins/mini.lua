return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.ai").setup({
      n_lines = 500,
    })

    -- require("mini.files").setup()
    require("mini.surround").setup()
    require("mini.pairs").setup()

    -- vim.keymap.set("n", "<leader>e", "<CMD>lua MiniFiles.open()<CR>", { desc = "Mini Files" })
  end,
}
