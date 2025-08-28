local status_ok, oil = pcall(require, "oil")
if not status_ok then
  vim.notify("Oil plugin not found!", vim.log.levels.ERROR)
  return
end

oil.setup({
	default_file_explorer = true,
	float = {
		max_height = 30,
		max_width = 85,
	},
})

vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open Parent Directory" })
