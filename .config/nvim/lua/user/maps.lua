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

  -- Normal --
  -- Salvar/Sair arquivo
nmap("<space>w", ":w<CR>")
nmap("<space>q", ":q<CR>")

-- Vim Wiki
nmap("<space>m", ":VimwikiIndex<CR>")

-- Formatar arquivo
nmap("<space>p", ":Format<CR>")

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
nmap("<S-x>", ":bdelete<CR>")
nmap("<space>bn", ":bnext<CR>")
nmap("<space>bp", ":bprevious<CR>")
nmap("<space>bx", ":bdelete<CR>")


-- Telescope
nmap("<space>ff", ":FZF<CR>")
nmap("<space>fb", ":Telescope buffers<CR>")
nmap("<space>ft", ":Telescope live_grep<CR>")

-- NvimTree
nmap("<space>e", ":NvimTreeToggle<CR>")

-- Trouble
nmap("<space>t", ":TroubleToggle<CR>")

-- Insert --
-- Escape mais acessivel
imap("jk", "<ESC>")

-- Visual --
-- Indenta
vmap("<", "<gv")
vmap(">", ">gv")

-- Move selecionadoa
vmap("<A-j>", ":m +2<CR>gv")
vmap("<A-k>", ":m -2<CR>gv")
