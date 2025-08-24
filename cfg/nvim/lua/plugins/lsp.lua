vim.pack.add({
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

require("fidget").setup()
require("mason").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		-- Bash
		"bash-language-server",
		"shfmt",
		"shellcheck",

		-- Lua
		"lua-language-server",
		"stylua",

		-- Go
		"gopls",
		"golines",
		"goimports-reviser",

		-- Rust
		"rustfmt",
		-- "rust_analyzer",

		-- TypeScript
		"css-lsp",
		"eslint-lsp",
		"prettierd",
		"html-lsp",
		"prisma-language-server",
		"typescript-language-server",

		-- Others
		"json-lsp",
		"taplo",
		"yaml-language-server",
	},
})
