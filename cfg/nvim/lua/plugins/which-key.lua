vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim" },
})

local wk = require("which-key")
wk.setup()

wk.add({
	mode = { "n", "v" },
	{ "<leader>k", group = "Persistence" },
	{ "<leader>o", group = "Options" },
	{ "<leader>l", group = "Misc" },
})
