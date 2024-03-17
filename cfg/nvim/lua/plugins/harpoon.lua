return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })

    local mark_file = function()
      harpoon:list():append()

      local status_ok, _ = pcall(function()
        vim.notify("󱡅  marked file", "info", {
          title = "Harpoon",
        })
      end)

      if not status_ok then
        vim.print("󱡅 marked file")
      end
    end

    vim.keymap.set("n", "<S-m>", function()
      mark_file()
    end)

    vim.keymap.set("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon" })

    vim.keymap.set("n", "<C-h>", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set("n", "<C-j>", function()
      harpoon:list():select(2)
    end)
    vim.keymap.set("n", "<C-k>", function()
      harpoon:list():select(3)
    end)
    vim.keymap.set("n", "<C-l>", function()
      harpoon:list():select(4)
    end)

    vim.keymap.set("n", "<M-h>", function()
      harpoon:list():prev()
    end)
    vim.keymap.set("n", "<M-l>", function()
      harpoon:list():next()
    end)
  end,
}
