return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<leader>u", function()
      vim.cmd({ cmd = "UndotreeToggle" })
      vim.cmd({ cmd = "UndotreeFocus" })
    end, { desc = "Undotree" })
  end,
}
