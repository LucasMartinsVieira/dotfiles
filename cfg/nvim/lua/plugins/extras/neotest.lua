return {
  "nvim-neotest/neotest",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    -- adapters
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
    "rouge8/neotest-rust",
  },
  keys = {
    { "<leader>tt", "<CMD>lua require('neotest').run.run()<CR>", desc = "Test Nearest" },
    { "<leader>tf", "<CMD>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Test File" },
    { "<leader>td", "<CMD>lua require('neotest').run.run(strategy = 'dap')<CR>", desc = "Debug Test" },
    { "<leader>ta", "<CMD>lua require('neotest').run.attach()<CR>", desc = "Attach Test" },
    { "<leader>ts", "<CMD>lua require('neotest').run.stop()<CR>", desc = "Test Stop" },
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
