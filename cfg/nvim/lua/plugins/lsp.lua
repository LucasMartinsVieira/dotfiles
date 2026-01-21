local status_ok_fidget, fidget = pcall(require, "fidget")
if not status_ok_fidget then
	vim.notify("Fidget plugin not found!", vim.log.levels.ERROR)
	return
end

fidget.setup()

local status_ok_mason, mason = pcall(require, "mason")
if not status_ok_mason then
	vim.notify("Mason plugin not found!", vim.log.levels.ERROR)
	return
end

mason.setup()

local status_ok_mason_installer, mason_tool_installer = pcall(require, "mason-tool-installer")
if not status_ok_mason_installer then
	vim.notify("Mason tool installer plugin not found!", vim.log.levels.ERROR)
	return
end

mason_tool_installer.setup({
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
		"markdown-oxide",
	},
})
