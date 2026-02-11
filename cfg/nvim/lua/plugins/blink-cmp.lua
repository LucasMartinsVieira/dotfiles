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

		-- Show documentation when selecting a completion item
		documentation = { auto_show = true, auto_show_delay_ms = 250 },
	},

	-- Experimental signature help support
	signature = {
		enabled = true,
		trigger = {
			-- Show the signature help automatically
			enabled = true,
			-- Show the signature help window after typing any of alphanumerics, `-` or `_`
			show_on_keyword = false,
			blocked_trigger_characters = {},
			blocked_retrigger_characters = {},
			-- Show the signature help window after typing a trigger character
			show_on_trigger_character = true,
			-- Show the signature help window when entering insert mode
			show_on_insert = false,
			-- Show the signature help window when the cursor comes after a trigger character when entering insert mode
			show_on_insert_on_trigger_character = true,
		},
		window = {
			min_width = 1,
			max_width = 100,
			max_height = 10,
			border = nil, -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
			winblend = 0,
			winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
			scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
			-- Which directions to show the window,
			-- falling back to the next direction when there's not enough space,
			-- or another window is in the way
			direction_priority = { "n", "s" },
			-- Can accept a function if you need more control
			-- direction_priority = function()
			--   if condition then return { 'n', 's' } end
			--   return { 's', 'n' }
			-- end,

			-- Disable if you run into performance issues
			treesitter_highlighting = true,
			show_documentation = true,
		},
	},

	keymap = {
		preset = "default",
	},

	fuzzy = { implementation = "prefer_rust_with_warning" },

	sources = {
		-- default = { "lsp", "path", "snippets", "buffer", "emoji", "crates", "obsidian", "obsidian_new", "obsidian_tags" },
		-- default = { "lsp", "path", "snippets", "buffer", "emoji", "crates" },
		default = { "lsp", "path", "snippets", "buffer" },
	},
})
