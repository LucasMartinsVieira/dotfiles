return {
  "jose-elias-alvarez/null-ls.nvim",
  keys = {
    { "<space>lf", "<CMD>lua vim.lsp.buf.format()<CR>", desc = "Format" },
  },

  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    null_ls.setup({
      debug = false,
      sources = {
        formatting.prettier.with {
          extra_filetypes = { "toml", "solidity" },
          extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        },
        formatting.black.with { extra_args = { "--fast" } },
        formatting.stylua,
        formatting.rustfmt,
        formatting.shfmt,
        diagnostics.shellcheck,
      },
    })

    local unwrap = {
      method = null_ls.methods.DIAGNOSTICS,
      filetypes = { "rust" },
      generator = {
        fn = function(params)
          local diagnostics = {}
          -- sources have access to a params object
          -- containing info about the current file and editor state
          for i, line in ipairs(params.content) do
            local col, end_col = line:find "unwrap()"
            if col and end_col then
              -- null-ls fills in undefined positions
              -- and converts source diagnostics into the required format
              table.insert(diagnostics, {
                row = i,
                col = col,
                end_col = end_col,
                source = "unwrap",
                message = "hey " .. os.getenv("USER") .. ", don't forget to handle this",
                severity = 2,
              })
            end
          end
          return diagnostics
        end
      }
    }

    null_ls.register(unwrap)
  end
}
