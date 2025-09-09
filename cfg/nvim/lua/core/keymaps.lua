local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- NORMAL
vim.keymap.set("n", "<leader>w", "<CMD>wa!<CR>", { desc = "Write" })
vim.keymap.set("n", "<leader>q", "<CMD>lua require('core.functions').smart_quit()<CR>", { desc = "Quit" })
-- Map <leader>y to yank into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
-- vim.keymap.set("n", "<leader>o", "<CMD>source<CR>")

vim.keymap.set("n", "<leader>/", "<CMD>noh<CR>", { desc = "Remove Highlight from words" })

vim.keymap.set("n", "<A-j>", "<CMD>move .+1<CR>==")
vim.keymap.set("n", "<A-k>", "<CMD>move .-2<CR>==")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)
vim.keymap.set("n", "*", "*zz", opts)
vim.keymap.set("n", "#", "#zz", opts)
vim.keymap.set("n", "g*", "g*zz", opts)
vim.keymap.set("n", "g#", "g#zz", opts)

vim.keymap.set({ "n", "o", "x" }, "<s-h>", "^", opts)
vim.keymap.set({ "n", "o", "x" }, "<s-l>", "g_", opts)

vim.keymap.set("n", "<M-S-k>", "<CMD>resize -2<CR>")
vim.keymap.set("n", "<M-S-j>", "<CMD>resize +2<CR>")
vim.keymap.set("n", "<M-S-l>", "<CMD>vertical resize +2<CR>")
vim.keymap.set("n", "<M-S-h>", "<CMD>vertical resize -2<CR>")

vim.keymap.set("n", "<leader>os", "<CMD>ToggleSpell<CR>", opts)
vim.keymap.set("n", "<leader>ow", "<CMD>ToggleWrap<CR>", opts)

-- INSERT
vim.keymap.set("i", "jk", "<ESC>")

vim.keymap.set("i", "<A-j>", "<Esc><CMD>move .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc><CMD>move .-2<CR>==gi")

-- VISUAL
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv")
