require("vim._core.ui2").enable({})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("core.keymaps")
require("core.options")
require("core.autocommands")
require("core.lsp")

require("lazy").setup({
	{ import = "plugins" },
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})

local colorscheme = "moonfly"
vim.cmd.colorscheme(colorscheme)
