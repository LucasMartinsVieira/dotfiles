return {
  "theprimeagen/harpoon",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- stylua: ignore
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { desc = desc })
    end

    map("<leader>ha", mark.add_file, "Harpoon Add")
    map("<leader>ht", ui.toggle_quick_menu, "Harpoon Toggle")

    vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end)
  end,
}
