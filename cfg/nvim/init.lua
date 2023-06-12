local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')

require("user.options")
require("user.maps")
require("user.colorscheme")
require("user.winbar")

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim smoothie
vim.cmd[[
nnoremap <C-j> <cmd>call smoothie#do("\<C-D>") <CR>
vnoremap <C-j> <cmd>call smoothie#do("\<C-D>") <CR>

nnoremap <C-k> <cmd>call smoothie#do("\<C-U>") <CR>
vnoremap <C-k> <cmd>call smoothie#do("\<C-U>") <CR>
]]

vim.g.smoothie_update_interval=20
-- g:smoothie_speed_constant_factor: (default: 10) This value controls constant term of the velocity curve. Increasing this boosts primarily cursor speed at the end of animation.
vim.g.smoothie_speed_constant_factor=15
-- g:smoothie_speed_linear_factor: (default: 10) This value controls linear term of the velocity curve. Increasing this boosts primarily cursor speed at the beginning of animation.
vim.g.smoothie_speed_linear_factor=15
