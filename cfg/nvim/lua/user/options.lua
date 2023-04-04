local options = {
  backup = false,
  spell = false,
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
  expandtab = true,
  termguicolors = true,
  number = true,
  relativenumber = true,
  updatetime = 300,
  background = "dark",
  smartindent = true,
  smartcase = true,
  cursorline = true,
  cmdheight = 0,
  ignorecase = true,
  showmode = false,
  undofile = true,
  timeoutlen = 1000,
  clipboard = "unnamedplus",
  swapfile = false,
  showtabline = 0,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
