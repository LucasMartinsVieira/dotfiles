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
  { "<leader>L", group = "Typescript", nowait = true, remap = false },
  { "<leader>Lf", "<cmd>TSToolsFixAll<Cr>", desc = "Fix All", nowait = true, remap = false },
  { "<leader>Lg", "<cmd>TSToolsGoToSourceDefinition<Cr>", desc = "Go To Source Definition", nowait = true, remap = false },
  { "<leader>Li", "<cmd>TSToolsAddMissingImports<Cr>", desc = "Add Missing Imports", nowait = true, remap = false },
  { "<leader>Lo", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize Imports", nowait = true, remap = false },
  { "<leader>Lr", "<cmd>TSToolsRenameFile<Cr>", desc = "Rename File", nowait = true, remap = false },
  { "<leader>Lu", "<cmd>TSToolsRemoveUnused<Cr>", desc = "Remove Unused", nowait = true, remap = false },
}, opts)
