local opts = { noremap = true, silent = true }

local nmap = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { desc = desc })
end

local function imap(key, map)
  vim.api.nvim_set_keymap("i", key, map, opts)
end

local function vmap(key, map)
  vim.api.nvim_set_keymap("v", key, map, opts)
end

local function xmap(key, map)
  vim.api.nvim_set_keymap("x", key, map, opts)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --

-- Basics
nmap("<leader>w", "<CMD>w<CR>", "Write")
nmap("<leader>q", "<CMD>lua require('user.functions').smart_quit()<CR>", "Quit")
-- nmap("<leader>e", "<CMD>Ex<CR>", "Explorer")
-- nmap("<leader>h", "<CMD>split<CR>", "Split")
nmap("<leader>v", "<CMD>vsplit<CR>", "Vsplit")
nmap("<leader>/", "<CMD>noh<CR>", "")
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- local builtin = require("telescope.builtin")
-- vim.keymap.set("n", "C-p", require("telescope.builtin").git_files)

-- Plugin keys
nmap("<leader>pp", "<CMD>Lazy<CR>", "Plugin")
nmap("<leader>ps", "<CMD>Lazy sync<CR>", "Plugin Sync")
nmap("<leader>pc", "<CMD>Lazy clean<CR>", "Plugin Clean")
nmap("<leader>pl", "<CMD>Lazy log<CR>", "Plugin Log")

-- Options/Open
nmap("<leader>on", "<CMD>lua require('user.functions').toggle_option('relativenumber')<CR>", "Toggle relative numbers")
nmap("<leader>os", "<CMD>lua require('user.functions').toggle_option('spell')<CR>", "Spell")
nmap("<leader>oc", "<CMD>lua require('user.functions').toggle_option('cursorline')<CR>", "Cursor Line")
nmap("<leader>od", "<CMD>lua require('user.functions').toggle_diagnostics()<CR>", "Toggle diagnostics ON/OFF")
nmap("<leader>or", "<CMD>OpenCodeRepo<CR>", "Open Code Repo")
nmap("<leader>ox", "<CMD>!chmod +x %<CR>", "Chmod +x")

-- Navigation Between Windows
nmap("<C-h>", "<C-w>h<CR>", "Go Left")
nmap("<C-j>", "<C-w>j<CR>", "Go Down")
nmap("<C-k>", "<C-w>k<CR>", "Go Up")
nmap("<C-l>", "<C-w>l<CR>", "Go Right")
nmap("<C-q>", "<C-w>q<CR>", "Close Slipt")

-- Resize Window
nmap("<M-S-k>", "<CMD>resize -2<CR>")
nmap("<M-S-j>", "<CMD>resize +2<CR>")
nmap("<M-S-l>", "<CMD>vertical resize -2<CR>")
nmap("<M-S-h>", "<CMD>vertical resize +2<CR>")

-- Navigate buffers
nmap("<S-l>", "<CMD>bnext<CR>", "Buffer Previous")
nmap("<S-h>", "<CMD>bprevious<CR>", "Buffer Previous")
nmap("<S-d>", "<CMD>bdelete<CR>", "Buffer Delete")

nmap("<leader>bn", "<CMD>bnext<CR>", "Buffer Next")
nmap("<leader>bp", "<CMD>bprevious<CR>", "Buffer Previous")
nmap("<leader>bd", "<CMD>bdelete<CR>", "Buffer Delete")

nmap("]b", "<CMD>bnext<CR>", "Buffer Previous")
nmap("[b", "<CMD>bprevious<CR>", "Buffer Previous")

-- Move current line / block with Alt-j/k a la vscode.
nmap("<A-j>", "<CMD>move .+1<CR>==")
nmap("<A-k>", "<CMD>move .-2<CR>==")

nmap("<C-d>", "<C-d>zz")
nmap("<C-u>", "<C-u>zz")

-- Insert --

-- ESC more acessible
imap("jk", "<ESC>")

-- Move current line / block with Alt-j/k a la vscode.
imap("<A-j>", "<Esc><CMD>move .+1<CR>==gi")
imap("<A-k>", "<Esc><CMD>move .-2<CR>==gi")

-- Visual --

-- Indent
vmap("<", "<gv")
vmap(">", ">gv")

-- Moves selected

-- Move current line / block with Alt-j/k ala vscode.
xmap("<A-j>", ":m '>+1<CR>gv=gv")
xmap("<A-k>", ":m '<-2<CR>gv=gv")
