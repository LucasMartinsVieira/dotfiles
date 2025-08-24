vim.pack.add({
	"https://github.com/b0o/schemastore.nvim",
	-- "https://github.com/elkowar/yuck.vim"https://github.com/
	"https://github.com/luckasRanarison/tailwind-tools.nvim",
	"https://github.com/brenoprata10/nvim-highlight-colors",
})

require("tailwind-tools").setup({
	document_color = {
		enabled = true, -- can be toggled by commands
		kind = "inline", -- "inline" | "foreground" | "background"
		inline_symbol = "󰝤 ", -- only used in inline mode
		debounce = 200, -- in milliseconds, only applied in insert mode
	},
	conceal = {
		enabled = false, -- can be toggled by commands
		symbol = "󱏿", -- only a single character is allowed
		highlight = { -- extmark highlight options, see :h 'highlight'
			fg = "#38BDF8",
		},
	},
	custom_filetypes = {}, -- see the extension section to learn how it works
})

require("nvim-highlight-colors").setup({
	enable_tailwind = true,
})
