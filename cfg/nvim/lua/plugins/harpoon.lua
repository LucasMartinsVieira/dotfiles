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

    vim.keymap.set("n", "<TAB>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    vim.keymap.set("n", "<S-h>", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set("n", "<S-j>", function()
      harpoon:list():select(2)
    end)
    vim.keymap.set("n", "<S-k>", function()
      harpoon:list():select(3)
    end)
    vim.keymap.set("n", "<S-l>", function()
      harpoon:list():select(4)
    end)
  end,
}
