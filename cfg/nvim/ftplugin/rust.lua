local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  L = {
    name = "Rust",
    r = { "<CMD>RustLsp runnables<CR>", "Runnables" },
    t = { "<CMD>RustLsp testables<cr>", "Testables" },
    m = { "<CMD>RustLsp expandMacro<CR>", "Expand Macro" },
    C = { "<CMD>RustLsp openCargo<CR>", "Open Cargo" },
    D = { "<CMD>RustLsp externalDocs<CR>", "Open Docs" },
    p = { "<CMD>RustLsp parentModule<CR>", "Parent Module" },
    d = { "<CMD>RustLsp debuggables<CR>", "Debuggables" },
    v = { "<CMD>RustLsp crateGraph<CR>", "View Crate Graph" },
    R = { "<CMD>RustLsp reloadWorkspace<CR>", "Reload Workspace" },

    c = {
      name = "Crates",
      p = { "<CMD>lua require('crates').show_popup()<CR>", "Show popup" },
      r = { "<CMD>lua require('crates').reload()<CR>", "Reload" },
      v = { "<CMD>lua require('crates').show_versions_popup()<CR>", "Show Versions" },
      f = { "<CMD>lua require('crates').show_features_popup()<CR>", "Show Features" },
      d = { "<CMD>lua require('crates').show_dependencies_popup()<CR>", "Show Dependencies Popup" },
      u = { "<CMD>lua require('crates').update_crate()<CR>", "Update Crate" },
      U = { "<CMD>lua require('crates').update_all_crates()<CR>", "Update All Crates" },
      a = { "<CMD>lua require('crates').upgrade_crate<CR>", "Upgrade Crate" },
      A = { "<CMD>lua require('crates').upgrade_all_crates(true)<CR>", "Upgrade All Crates" },
      h = { "<CMD>lua require('crates').open_homepage()<CR>", "Open Homepage" },
      R = { "<CMD>lua require('crates').open_repository()<CR>", "Open Repository" },
      D = { "<CMD>lua require('crates').open_documentation()<CR>", "Open Documentation" },
      C = { "<CMD>lua require('crates').open_crates_io()<CR>", "Open Crate.io" },
    },
  },
}

which_key.register(mappings, opts)
