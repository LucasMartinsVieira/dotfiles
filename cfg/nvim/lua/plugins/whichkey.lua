return {
	{
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
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)

			local keymaps = {
				mode = { "n", "v" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<space>f"] = { name = "+[F]ile" },
				["<space>a"] = { name = "+[A]i" },
				["<space>g"] = { name = "+[G]it" },
				["<space>t"] = { name = "+[T]erminal" },
				["<space>x"] = { name = "+Diagnostics" },
				["<space>b"] = { name = "+[B]uffer" },
				["<space>l"] = { name = "+[L]sp" },
				["<space>s"] = { name = "[S]ubstitute Text" },
				["<space>c"] = { name = "+[C]onfig" },
				["<space>o"] = { name = "+[O]ptions" },
				["<space>S"] = { name = "+[S]plits" },
			}

			wk.register(keymaps)
		end,
	},
}
