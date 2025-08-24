vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.6.0" },
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
})
