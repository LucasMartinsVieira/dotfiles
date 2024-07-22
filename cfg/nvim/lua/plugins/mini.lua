return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.ai").setup({
      n_lines = 500,
    })

    require("mini.surround").setup()
    require("mini.pairs").setup()
    require("mini.ai").setup()
    -- vim.keymap.set("n", "<leader>e", "<CMD>lua MiniFiles.open()<CR>", { desc = "Mini Files" })
  end,
}
