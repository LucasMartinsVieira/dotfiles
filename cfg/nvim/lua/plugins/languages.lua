return {
  -- Rust
  {
    "saecki/crates.nvim",
    tag = "v0.3.0",
    keys = {
      { "<space>cp", "<CMD>lua require('crates').show_popup()<CR>",              desc = "Show popup" },
      { "<space>cr", "<CMD>lua require('crates').reload()<CR>",                  desc = "Reload" },
      { "<space>cv", "<CMD>lua require('crates').show_versions_popup()<CR>",     desc = "Show Versions" },
      { "<space>cf", "<CMD>lua require('crates').show_features_popup()<CR>",     desc = "Show Features" },
      { "<space>cd", "<CMD>lua require('crates').show_dependencies_popup()<CR>", desc = "Show Dependencies Popup" },
      { "<space>cu", "<CMD>lua require('crates').update_crate()<CR>",            desc = "Update Crate" },
      { "<space>cU", "<CMD>lua require('crates').update_all_crates()<CR>",       desc = "Update All Crates" },
      { "<space>ca", "<CMD>lua require('crates').upgrade_crate<CR>",             desc = "Upgrade Crate" },
      { "<space>cA", "<CMD>lua require('crates').upgrade_all_crates(true)<CR>",  desc = "Upgrade All Crates" },
      { "<space>ch", "<CMD>lua require('crates').open_homepage()<CR>",           desc = "Open Homepage" },
      { "<space>cR", "<CMD>lua require('crates').open_repository()<CR>",         desc = "Open Repository" },
      { "<space>cD", "<CMD>lua require('crates').open_documentation()<CR>",      desc = "Open Documentation" },
      { "<space>cC", "<CMD>lua require('crates').open_crates_io()<CR>",          desc = "Open Crate.io" },
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
    keys = {
      { "<space>ji", "<CMD>TypescriptAddMissingImports<CR>",    desc = "Add Missing Imports" },
      { "<space>jo", "<CMD>TypescriptOrganizeImports<CR>",      desc = "Organize Imports" },
      { "<space>ju", "<CMD>TypescriptRemoveUnused<CR>",         desc = "Remove Unused" },
      { "<space>jr", "<CMD>TypescriptRenameFile<CR>",           desc = "Rename File" },
      { "<space>jf", "<CMD>TypescriptFixAll<CR>",               desc = "Fix All" },
      { "<space>jg", "<CMD>TypescriptGoToSourceDefinition<CR>", desc = "Go To Source Definition" },
    },
  },
  -- Json
  {
    "b0o/schemastore.nvim"
  }
}
