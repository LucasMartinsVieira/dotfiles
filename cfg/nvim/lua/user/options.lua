vim.opt.backup = false -- Make a backup before overwriting a file. (annoying)
vim.opt.spell = false -- When on spell checking will be done.
vim.opt.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for.
vim.opt.shiftwidth = 2 --  Number of spaces to use for each step of (auto)indent.
vim.opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations.
vim.opt.expandtab = true -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
vim.opt.termguicolors = true -- Enables 24-bit RGB color in the TUI.
vim.opt.number = true -- Print the line number in front of each line.
vim.opt.relativenumber = true -- Show the line number relative to the line with the cursor in front of each line.
vim.opt.updatetime = 300 -- If this many milliseconds nothing is typed the swap file will be written to disk.
vim.opt.background = "dark" -- When set to "dark" or "light", adjusts the default color groups for that background type.
vim.opt.smartindent = true -- Do smart autoindenting when starting a new line.
vim.opt.smartcase = true -- Override the 'ignorecase' option if the search pattern contains upper case characters.
vim.opt.cursorline = true -- Highlight the text line of the cursor with CursorLine hl-CursorLine.
vim.opt.cmdheight = 1 -- Number of screen lines to use for the command-line.
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.showmode = false -- If in Insert, Replace or Visual mode put a message on the last line.
vim.opt.incsearch = true -- While typing a search command, show where the pattern, as it was typed so far, matches.
vim.opt.undofile = true -- Enable persist undo
vim.opt.undodir = vim.fn.stdpath("cache") .. "undodir" -- List of directory names for undo files, separated with commas.
vim.opt.timeoutlen = 1000 -- Time in milliseconds to wait for a mapped sequence to complete.
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.swapfile = false -- creates a swapfile
vim.opt.showtabline = 1 -- always show tabs
vim.opt.mousemoveevent = true -- When on, mouse move events are delivered to the input queue and are available for mapping.
vim.opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.conceallevel = 1

require("user.functions").get_winbar_setup()
-- vim.g.netrw_banner = 0
-- vim.g.netrw_mouse = 2
-- vim.g.loaded_netrwPlugin = 1
