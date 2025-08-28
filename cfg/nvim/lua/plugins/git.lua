local status_ok_gitsigns, gitsigns = pcall(require, "gitsigns")
if not status_ok_gitsigns then
	vim.notify("gitsigns plugin not found!", vim.log.levels.ERROR)
	return
end

gitsigns.setup({
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_curent_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000,
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
})

vim.keymap.set("n", "]g", function()
	require("gitsigns").next_hunk({ navigation_message = false })
end, { desc = "Next git hunk" })

vim.keymap.set("n", "[g", function()
	require("gitsigns").prev_hunk({ navigation_message = false })
end, { desc = "Prev git hunk" })

local status_ok_diffview, diffview = pcall(require, "diffview")
if not status_ok_diffview then
	vim.notify("diffview plugin not found!", vim.log.levels.ERROR)
	return
end

diffview.setup()
