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

vim.api.nvim_create_user_command("ToggleSpell", function()
	vim.opt.spell = not vim.opt.spell:get()
	if vim.opt.spell:get() then
		print("Spell checking enabled")
	else
		print("Spell checking disabled")
	end
end, {})

vim.api.nvim_create_user_command("ToggleWrap", function()
	vim.opt.wrap = not vim.opt.wrap:get()
	if vim.opt.wrap:get() then
		print("Line wrapping enabled")
	else
		print("Line wrapping disabled")
	end
end, {})
