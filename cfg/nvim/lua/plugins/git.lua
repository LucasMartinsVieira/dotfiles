return {
	{
		"lewis6991/gitsigns.nvim",
		event = "InsertEnter",
		keys = {
			{ "]g", "<CMD>lua require 'gitsigns'.next_hunk({navigation_message = false})<CR>", desc = "Next Hunk" },
			{ "[g", "<CMD>lua require 'gitsigns'.prev_hunk({navigation_message = false})<CR>", desc = "Prev Hunk" },
		},
		config = function()
			local status_ok_gitsigns, gitsigns = pcall(require, "gitsigns")
			if not status_ok_gitsigns then
				vim.notify("gitsigns plugin not found!", vim.log.levels.ERROR)
				return
			end

			gitsigns.setup({
				signcolumn = true,
				numhl = false,
				linehl = false,
				word_diff = false,
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = false,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 1000,
					ignore_whitespace = false,
				},
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil,
				max_file_length = 40000,
				preview_config = {
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		enabled = true,
		-- cmd = {
		-- 	"DiffviewOpen",
		-- 	"DiffviewClose",
		-- 	"DiffviewToggleFiles",
		-- 	"DiffviewFocusFiles",
		-- },
		config = true,
	},
}

