return {
	{
		"j-hui/fidget.nvim",
		enabled = true,
		-- tag = "v1.1.0",
		opts = {},
		dependencies = {
			"neovim/nvim-lspconfig",
		},
	},
	{
		"mason-org/mason.nvim",
		build = ":MasonUpdate",
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			local status_ok_mason_installer, mason_tool_installer = pcall(require, "mason-tool-installer")
			if not status_ok_mason_installer then
				vim.notify("Mason tool installer plugin not found!", vim.log.levels.ERROR)
				return
			end

			mason_tool_installer.setup({
				ensure_installed = {
					"bash-language-server",
					"shfmt",
					"shellcheck",
					"lua-language-server",
					"stylua",
					"gopls",
					"golines",
					"goimports-reviser",
					"rustfmt",
					"css-lsp",
					"eslint-lsp",
					"prettierd",
					"html-lsp",
					"prisma-language-server",
					"typescript-language-server",
					"json-lsp",
					"taplo",
					"yaml-language-server",
					"markdown-oxide",
				},
			})
		end,
	},
}

