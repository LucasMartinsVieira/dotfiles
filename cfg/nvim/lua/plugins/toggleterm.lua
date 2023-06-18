return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm" },
  keys = {
    {
      "<c-/>",
      "<CMD>ToggleTerm<CR>",
      desc = "Terminal",
    },
    {
      "<space>tt",
      "<CMD>ToggleTerm direction=horizontal<CR>",
      desc = "Terminal Horizontal",
    },
    {
      "<space>tf",
      "<CMD>ToggleTerm direction=float<CR>",
      desc = "Terminal Float",
    },
    {
      "<space>tv",
      "<CMD>ToggleTerm size=40 direction=vertical<CR>",
      desc = "Terminal Vertical",
    },
    {
      "<space>tl",
      "<cmd>lua require 'user.functions'.lua_terminal()<cr>",
      desc = "Lua",
    },
    {
      "<space>tn",
      "<cmd>lua require 'user.functions'.node_terminal()<cr>",
      desc = "Node",
    },
    {
      "<space>td",
      "<cmd>lua require 'user.functions'.deno_terminal()<cr>",
      desc = "Deno",
    },
    {
      "<space>tb",
      "<cmd>lua require 'user.functions'.btop_terminal()<cr>",
      desc = "Btop",
    },
    {
      "<space>gg",
      "<cmd>lua require 'user.functions'.lazygit_toggle()<cr>",
      desc = "LazyGit",
    },
  },
  config = function()
    require("toggleterm").setup({
      size = 16,
      open_mapping = [[<c-/>]],
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
