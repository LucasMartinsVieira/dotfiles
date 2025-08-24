vim.api.nvim_create_augroup("general_settings", {})
vim.api.nvim_create_augroup("mappings", {})

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	group = "general_settings",
	desc = "Highlight text on yank",
	callback = function()
		vim.highlight.on_yank({ higroup = "Search", timeout = 100 })
	end,
})

vim.api.nvim_create_autocmd("filetype", {
	group = "mappings",
	desc = "Make q close help, man, lir",
	pattern = {
		"help",
		"man",
		"lspinfo",
		"netrw",
		"oil",
	},
	callback = function()
		vim.keymap.set("n", "q", "<CMD>q!<CR>", { buffer = true })
		vim.opt_local.buflisted = false
	end,
})
