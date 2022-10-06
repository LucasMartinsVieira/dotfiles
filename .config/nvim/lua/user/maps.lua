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
nmap("<space>e", "<CMD>NvimTreeToggle<CR>")
nmap("<space>p", "<CMD>Format<CR>")
nmap("<space>z", "<CMD>ZenMode<CR>")
nmap("<space>c", "<CMD>ColorizerToggle<CR>")
nmap("<space>n", "<CMD>ene!<CR>")
keymap("n", "<space>s", "<CMD>%s ///gc<Left><Left><Left><Left>", { noremap = true, silent = false })

-- Config Keys
nmap("<space>ci", "<CMD>e ~/.config/nvim/init.lua<CR>")
nmap("<space>co", "<CMD>e ~/.config/nvim/lua/user/options.lua<CR>")
nmap("<space>cp", "<CMD>e ~/.config/nvim/lua/user/plugins.lua<CR>")
nmap("<space>cm", "<CMD>e ~/.config/nvim/lua/user/maps.lua<CR>")
nmap("<space>cc", "<CMD>e ~/.config/nvim/lua/user/colorscheme.lua<CR>")

-- Vim Wiki
nmap("<space>m", "<CMD>VimwikiIndex<CR>")

-- Terminal
nmap("<M-h>", "<CMD>ToggleTerm direction=horizontal<CR>")
nmap("<M-v>", "<CMD>ToggleTerm size=40 direction=vertical<CR>")
nmap("<M-f>", "<CMD>ToggleTerm direction=float<CR>")

-- Navegação entre janelas
nmap("<C-h>", "<C-w>h<CR>")
nmap("<C-j>", "<C-w>j<CR>")
nmap("<C-k>", "<C-w>k<CR>")
nmap("<C-l>", "<C-w>l<CR>")

-- Redimensionar janela
nmap("<C-w>", "<CMD>resize -2<CR>")
nmap("<C-s>", "<CMD>resize +2<CR>")
nmap("<C-a>", "<CMD>vertical resize -2<CR>")
nmap("<C-d>", "<CMD>vertical resize +2<CR>")

-- Navegar arquivos (buffers)
nmap("<S-l>", "<CMD>bnext<CR>")
nmap("<S-h>", "<CMD>bprevious<CR>")
nmap("<S-d>", "<CMD>bdelete<CR>")
keymap("n", "<space>b", ":b ", { noremap = true, silent = false })

-- Telescope
nmap("<space>ff", "<CMD>Telescope find_files<CR>")
nmap("<space>fr", "<CMD>Telescope oldfiles<CR>")
nmap("<space>fw", "<CMD>Telescope live_grep<CR>")
nmap("<space>fb", "<CMD>Telescope buffers<CR>")
nmap("<space>fp", "<CMD>Telescope projects<CR>")
nmap("<space>fc", "<CMD>Telescope colorscheme<CR>")

nmap("<space>fgs", "<CMD>Telescope git_status<CR>")
nmap("<space>fgc", "<CMD>Telescope git_commits<CR>")
nmap("<space>fgf", "<CMD>Telescope git_files<CR>")
nmap("<space>fgb", "<CMD>Telescope git_branches<CR>")

-- Moves selected
nmap("<A-j>", "<CMD>m +2<CR>gv")
nmap("<A-k>", "<CMD>m -2<CR>gv")

-- Trouble
nmap("<space>x", "<CMD>TroubleToggle<CR>")

-- Insert --

-- ESC more acessible
imap("jk", "<ESC>")
imap("kj", "<ESC>")

-- Visual --

-- Indent
vmap("<", "<gv")
vmap(">", ">gv")

-- Moves selected
vmap("<A-j>", "<CMD>m +2<CR>gv")
vmap("<A-k>", "<CMD>m -2<CR>gv")
