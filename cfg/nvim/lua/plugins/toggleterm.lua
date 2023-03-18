-- local status_ok, toggleterm = pcall(require, "toggleterm")
-- if not status_ok then
-- 	return
-- end

return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm" },
  keys = {
    { "<C-t>",     "<CMD>ToggleTerm<CR>",                                     desc = "Terminal" },
    { "<space>tt", "<CMD>ToggleTerm<CR>",                                     desc = "Terminal Horizontal" },
    { "<space>tf", "<CMD>ToggleTerm direction=float<CR>",                     desc = "Terminal Float" },
    { "<space>tv", "<CMD>ToggleTerm size=40 direction=vertical<CR>",          desc = "Terminal Vertical" },
    { "<space>tl", "<cmd>lua require 'user.functions'.lua_terminal()<cr>",    desc = "Lua" },
    { "<space>tn", "<cmd>lua require 'user.functions'.node_terminal()<cr>",   desc = "Node" },
    { "<space>td", "<cmd>lua require 'user.functions'.deno_terminal()<cr>",   desc = "Deno" },
    { "<space>tp", "<cmd>lua require 'user.functions'.python_terminal()<cr>", desc = "Python" },
    { "<space>th", "<cmd>lua require 'user.functions'.htop_terminal()<cr>",   desc = "Htop" },
    { "<space>gg", "<cmd>lua require 'user.functions'.lazygit_toggle()<cr>",  desc = "LazyGit" },
  },
  config = function()
    require("toggleterm").setup({
      size = 11,
      open_mapping = [[<c-t>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })
  end,
}
