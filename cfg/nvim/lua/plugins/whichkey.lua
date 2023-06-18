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
      ["<space>f"] = { name = "+Find" },
      ["<space>a"] = { name = "+Ai" },
      ["<space>g"] = { name = "+Git" },
      ["<space>t"] = { name = "+Terminal" },
      ["<space>x"] = { name = "+Diagnostics" },
      ["<space>l"] = { name = "+Lsp" },
      ["<space>c"] = { name = "+Crates" },
      ["<space>r"] = { name = "+Rust" },
      ["<space>o"] = { name = "+Options" },
      ["<space>b"] = { name = "+Buffers" },
      ["<space>j"] = { name = "+JavaScript/Typescript" },
      ["<space>s"] = { name = "Substitute Text" },
    }

    wk.register(keymaps)
  end,
}
