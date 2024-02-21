return {
  -- Useful status updates for LSP
  "j-hui/fidget.nvim",
  enabled = false,
  tag = "v1.1.0",
  config = function()
    -- Turn on lsp status information
    require("fidget").setup()
  end,
}
