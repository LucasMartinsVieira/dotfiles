return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    -- adapters
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
    "rouge8/neotest-rust",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),

        require("neotest-vitest")({}),
        require("neotest-rust")({
          args = { "--no-capture" },
        }),
      },
    })
  end,
}
