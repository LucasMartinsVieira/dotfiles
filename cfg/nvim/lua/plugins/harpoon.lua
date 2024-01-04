return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
    event = "VeryLazy",
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })

    vim.keymap.set("n", "<S-m>", function()
      harpoon:list():append()
    end)

    vim.keymap.set("n", "<TAB>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

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
  end,
}
