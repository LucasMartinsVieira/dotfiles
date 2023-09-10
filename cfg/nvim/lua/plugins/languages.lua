return {
  -- Rust
  {
    "saecki/crates.nvim",
    requires = { 'nvim-lua/plenary.nvim' },
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
    lazy = true,
  },
  -- Json
  {
    "b0o/schemastore.nvim",
    enabled = false,
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

  -- CSS
  -- {
  --   "roobert/tailwindcss-colorizer-cmp.nvim",
  --   -- optionally, override the default options:
  --   config = function()
  --     require("tailwindcss-colorizer-cmp").setup({
  --       color_square_width = 2,
  --     })
  --   end,
  -- },
}
