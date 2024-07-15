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

    wk.add({
      mode = { "n", "v" },
      { "]", group = "+next" },
      { "[", group = "+prev" },
      { "<leader>a", group = "Tabs" },
      { "<leader>b", group = "Buffers" },
      { "<leader>e", group = "Explorer" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "Lsp" },
      { "<leader>o", group = "Options/Open" },
      { "<leader>p", group = "Plugins" },
      { "<leader>s", group = "Second Brain" },
      { "<leader>t", group = "Test" },
      { "<leader>x", group = "Diagnostics" },
      { "<leader>z", group = "Focus" },
      { "<leader>w", group = "Workspace" },
    })
  end,
}
