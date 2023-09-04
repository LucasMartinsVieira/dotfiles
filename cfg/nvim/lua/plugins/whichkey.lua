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
      ["<leader>f"] = { name = "+Find" },
      ["<leader>a"] = { name = "+Ai" },
      ["<leader>g"] = { name = "+Git" },
      ["<leader>t"] = { name = "+Terminal" },
      ["<leader>x"] = { name = "+Diagnostics" },
      ["<leader>l"] = { name = "+Lsp" },
      ["<leader>o"] = { name = "+Options/Open" },
      ["<leader>b"] = { name = "+Buffers" },
      ["<leader>z"] = { name = "+Focus" },
      ["<leader>p"] = { name = "+Plugins" },
      ["<leader>s"] = { name = "+Session" },
      ["<leader>h"] = { name = "+Harpoon" },
      ["<leader>S"] = { name = "Substitute Text" },
    }

    wk.register(keymaps)
  end,
}
