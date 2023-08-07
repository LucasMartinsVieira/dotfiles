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
nmap("<leader>w", "<CMD>w<CR>", "Write")
nmap("<leader>q", "<CMD>lua require('user.functions').smart_quit()<CR>", "Quit")
-- nmap("<leader>h", "<CMD>split<CR>", "Split")
nmap("<leader>v", "<CMD>vsplit<CR>", "Vsplit")
nmap("<leader>/", "<CMD>noh<CR>", "")
keymap(
  "n",
  "<leader>S",
  ":%s ///gc<Left><Left><Left><Left>",
  { noremap = true, silent = false }
)

-- Config Keys
-- nmap("<leader>ci", "<CMD>e ~/.config/nvim/init.lua<CR>", "[C]onfig init.lua file")
-- nmap("<leader>co", "<CMD>e ~/.config/nvim/lua/user/options.lua<CR>", "[C]onfig options.lua file")
-- nmap("<leader>cm", "<CMD>e ~/.config/nvim/lua/user/maps.lua<CR>", "[C]onfig maps.lua file")
-- nmap("<leader>cc", "<CMD>e ~/.config/nvim/lua/user/colorscheme.lua<CR>", "[C]onfig colorscheme.lua file")

-- Plugin keys
nmap("<leader>pp", "<CMD>Lazy<CR>", "Plugin")
nmap("<leader>ps", "<CMD>Lazy sync<CR>", "Plugin Sync")
nmap("<leader>pc", "<CMD>Lazy clean<CR>", "Plugin Clean")
nmap("<leader>pl", "<CMD>Lazy log<CR>", "Plugin Log")

-- Options/Open
nmap(
  "<leader>on",
  "<CMD>lua require('user.functions').toggle_option('relativenumber')<CR>",
  "Relative Numbers"
)
nmap(
  "<leader>os",
  "<CMD>lua require('user.functions').toggle_option('spell')<CR>",
  "Spell"
)
nmap(
  "<leader>oc",
  "<CMD>lua require('user.functions').toggle_option('cursorline')<CR>",
  "Cursor Line"
)
nmap("<leader>or", "<CMD>OpenCodeRepo<CR>", "Open Code Repo")

-- Navegação entre janelas
nmap("<C-h>", "<C-w>h<CR>", "Go Left")
nmap("<C-j>", "<C-w>j<CR>", "Go Down")
nmap("<C-k>", "<C-w>k<CR>", "Go Up")
nmap("<C-l>", "<C-w>l<CR>", "Go Right")
nmap("<C-q>", "<C-w>q<CR>", "Close Slipt")

-- Redimensionar janela
nmap("<M-k>", "<CMD>resize -2<CR>")
nmap("<M-j>", "<CMD>resize +2<CR>")
nmap("<M-l>", "<CMD>vertical resize -2<CR>")
nmap("<M-h>", "<CMD>vertical resize +2<CR>")

-- Navegar arquivos (buffers)
nmap("<S-l>", "<CMD>bnext<CR>", "Buffer Previous")
nmap("<S-h>", "<CMD>bprevious<CR>", "Buffer Previous")
nmap("<S-d>", "<CMD>bdelete<CR>", "Buffer Delete")

nmap("<leader>bn", "<CMD>bnext<CR>", "Buffer Next")
nmap("<leader>bp", "<CMD>bprevious<CR>", "Buffer Previous")
nmap("<leader>bd", "<CMD>bdelete<CR>", "Buffer Delete")

nmap("]b", "<CMD>bnext<CR>", "Buffer Previous")
nmap("[b", "<CMD>bprevious<CR>", "Buffer Previous")

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
