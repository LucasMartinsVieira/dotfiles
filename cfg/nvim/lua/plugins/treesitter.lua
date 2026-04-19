return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"folke/ts-comments.nvim",
		},
		lazy = false,
		config = function()
			-- local status_not_ok, treesitter = pcall(require, "nvim-treesitter.configs")
			-- if not status_not_ok then
			-- 	vim.notify("Treesitter plugin not found!", vim.log.levels.ERROR)
			-- 	return
			-- end
			require("nvim-treesitter").setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
				ensure_installed = {
					"bash",
					"comment",
					"regex",
					"c",
					"html",
					"javascript",
					"typescript",
					"tsx",
					"json",
					"lua",
					"markdown",
					"rust",
					"vim",
					"vimdoc",
					"yaml",
				},
				auto_install = false,
			})
			-- treesitter.setup({
			-- 	highlight = {
			-- 		enable = true,
			-- 		additional_vim_regex_highlighting = false,
			-- 	},
			-- 	indent = {
			-- 		enable = true,
			-- 	},
			-- 	ensure_installed = {
			-- 		"bash",
			-- 		"comment",
			-- 		"regex",
			-- 		"c",
			-- 		"html",
			-- 		"javascript",
			-- 		"typescript",
			-- 		"tsx",
			-- 		"json",
			-- 		"lua",
			-- 		"markdown",
			-- 		"rust",
			-- 		"vim",
			-- 		"vimdoc",
			-- 		"yaml",
			-- 	},
			-- 	auto_install = false,
			-- })
		end,
	},
	-- {
	-- 	"folke/ts-comments.nvim",
	-- 	opts = {},
	-- 	event = "VeryLazy",
	-- 	enabled = vim.fn.has("nvim-0.10.0") == 1,
	-- },
}
