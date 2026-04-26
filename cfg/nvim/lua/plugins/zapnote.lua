return {
	dir = "~/repos/zapnote.nvim",
	dependencies = {},
	config = function()
		require("zapnote").setup({
			zn_cmd = "zn",
			link = {
				enabled = true,
				format = "[[%s]]",
			},
			open = {
				cmd = "edit",
			},
		})

		vim.keymap.set("n", "<leader>zn", ":ZnNote<CR>", { desc = "Zapnote note", silent = true })
		vim.keymap.set("n", "<leader>zj", ":ZnJournal<CR>", { desc = "Zapnote journal", silent = true })
		vim.keymap.set("v", "<leader>zn", ":ZnNote<CR>", { desc = "Zapnote note from selection", silent = true })

		vim.keymap.set("n", "<A-d>", ":ZnJournal day<CR>", { desc = "Zapnote journal day", silent = true })
		vim.keymap.set("n", "<A-w>", ":ZnJournal week<CR>", { desc = "Zapnote journal week", silent = true })
		vim.keymap.set("n", "<A-q>", ":ZnJournal quarter<CR>", { desc = "Zapnote journal quarter", silent = true })

		-- Go back one date unit
		vim.keymap.set(
			"n",
			"<A-y>",
			":ZnJournalNav day --offset +1 day<CR>",
			{ desc = "Advance one day", silent = true }
		)
		vim.keymap.set(
			"n",
			"<A-t>",
			":ZnJournalNav day --offset -1 day<CR>",
			{ desc = "Go back one day", silent = true }
		)

		vim.keymap.set(
			"n",
			"<A-S-y>",
			":ZnJournalNav week --offset +1 week<CR>",
			{ desc = "Advance one week", silent = true }
		)
		vim.keymap.set(
			"n",
			"<A-S-t>",
			":ZnJournalNav week --offset -1 week<CR>",
			{ desc = "Go back one week", silent = true }
		)

		vim.keymap.set(
			"n",
			"<C-A-y>",
			":ZnJournalNav quarter --offset +1 quarter<CR>",
			{ desc = "Advance one quarter", silent = true }
		)
		vim.keymap.set(
			"n",
			"<C-A-t>",
			":ZnJournalNav quarter --offset -1 quarter<CR>",
			{ desc = "Go back one quarter", silent = true }
		)
		local function zn_prev_year_journal()
			local bufname = vim.api.nvim_buf_get_name(0)
			local stem = vim.fn.fnamemodify(bufname, ":t:r")

			local journal_name
			if stem:match("^%d%d%d%d%-%d%d%-%d%d$") then
				journal_name = "day"
			elseif stem:match("^%d%d%d%d%-W%d%d?$") then
				journal_name = "week"
			elseif stem:match("^%d%d%d%d%-Q[1-4]$") then
				journal_name = "quarter"
			end

			if not journal_name then
				vim.notify("Not on journal note", vim.log.levels.WARN)
				return
			end

			vim.cmd(string.format("ZnJournalNav %s --offset -1 year", journal_name))
		end

		vim.keymap.set("n", "<leader>zy", zn_prev_year_journal, { desc = "Go to journal last year" })
	end,
}
