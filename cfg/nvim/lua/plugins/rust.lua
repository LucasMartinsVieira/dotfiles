return {
  {
    "saecki/crates.nvim",
    tag = "stable",
    event = "BufRead Cargo.toml",
    enabled = true,
    config = function()
      require("crates").setup({
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        popup = {
          border = "rounded",
        },
      })
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    enabled = true,
    config = function()
      local lsp_functions = require("user.lsp_functions")
      vim.g.rustaceanvim = {
        tools = {},
        server = {
          on_attach = function(client, bufnr)
            lsp_functions.on_attach(client, bufnr)
          end,

          capabilities = lsp_functions.common_capabilities(),
          default_settings = {
            ["rust_analyzer"] = {
              procMacro = { enable = true },
              cargo = { allFeatures = true },
              check = {
                command = "clippy",
              },
              checkOnSave = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              inlayHints = {
                enabled = true,
                locationLinks = false,
              },
            },
          },
        },
        -- DAP CONFIGURATION
        dap = {},
      }
    end,
  },
}
