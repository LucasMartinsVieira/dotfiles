return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm" },
  -- stylua: ignore
  keys = {
    { "<c-t>",      "<CMD>ToggleTerm<CR>",                                    desc = "Terminal",},
    { "<A-1>", "<CMD>ToggleTerm direction=float<CR>",                         desc = "Terminal Float",},
    { "<A-2>", "<CMD>ToggleTerm direction=horizontal<CR>",                    desc = "Terminal Horizontal",},
    { "<A-3>", "<CMD>ToggleTerm size=40 direction=vertical<CR>",              desc = "Terminal Vertical",},
    { "<leader>gg", "<cmd>lua require 'user.functions'.lazygit_toggle()<cr>", desc = "LazyGit",},
  },
  config = function()
    require("toggleterm").setup({
      size = 16,
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
