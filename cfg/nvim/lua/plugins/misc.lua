return {
	{
		"brenoprata10/nvim-highlight-colors",
		lazy = false,
		config = function()
			local ok, nvim_hightlight_colors = pcall(require, "nvim-highlight-colors")
			if not ok then
				vim.notify("nvim-highlight-colors plugin not found!", vim.log.levels.ERROR)
				return
			end

			nvim_hightlight_colors.setup({
				enable_tailwind = true,
			})
		end,
	},
	{ "b0o/schemastore.nvim" },
	{ "luckasRanarison/tailwind-tools.nvim" },
}

