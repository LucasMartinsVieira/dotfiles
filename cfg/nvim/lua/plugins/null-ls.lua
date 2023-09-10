return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    keys = {
      { "<leader>lf", "<CMD>lua vim.lsp.buf.format()<CR>", desc = "Format" },
    },
    lazy = true,
    config = function()
      local null_ls = require("null-ls")
      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      local code_actions = null_ls.builtins.code_actions
      null_ls.setup({
        debug = false,
        sources = {
          -- typescript.nvim
          -- require("typescript.extensions.null-ls.code-actions"),

          -- Diagnostics
          diagnostics.shellcheck,
          -- diagnostics.eslint,

          -- Formatting
          formatting.prettier,
          formatting.stylua,
          formatting.rustfmt,
          formatting.shfmt,

          -- Code Actions
          -- code_actions.eslint_d.with({
          --   filetypes = {
          --     "javascript",
          --     "javascriptreact",
          --     "typescript",
          --     "typescriptreact",
          --   },
          -- }),
        },
      })
    end,
  },
  -- {
  --   "jay-babu/mason-null-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     "jose-elias-alvarez/null-ls.nvim",
  --   },
  --   config = function()
  --     local servers = {
  --       "stylua",
  --       "eslint_d",
  --       "rustfmt",
  --       "shfmt",
  --       "prettier_d",
  --     }
  --
  --     require("mason-null-ls").setup({
  --       ensure_installed = servers,
  --       automatic_installation = true,
  --     })
  --   end,
  -- },
}
