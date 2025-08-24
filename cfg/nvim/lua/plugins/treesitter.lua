vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter.git", version = "master" },
	"https://github.com/folke/ts-comments.nvim",
})

require("nvim-treesitter.configs").setup({
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
		-- "java",
		"javascript",
		"typescript",
		"tsx",
		"json",
		"jsonc",
		"lua",
		"markdown",
		"rust",
		"vim",
		"vimdoc",
		"yaml",
	},
	auto_install = false,
})

require("ts-comments").setup()

vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Handle nvim-treesitter updates",
	group = vim.api.nvim_create_augroup("nvim-treesitter-pack-changed-update-handler", { clear = true }),
	callback = function(event)
		if event.data.kind == "update" then
			vim.notify("nvim-treesitter updated, running TSUpdate...", vim.log.levels.INFO)
			---@diagnostic disable-next-line: param-type-mismatch
			local ok = pcall(vim.cmd, "TSUpdate")
			if ok then
				vim.notify("TSUpdate completed successfully!", vim.log.levels.INFO)
			else
				vim.notify("TSUpdate command not available yet, skipping", vim.log.levels.WARN)
			end
		end
	end,
})
