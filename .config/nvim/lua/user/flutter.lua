local flutter_tools_status_ok, flutter_tools = pcall(require, "flutter-tools")
if not flutter_tools_status_ok then
  return
end

flutter_tools.setup({
	lsp = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	},
})
