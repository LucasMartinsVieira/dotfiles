return {
	"folke/persistence.nvim",
	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	keys = {
    -- stylua: ignore
		{ "<leader>ks", function() require("persistence").load() end, { desc = "Load the session for current directory" },
    -- stylua: ignore
    { "<leader>kS", function() require("persistence").select() end, { desc = "Select a session to load" } },
    -- stylua: ignore
    { "<leader>kl", function() require("persistence").load({ last = true }) end, { desc = "Load last session" }},
    -- stylua: ignore
    { "<leader>kd", function() require("persistence").stop() end, { desc = "Stop persistence (session won't be saved on exit)" } }
		},
	},
	config = function()
		local status_not_ok, persistence = pcall(require, "persistence")
		if not status_not_ok then
			vim.notify("persistence plugin not found!", vim.log.levels.ERROR)
			return
		end

		persistence.setup({
			dir = vim.fn.stdpath("state") .. "/sessions/",
			need = 1,
			branch = true,
		})
	end,
}
