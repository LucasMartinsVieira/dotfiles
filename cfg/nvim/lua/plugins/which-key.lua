local status_not_ok, wk = pcall(require, "which-key")
if not status_not_ok then
	vim.notify("which-key plugin not found!", vim.log.levels.ERROR)
	return
end

wk.setup()

wk.add({
	mode = { "n", "v" },
	{ "<leader>k", group = "Persistence" },
	{ "<leader>o", group = "Options" },
	{ "<leader>l", group = "Misc" },
})
