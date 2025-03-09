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
  { "<leader>L", group = "Markdown", nowait = true, remap = false },
  { "<leader>Lp", "<CMD>MarkdownPreview<CR>", desc = "Markdown Preview", nowait = true, remap = false },
  { "<leader>Ls", "<CMD>MarkdownPreviewStop<CR>", desc = "Markdown Preview Stop", nowait = true, remap = false },
  { "<leader>Lt", "<CMD>MarkdownPreviewToggle<CR>", desc = "Markdown Preview Toggle", nowait = true, remap = false },
  { "<leader>Lr", "<CMD>RenderMarkdown toggle<CR>", desc = "Render Markdown toggle", nowait = true, remap = false },
}, opts)
