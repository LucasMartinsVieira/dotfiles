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

which_key.add({
  { "<leader>L", group = "Rust", nowait = true, remap = false },
  { "<leader>LC", "<CMD>RustLsp openCargo<CR>", desc = "Open Cargo", nowait = true, remap = false },
  { "<leader>LD", "<CMD>RustLsp externalDocs<CR>", desc = "Open Docs", nowait = true, remap = false },
  { "<leader>LR", "<CMD>RustLsp reloadWorkspace<CR>", desc = "Reload Workspace", nowait = true, remap = false },
  { "<leader>Lc", group = "Crates", nowait = true, remap = false },
  {
    "<leader>LcA",
    "<CMD>lua require('crates').upgrade_all_crates(true)<CR>",
    desc = "Upgrade All Crates",
    nowait = true,
    remap = false,
  },
  { "<leader>LcC", "<CMD>lua require('crates').open_crates_io()<CR>", desc = "Open Crate.io", nowait = true, remap = false },
  {
    "<leader>LcD",
    "<CMD>lua require('crates').open_documentation()<CR>",
    desc = "Open Documentation",
    nowait = true,
    remap = false,
  },
  { "<leader>LcR", "<CMD>lua require('crates').open_repository()<CR>", desc = "Open Repository", nowait = true, remap = false },
  {
    "<leader>LcU",
    "<CMD>lua require('crates').update_all_crates()<CR>",
    desc = "Update All Crates",
    nowait = true,
    remap = false,
  },
  { "<leader>Lca", "<CMD>lua require('crates').upgrade_crate<CR>", desc = "Upgrade Crate", nowait = true, remap = false },
  {
    "<leader>Lcd",
    "<CMD>lua require('crates').show_dependencies_popup()<CR>",
    desc = "Show Dependencies Popup",
    nowait = true,
    remap = false,
  },
  { "<leader>Lcf", "<CMD>lua require('crates').show_features_popup()<CR>", desc = "Show Features", nowait = true, remap = false },
  { "<leader>Lch", "<CMD>lua require('crates').open_homepage()<CR>", desc = "Open Homepage", nowait = true, remap = false },
  { "<leader>Lcp", "<CMD>lua require('crates').show_popup()<CR>", desc = "Show popup", nowait = true, remap = false },
  { "<leader>Lcr", "<CMD>lua require('crates').reload()<CR>", desc = "Reload", nowait = true, remap = false },
  { "<leader>Lcu", "<CMD>lua require('crates').update_crate()<CR>", desc = "Update Crate", nowait = true, remap = false },
  { "<leader>Lcv", "<CMD>lua require('crates').show_versions_popup()<CR>", desc = "Show Versions", nowait = true, remap = false },
  { "<leader>Ld", "<CMD>RustLsp debuggables<CR>", desc = "Debuggables", nowait = true, remap = false },
  { "<leader>Lm", "<CMD>RustLsp expandMacro<CR>", desc = "Expand Macro", nowait = true, remap = false },
  { "<leader>Lp", "<CMD>RustLsp parentModule<CR>", desc = "Parent Module", nowait = true, remap = false },
  { "<leader>Lr", "<CMD>RustLsp runnables<CR>", desc = "Runnables", nowait = true, remap = false },
  { "<leader>Lt", "<CMD>RustLsp testables<cr>", desc = "Testables", nowait = true, remap = false },
  { "<leader>Lv", "<CMD>RustLsp crateGraph<CR>", desc = "View Crate Graph", nowait = true, remap = false },
}, opts)
