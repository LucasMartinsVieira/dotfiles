local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<C-i>", "<C-i>", opts)

-- Normal --

-- Basics
-- keymap("n", "<leader>w", "<CMD>wa!<CR>", { desc = "Write" })
-- keymap("n", "<leader>q", "<CMD>lua require('user.functions').smart_quit()<CR>", { desc = "Quit" })
keymap("n", "<leader>h", "<CMD>split<CR>", { desc = "Split" })
keymap("n", "<leader>v", "<CMD>vsplit<CR>", { desc = "Vsplit" })
keymap("n", "<leader>/", "<CMD>noh<CR>", { desc = "Remove Highlight from words" })
keymap("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substite Text" })
-- keymap("n", "<leader>e", "<CMD>Ex<CR>", { desc = "File Explorer" })

-- Tmux stuff
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap("n", "<C-g>", "<cmd>silent !tmux new-window -n 'lazygit' lazygit<CR>")

-- Plugin keys
keymap("n", "<leader>pp", "<CMD>Lazy<CR>", { desc = "Plugin" })
keymap("n", "<leader>ps", "<CMD>Lazy sync<CR>", { desc = "Plugin Sync" })
keymap("n", "<leader>pc", "<CMD>Lazy clean<CR>", { desc = "Plugin Clean" })
keymap("n", "<leader>pl", "<CMD>Lazy log<CR>", { desc = "Plugin Log" })

-- Options/Open
-- stylua: ignore
keymap( "n", "<leader>on", "<CMD>lua require('user.functions').toggle_option('relativenumber')<CR>", { desc = "Toggle relative numbers" })
keymap("n", "<leader>os", "<CMD>lua require('user.functions').toggle_option('spell')<CR>", { desc = "spell" })
keymap("n", "<leader>oc", "<CMD>lua require('user.functions').toggle_option('cursorline')<CR>", { desc = "Cursor Line" })
-- stylua: ignore
keymap("n", "<leader>od", "<CMD>lua require('user.functions').toggle_diagnostics()<CR>", { desc = "Toggle diagnostics ON/OFF" })
keymap("n", "<leader>or", "<CMD>OpenCodeRepo<CR>", { desc = "Open Code Repo" })
keymap("n", "<leader>ox", "<CMD>!chmod +x %<CR>", { desc = "Chmod +x" })

-- Tabs
keymap("n", "<leader>an", "<CMD>$tabnew<CR>", { desc = "New Empty Tab" })
keymap("n", "<leader>aN", "<CMD>tabnew %<CR>", { desc = "New Tab" })
keymap("n", "<leader>ao", "<CMD>tabonly<CR>", { desc = "Only" })
keymap("n", "<leader>ac", "<CMD>tabclose<CR>", { desc = "Close Tab" })
keymap("n", "<leader>ah", "<CMD>tabnext<CR>", { desc = "Tab Next" })
keymap("n", "<leader>al", "<CMD>tabprevious<CR>", { desc = "Tab Prev" })
keymap("n", "<leader>aH", "<CMD>-tabmove<CR>", { desc = "Move Left" })
keymap("n", "<leader>aL", "<CMD>+tabmove<CR>", { desc = "Move Right" })

-- Resize Window
keymap("n", "<M-S-k>", "<CMD>resize -2<CR>")
keymap("n", "<M-S-j>", "<CMD>resize +2<CR>")
keymap("n", "<M-S-l>", "<CMD>vertical resize +2<CR>")
keymap("n", "<M-S-h>", "<CMD>vertical resize -2<CR>")

-- Navigate buffers
keymap("n", "<leader>bn", "<CMD>bnext<CR>", { desc = "Buffer Next" })
keymap("n", "<leader>bp", "<CMD>bprevious<CR>", { desc = "Buffer Prev" })
keymap("n", "<leader>bd", "<CMD>bdelete<CR>", { desc = "Buffer Delete" })

keymap("n", "]b", "<CMD>bnext<CR>", { desc = "Buffer Next" })
keymap("n", "[b", "<CMD>bprevious<CR>", { desc = "Buffer Prev" })

-- Quickfix list
keymap("n", "]q", "<CMD>cnext<CR>", { desc = "Quickfix Next" })
keymap("n", "[q", "<CMD>cprev<CR>", { desc = "Quickfix Prev" })

-- Move current line / block with Alt-j/k a la vscode.
keymap("n", "<A-j>", "<CMD>move .+1<CR>==")
keymap("n", "<A-k>", "<CMD>move .-2<CR>==")

keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- more good
keymap({ "n", "o", "x" }, "<s-h>", "^", opts)
keymap({ "n", "o", "x" }, "<s-l>", "g_", opts)

-- Insert --

-- ESC more acessible
keymap("i", "jk", "<ESC>")

-- Move current line / block with Alt-j/k a la vscode.
keymap("i", "<A-j>", "<Esc><CMD>move .+1<CR>==gi")
keymap("i", "<A-k>", "<Esc><CMD>move .-2<CR>==gi")

-- Visual --

-- Indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Moves selected

-- Move current line / block with Alt-j/k ala vscode.
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv")
