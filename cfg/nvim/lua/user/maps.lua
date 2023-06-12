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

local keymap = vim.api.nvim_set_keymap

-- Normal --

-- Basics
nmap("<space>w", "<CMD>wa<CR>", "Write")
nmap("<space>q", "<CMD>lua require('user.functions').smart_quit()<CR>", "Quit")
nmap("<space>h", "<CMD>split<CR>", "Split")
nmap("<space>v", "<CMD>vsplit<CR>", "Vsplit")
nmap("<space>/", "<CMD>noh<CR>", "")
keymap("n", "<space>s", ":%s ///gc<Left><Left><Left><Left>", { noremap = true, silent = false })

-- Config Keys
-- nmap("<space>ci", "<CMD>e ~/.config/nvim/init.lua<CR>", "[C]onfig init.lua file")
-- nmap("<space>co", "<CMD>e ~/.config/nvim/lua/user/options.lua<CR>", "[C]onfig options.lua file")
-- nmap("<space>cm", "<CMD>e ~/.config/nvim/lua/user/maps.lua<CR>", "[C]onfig maps.lua file")
-- nmap("<space>cc", "<CMD>e ~/.config/nvim/lua/user/colorscheme.lua<CR>", "[C]onfig colorscheme.lua file")

-- Options
nmap("<space>or", "<CMD>lua require('user.functions').toggle_option('relativenumber')<CR>", "Relative Numbers")
nmap("<space>os", "<CMD>lua require('user.functions').toggle_option('spell')<CR>", "Spell")
nmap("<space>oc", "<CMD>lua require('user.functions').toggle_option('cursorline')<CR>", "Cursor Line")

-- Navegação entre janelas
nmap("<C-h>", "<C-w>h<CR>", "Go Left")
nmap("<C-j>", "<C-w>j<CR>", "Go Down")
nmap("<C-k>", "<C-w>k<CR>", "Go Up")
nmap("<C-l>", "<C-w>l<CR>", "Go Right")

-- Redimensionar janela
nmap("<M-k>", "<CMD>resize -2<CR>")
nmap("<M-j>", "<CMD>resize +2<CR>")
nmap("<M-l>", "<CMD>vertical resize -2<CR>")
nmap("<M-h>", "<CMD>vertical resize +2<CR>")

-- Navegar arquivos (buffers)
nmap("<S-l>", "<CMD>bnext<CR>", "Buffer Next")
nmap("<S-h>", "<CMD>bprevious<CR>", "Buffer Previous")
nmap("<S-d>", "<CMD>bdelete<CR>", "Buffer Delete")
nmap("<space>bd", "<CMD>bdelete<CR>", "Buffer Delete")

nmap("]b", "<CMD>bnext<CR>", "Buffer Previous")
nmap("[b", "<CMD>bprevious<CR>", "Buffer Previous")

nmap(".b", "<CMD>BufferLineMoveNext<CR>", "Move Buffer Next")
nmap(",b", "<CMD>BufferLineMovePrev<CR>", "Move Buffer Prev")

-- Insert --

-- ESC more acessible
imap("jk", "<ESC>")

-- Visual --

-- Indent
vmap("<", "<gv")
vmap(">", ">gv")

-- Moves selected
vmap("<A-k>", "<CMD>m -2<CR>gv")
vmap("<A-j>", "<CMD>m +2<CR>gv")
