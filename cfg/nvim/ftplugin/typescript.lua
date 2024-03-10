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
    name = "Typescript",
    i = { "<cmd>TSToolsAddMissingImports<Cr>", "Add Missing Imports" },
    o = { "<cmd>TSToolsOrganizeImports<cr>", "Organize Imports" },
    u = { "<cmd>TSToolsRemoveUnused<Cr>", "Remove Unused" },
    r = { "<cmd>TSToolsRenameFile<Cr>", "Rename File" },
    f = { "<cmd>TSToolsFixAll<Cr>", "Fix All" },
    g = { "<cmd>TSToolsGoToSourceDefinition<Cr>", "Go To Source Definition" },
  },
}

which_key.register(mappings, opts)
