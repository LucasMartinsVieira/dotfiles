return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				suggestions = 20, -- how many suggestions should be shown in the list?
			},
		},
	},
	config = function()
		local status_not_ok, wk = pcall(require, "which-key")
		if not status_not_ok then
			vim.notify("which-key plugin not found!", vim.log.levels.ERROR)
			return
		end

		wk.setup()

		wk.add({
			mode = { "n", "v" },
			{ "<leader>k", group = "Persistence" },
			{ "<leader>o", group = "Options" },
			{ "<leader>l", group = "Misc" },
		})
	end,
}

