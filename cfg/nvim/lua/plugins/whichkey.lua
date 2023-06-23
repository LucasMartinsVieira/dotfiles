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
      ["<leader>c"] = { name = "+Crates" },
      ["<leader>r"] = { name = "+Rust" },
      ["<leader>o"] = { name = "+Options" },
      ["<leader>b"] = { name = "+Buffers" },
      ["<leader>j"] = { name = "+JavaScript/Typescript" },
      ["<leader>z"] = { name = "+Focus" },
      ["<leader>s"] = { name = "Substitute Text" },
    }

    wk.register(keymaps)
  end,
}
