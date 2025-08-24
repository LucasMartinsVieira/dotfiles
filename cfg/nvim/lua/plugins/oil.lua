vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

require("oil").setup({
	default_file_explorer = true,
	float = {
		max_height = 30,
		max_width = 85,
	},
})

vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open Parent Directory" })
