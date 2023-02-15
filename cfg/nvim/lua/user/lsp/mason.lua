local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end


local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
	return
end

local servers = {
	"bashls",
	"clangd",
	"html",
	"jsonls",
	"tsserver",
	"gopls",
	"cssls",
	"lua_ls",
	"marksman",
	"pyright",
	"rust_analyzer",
	"taplo",
	"yamlls",
}


local settings = {
	ui = {
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "⟳",
			package_uninstalled = "✗",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = require("user.lsp.handlers").capabilities,
      on_attach = require("user.lsp.handlers").on_attach,
      --settings = require("user.lsp.settings.")[server_name],
    }

    if server_name == "lua_ls" then
      settings.lua_ls = require("user.lsp.settings.lua_ls")
    end

    if server_name == "rust_analyzer" then
      settings.rust_analyzer = require("user.lsp.settings.rust")
    end

    if server_name == "tsserver" then
      settings.tsserver = require("user.lsp.settings.tsserver")
    end

    if server_name == "pyright" then
      settings.pyright = require("user.lsp.settings.pyright")
    end

    if server_name == "jsonls" then
      settings.jsonls = require("user.lsp.settings.jsonls")
    end

    if server_name == "yamlls" then
      settings.jsonls = require("user.lsp.settings.yamlls")
    end
  end
})
