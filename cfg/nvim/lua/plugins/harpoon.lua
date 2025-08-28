local status_ok, harpoon = pcall(require, "harpoon")
if not status_ok then
  vim.notify("Harpoon plugin not found!", vim.log.levels.ERROR)
end

harpoon:setup({
	settings = {
		save_on_toggle = true,
		sync_on_ui_close = true,
	},
})

local mark_file = function()
	harpoon:list():add()

	local status_ok, _ = pcall(function()
		-- vim.notify = require("notify")
		-- vim.notify("󱡅  marked file", "info", {
		--   title = "Harpoon",
		-- })
		---@type fun(msg: string|string[], opts?: snacks.notify.Opts)
		Snacks.notify.info("Harpoon")
	end)

	if not status_ok then
		vim.print("󱡅 marked file")
	end
end

vim.keymap.set("n", "<leader>h", function()
	mark_file()
end, { desc = "Add harpoon" })

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
