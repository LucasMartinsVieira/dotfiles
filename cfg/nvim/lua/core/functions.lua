local M = {}

function M.smart_quit()
	local bufnr = vim.api.nvim_get_current_buf()
	local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
	if modified then
		vim.ui.input({
			prompt = "You have unsaved changes. Quit anyway? (y/n) ",
		}, function(input)
			if input == "y" then
				vim.cmd("q!")
			end
		end)
	else
		vim.cmd("q!")
	end
end

M.toggle_lsp_inlayhints = function()
	local bufnr = vim.api.nvim_get_current_buf()
	-- vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled())
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

return M
