local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	vim.notify("Telescope plugin not found!", vim.log.levels.ERROR)
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "truncate" },
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<esc>"] = actions.close,
			},
			n = {
				q = actions.close,
			},
		},
	},
	pickers = {
		diagnostics = {
			theme = "ivy",
			layout_strategy = "bottom_pane",
			layout_config = {
				height = 15,
			},
		},
	},
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>d", function()
	builtin.diagnostics({ bufnr = 0 })
end, { desc = "Find diagnostics buffer" })

vim.keymap.set("n", "<leader>D", function()
	builtin.diagnostics()
end, { desc = "Find diagnostics workspace" })

vim.keymap.set("n", "<leader>f", function()
	builtin.find_files()
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>g", function()
	builtin.live_grep()
end, { desc = "Grep" })

vim.keymap.set("n", "<leader>G", function()
	builtin.grep_string()
end, { desc = "Grep word" })

vim.keymap.set("n", "<leader><leader>", function()
	builtin.buffers()
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>H", function()
	builtin.help_tags()
end, { desc = "Find help" })

vim.keymap.set("n", "<leader>s", function()
	builtin.lsp_document_symbols()
end, { desc = "Find LSP Symbols" })

vim.keymap.set("n", "<leader>S", function()
	builtin.lsp_workspace_symbols()
end, { desc = "Find LSP Workspace Symbols" })

vim.keymap.set("n", "grd", function()
	builtin.lsp_definitions()
end, { desc = "Telescope: LSP Definitions" })

vim.keymap.set("n", "grr", function()
	builtin.lsp_references()
end, { desc = "Telescope: LSP References" })

