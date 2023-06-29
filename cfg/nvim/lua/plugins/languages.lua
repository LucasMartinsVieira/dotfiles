return {
  -- Rust
  {
    "saecki/crates.nvim",
    tag = "v0.3.0",
    lazy = true,
    keys = {
      { "<leader>cp", "<CMD>lua require('crates').show_popup()<CR>",              desc = "Show popup" },
      { "<leader>cr", "<CMD>lua require('crates').reload()<CR>",                  desc = "Reload" },
      { "<leader>cv", "<CMD>lua require('crates').show_versions_popup()<CR>",     desc = "Show Versions" },
      { "<leader>cf", "<CMD>lua require('crates').show_features_popup()<CR>",     desc = "Show Features" },
      { "<leader>cd", "<CMD>lua require('crates').show_dependencies_popup()<CR>", desc = "Show Dependencies Popup" },
      { "<leader>cu", "<CMD>lua require('crates').update_crate()<CR>",            desc = "Update Crate" },
      { "<leader>cU", "<CMD>lua require('crates').update_all_crates()<CR>",       desc = "Update All Crates" },
      { "<leader>ca", "<CMD>lua require('crates').upgrade_crate<CR>",             desc = "Upgrade Crate" },
      { "<leader>cA", "<CMD>lua require('crates').upgrade_all_crates(true)<CR>",  desc = "Upgrade All Crates" },
      { "<leader>ch", "<CMD>lua require('crates').open_homepage()<CR>",           desc = "Open Homepage" },
      { "<leader>cR", "<CMD>lua require('crates').open_repository()<CR>",         desc = "Open Repository" },
      { "<leader>cD", "<CMD>lua require('crates').open_documentation()<CR>",      desc = "Open Documentation" },
      { "<leader>cC", "<CMD>lua require('crates').open_crates_io()<CR>",          desc = "Open Crate.io" },
    },
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
    keys = {
      { "<leader>ji", "<CMD>TypescriptAddMissingImports<CR>",    desc = "Add Missing Imports" },
      { "<leader>jo", "<CMD>TypescriptOrganizeImports<CR>",      desc = "Organize Imports" },
      { "<leader>ju", "<CMD>TypescriptRemoveUnused<CR>",         desc = "Remove Unused" },
      { "<leader>jr", "<CMD>TypescriptRenameFile<CR>",           desc = "Rename File" },
      { "<leader>jf", "<CMD>TypescriptFixAll<CR>",               desc = "Fix All" },
      { "<leader>jg", "<CMD>TypescriptGoToSourceDefinition<CR>", desc = "Go To Source Definition" },
    },
  },
  -- Json
  {
    "b0o/schemastore.nvim",
    lazy = true
  },
  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
  },
}
