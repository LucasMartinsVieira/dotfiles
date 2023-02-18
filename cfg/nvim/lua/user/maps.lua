local opts = { noremap = true, silent = true }

local function nmap(key, map)
	vim.api.nvim_set_keymap("n", key, map, opts)
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
nmap("<space>w", "<CMD>w<CR>")
nmap("<space>q", "<CMD>q<CR>")
keymap("n", "<space>s", ":%s ///gc<Left><Left><Left><Left>", { noremap = true, silent = false })

-- Config Keys
nmap("<space>ci", "<CMD>e ~/.config/nvim/init.lua<CR>")
nmap("<space>co", "<CMD>e ~/.config/nvim/lua/user/options.lua<CR>")
nmap("<space>cp", "<CMD>e ~/.config/nvim/lua/user/plugins.lua<CR>")
nmap("<space>cm", "<CMD>e ~/.config/nvim/lua/user/maps.lua<CR>")
nmap("<space>cc", "<CMD>e ~/.config/nvim/lua/user/colorscheme.lua<CR>")

-- Terminal
nmap("<M-1>", "<CMD>ToggleTerm direction=horizontal<CR>")
nmap("<M-2>", "<CMD>ToggleTerm size=40 direction=vertical<CR>")
nmap("<M-3>", "<CMD>ToggleTerm direction=float<CR>")

-- Telescope
-- nmap("<space>ff", "<CMD>Telescope find_files<CR>")
-- nmap("<space>fb", "<CMD>Telescope buffers<CR>")
-- nmap("<space>fm", "<CMD>Telescope man_pages<CR>")
-- nmap("<space>fg", "<CMD>Telescope live_grep<CR>")
-- nmap("<space>fc", "<CMD>Telescope colorscheme<CR>")
-- nmap("<space>fk", "<CMD>Telescope keymaps<CR>")

-- Lsp
nmap("<space>lm", "<CMD>Mason<CR>")
nmap("<space>lf", "<CMD>Format<CR>")

-- Trouble
-- nmap("<space>xx", "<CMD>TroubleToggle document_diagnostics<CR>")
-- nmap("<space>xX", "<CMD>TroubleToggle workspace_diagnostics<CR>")
-- nmap("<space>xL", "<CMD>TroubleToggle loclist<CR>")
-- nmap("<space>xQ", "<CMD>TroubleToggle quickfix<CR>")

-- Navegação entre janelas
nmap("<C-h>", "<C-w>h<CR>")
nmap("<C-j>", "<C-w>j<CR>")
nmap("<C-k>", "<C-w>k<CR>")
nmap("<C-l>", "<C-w>l<CR>")

-- Redimensionar janela
nmap("<M-k>", "<CMD>resize -2<CR>")
nmap("<M-j>", "<CMD>resize +2<CR>")
nmap("<M-l>", "<CMD>vertical resize -2<CR>")
nmap("<M-h>", "<CMD>vertical resize +2<CR>")

-- Navegar arquivos (buffers)
nmap("<S-l>", "<CMD>bnext<CR>")
nmap("<S-h>", "<CMD>bprevious<CR>")
nmap("<S-d>", "<CMD>bdelete<CR>")

-- Insert --

-- ESC more acessible
imap("jk", "<ESC>")

-- Visual --

-- Indent
vmap("<", "<gv")
vmap(">", ">gv")

-- Moves selected
vmap("<A-j>", "<CMD>m +2<CR>gv")
vmap("<A-k>", "<CMD>m -2<CR>gv")
