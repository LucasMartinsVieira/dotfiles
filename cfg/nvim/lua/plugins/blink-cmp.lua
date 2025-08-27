vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.6.0" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
})

require("blink-cmp").setup({
	completion = {
		menu = {
			auto_show = true,
			border = "single",
		},
	},

	signature = { enabled = true, window = { show_documentation = true } },

	-- INFO: Change this to rust afterwards...
	fuzzy = { implementation = "lua" },

	sources = {
		-- default = { "lsp", "path", "snippets", "buffer", "emoji", "crates", "obsidian", "obsidian_new", "obsidian_tags" },
		-- default = { "lsp", "path", "snippets", "buffer", "emoji", "crates" },
		default = { "lsp", "path", "snippets", "buffer" },
	},
})
