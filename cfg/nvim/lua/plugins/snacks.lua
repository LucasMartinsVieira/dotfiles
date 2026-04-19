return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local status_ok, snacks = pcall(require, "snacks")
		if not status_ok then
			vim.notify("Snacks plugin not found!", vim.log.levels.ERROR)
			return
		end

		snacks.setup({
			bigfile = { enabled = true },
			dashboard = { enabled = false },
			notifier = {
				enabled = true,
				timeout = 3000,
			},
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = false },
			styles = {
				notification = {
					wo = { wrap = true },
				},
			},
			lazygit = { configure = false },
			input = { enabled = true },
			explorer = { enabled = true },
		})

		vim.keymap.set("n", "<leader>z", function()
			Snacks.zen()
		end, { desc = "Zen Mode" })

		vim.keymap.set("n", "<leader>Z", function()
			Snacks.zen.zoom()
		end, { desc = "Zen Mode zoom" })

		vim.keymap.set("n", "<leader>lg", function()
			Snacks.lazygit()
		end, { desc = "Lazygit" })

		vim.keymap.set("n", "<leader>e", function()
			Snacks.explorer()
		end)
	end,
}
