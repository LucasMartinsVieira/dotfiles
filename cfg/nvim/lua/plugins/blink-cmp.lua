return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	lazy = false,
	config = function()
		local status_not_ok, blink_cmp = pcall(require, "blink-cmp")
		if not status_not_ok then
			vim.notify("Blink-cmp plugin not found!", vim.log.levels.ERROR)
			return
		end

		blink_cmp.setup({
			completion = {
				menu = {
					auto_show = true,
					border = "single",
				},
				documentation = { auto_show = true, auto_show_delay_ms = 250 },
			},
			signature = {
				enabled = true,
				trigger = {
					enabled = true,
					show_on_keyword = false,
					blocked_trigger_characters = {},
					blocked_retrigger_characters = {},
					show_on_trigger_character = true,
					show_on_insert = false,
					show_on_insert_on_trigger_character = true,
				},
				window = {
					min_width = 1,
					max_width = 100,
					max_height = 10,
					border = nil,
					winblend = 0,
					winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
					scrollbar = false,
					direction_priority = { "n", "s" },
					treesitter_highlighting = true,
					show_documentation = true,
				},
			},
			keymap = {
				preset = "default",
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		})
	end,
}
