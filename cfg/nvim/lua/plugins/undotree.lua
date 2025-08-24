vim.pack.add({
	"https://github.com/mbbill/undotree",
})

vim.keymap.set("n", "<leader>u", function()
	vim.cmd.UndotreeToggle()
	vim.cmd.UndotreeFocus()
end, { desc = "Undotree" })
