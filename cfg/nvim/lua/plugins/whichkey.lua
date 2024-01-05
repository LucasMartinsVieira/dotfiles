return {
"folke/which-key.nvim",
event = "VeryLazy",
opts = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
  },
},
config = function(_, opts)
  local wk = require("which-key")
  wk.setup(opts)

  local keymaps = {
    mode = { "n", "v" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["<leader>a"] = { name = "+Ai" },
      ["<leader>b"] = { name = "+Buffers" },
      ["<leader>f"] = { name = "+Find" },
      ["<leader>g"] = { name = "+Git" },
      ["<leader>l"] = { name = "+Lsp" },
      ["<leader>o"] = { name = "+Options/Open" },
      ["<leader>p"] = { name = "+Plugins" },
      ["<leader>s"] = { name = "+Session" },
      ["<leader>S"] = { name = "Substitute Text" },
      ["<leader>t"] = { name = "+Terminal" },
      ["<leader>x"] = { name = "+Diagnostics" },
      ["<leader>z"] = { name = "+Focus" },
    }

    wk.register(keymaps)
  end,
}
