return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "-", "<CMD>Oil --float<CR>", { desc = "Open Parent Directory" } },
	},
	opts = {
		default_file_explorer = true,
		float = {
			max_height = 30,
			max_width = 85,
		},
	},
}
