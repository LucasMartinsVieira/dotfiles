return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	ft = { "markdown" },
	config = function()
		require("render-markdown").setup({
			heading = {
				enabled = false,
			},
			bullet = {
				enabled = false,
				icons = { "•", "", "•", "" },
			},
			dash = { width = 15 },
			pipe_table = {
				enabled = false,
				preset = "round",
			},
			checkbox = {
				enabled = true,
				unchecked = {
					icon = "󰄱",
				},
				checked = {
					icon = "󰄲",
				},
				custom = {
					in_progress = { raw = "[/]", rendered = "󱎖", highlight = "RenderMarkdownTodo" },
					fowarded = { raw = "[>]", rendered = "󰨳", highlight = "RenderMarkdownTodo" },
				},
			},
			code = {
				enabled = true,
			},
			yaml = {
				enabled = true,
			},
		})
	end,
}
