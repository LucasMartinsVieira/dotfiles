return {
  -- Rust
  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    tag = "v0.3.0",
    lazy = true,
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
    -- Typescript/JavaScript
    "jose-elias-alvarez/typescript.nvim",
    enabled = false,
    lazy = true,
  },
  -- Json
  {
    "b0o/schemastore.nvim",
    enabled = true,
    lazy = true,
  },
  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    enabled = false,
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
  },
}
