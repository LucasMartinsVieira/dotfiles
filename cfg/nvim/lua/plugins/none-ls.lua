---@diagnostic disable: unused-local
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  enabled = false,
  -- lazy = true,
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions
    null_ls.setup({
      debug = false,
      sources = {

        -- Formatting
        -- formatting.prettierd,
        -- formatting.biome.with({
        --   args = {
        --     "fix",
        --     "--apply-unsafe",
        --     "--formatter-enabled=true",
        --     "--organize-imports-enabled=true",
        --     "--skip-errors",
        --     "$FILENAME",
        --   },
        -- }),
        -- formatting.stylua,
        -- formatting.rustfmt,
        -- formatting.shfmt,
        -- formatting.nixpkgs_fmt,

        -- Diagnostics
        -- diagnostics.shellcheck,
        -- diagnostics.eslint,

        -- Code Actions
        -- code_actions.eslint_d,
        -- code_actions.statix,
      },
    })
  end,
}
