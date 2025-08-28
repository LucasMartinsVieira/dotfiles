local status_ok, snacks = pcall(require, "snacks");
if not status_ok then
  vim.notify("Snacks plugin not found!", vim.log.levels.ERROR)
  return
end

snacks.setup({
	bigfile = { enabled = true },
	dashboard = { enabled = false },
	notifier = {
		enabled = true,
		timeout = 3000,
	},
	quickfile = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = false },
	styles = {
		notification = {
			wo = { wrap = true }, -- Wrap notifications
		},
	},
	lazygit = { configure = false },
	input = { enabled = true },
	explorer = { enabled = true },
})

vim.keymap.set("n", "<leader>d", function()
	Snacks.picker.diagnostics_buffer()
end, { desc = "Find diagnostics_buffer" })

vim.keymap.set("n", "<leader>D", function()
	Snacks.picker.diagnostics()
end, { desc = "Find diagnostics workspace" })

vim.keymap.set("n", "<leader>f", function()
	Snacks.picker.files()
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>g", function()
	Snacks.picker.grep()
end, { desc = "Grep" })

vim.keymap.set("n", "<leader>G", function()
	Snacks.picker.grep_word()
end, { desc = "Grep word" })

vim.keymap.set("n", "<leader>n", function()
	Snacks.picker.notifications()
end, { desc = "Find notifications" })

vim.keymap.set("n", "<leader><leader>", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>z", function()
	Snacks.zen()
end, { desc = "Zen Mode" })

vim.keymap.set("n", "<leader>Z", function()
	Snacks.zen.zoom()
end, { desc = "Zen Mode zoom" })

vim.keymap.set("n", "<leader>H", function()
	Snacks.picker.help()
end, { desc = "Find help" })

vim.keymap.set("n", "<leader>s", function()
	Snacks.picker.lsp_symbols()
end, { desc = "Find LSP Symbols" })

vim.keymap.set("n", "<leader>S", function()
	Snacks.picker.lsp_workspace_symbols()
end, { desc = "Find LSP Workspace Symbols" })

vim.keymap.set("n", "<leader>lg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })
