return {
	{
		"bluz71/vim-nightfly-guicolors",
    priority = 1000,
	},
	{
		"lunarvim/horizon.nvim",
    lazy = true,
	},
	{
		"Mofiqul/dracula.nvim",
    lazy = true,
	},
	{
		"romgrk/doom-one.vim",
    lazy = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = "markdown",
	},
	{
		"norcalli/nvim-colorizer.lua",
		cmd = { "ColorizerToggle" },
		keys = {
			{ "<space>C", "<CMD>ColorizerToggle<CR>", desc = "[C]olorizer Toggle" },
		},
	},
}