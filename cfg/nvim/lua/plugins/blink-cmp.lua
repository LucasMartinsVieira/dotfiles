local status_not_ok, blink_cmp = pcall(require, "blink-cmp")
if not status_not_ok then
	vim.notify("Blink-cmp plugin not found!", vim.log.levels.ERROR)
	return
end

blink_cmp.setup({
	completion = {
		menu = {
			auto_show = true,
			border = "single",
		},
	},

	signature = { enabled = true, window = { show_documentation = true } },

	keymap = {
		preset = "default",
	},

	fuzzy = { implementation = "prefer_rust_with_warning" },

	sources = {
		-- default = { "lsp", "path", "snippets", "buffer", "emoji", "crates", "obsidian", "obsidian_new", "obsidian_tags" },
		-- default = { "lsp", "path", "snippets", "buffer", "emoji", "crates" },
		default = { "lsp", "path", "snippets", "buffer" },
	},
})
