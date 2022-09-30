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
nmap("<space>w", ":w<CR>")
nmap("<space>q", ":q<CR>")
nmap("<space>e", ":NvimTreeToggle<CR>")
nmap("<space>p", ":Format<CR>")
nmap("<space>z", ":ZenMode<CR>")
keymap('n', '<space>s', ":%s ///gc<Left><Left><Left><Left>", {noremap = true, silent = false})

-- Config Keys
nmap("<space>ci", ":e ~/.config/nvim/init.lua<CR>")
nmap("<space>co", ":e ~/.config/nvim/lua/user/options.lua<CR>")
nmap("<space>cp", ":e ~/.config/nvim/lua/user/plugins.lua<CR>")
nmap("<space>cm", ":e ~/.config/nvim/lua/user/maps.lua<CR>")

-- Vim Wiki
nmap("<space>m", ":VimwikiIndex<CR>")

-- Terminal 
nmap("<space>tt", ":ToggleTerm<CR>")
nmap("<space>tv", ":ToggleTerm size=60 direction=vertical<CR>")
nmap("<space>th", ":ToggleTerm direction=horizontal<CR>")
nmap("<space>tf", ":ToggleTerm direction=float<CR>")

-- Navegação entre janelas
nmap("<C-h>", "<C-w>h<CR>")
nmap("<C-j>", "<C-w>j<CR>")
nmap("<C-k>", "<C-w>k<CR>")
nmap("<C-l>", "<C-w>l<CR>")

-- Redimensionar janela
nmap("<C-Up>", ":resize -2<CR>")
nmap("<C-Down>", ":resize +2<CR>")
nmap("<C-Left>", ":vertical resize +2<CR>")
nmap("<C-Right>", ":vertical resize -2<CR>")

-- Navegar arquivos (buffers)
nmap("<S-l>", ":bnext<CR>")
nmap("<S-h>", ":bprevious<CR>")
nmap("<S-d>", ":bdelete<CR>")

nmap("<space>bn", ":bnext<CR>")
nmap("<space>bp", ":bprevious<CR>")
nmap("<space>bx", ":bdelete<CR>")
nmap("<space>bf", ":Telescope buffers<CR>")

-- Telescope
nmap("<space>ff", ":FZF<CR>")
nmap("<space>fe", ":ene!<CR>")
nmap("<space>fw", ":Telescope live_grep<CR>")
nmap("<space>fr", ":Telescope oldfiles<CR>")
nmap("<space>fp", ":Telescope projects<CR>")
nmap("<space>ft", ":Telescope live_grep<CR>")

-- Moves selected
nmap("<A-j>", ":m +2<CR>gv")
nmap("<A-k>", ":m -2<CR>gv")

-- Trouble
nmap("<space>x", ":TroubleToggle<CR>")

-- Insert --

-- ESC more acessible
imap("jk", "<ESC>")
imap("kj", "<ESC>")

-- Visual --

-- Indent
vmap("<", "<gv")
vmap(">", ">gv")

-- Moves selected 
vmap("<A-j>", ":m +2<CR>gv")
vmap("<A-k>", ":m -2<CR>gv")
