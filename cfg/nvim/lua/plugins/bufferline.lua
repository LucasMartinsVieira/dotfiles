return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  enabled = false,
  config = function()
    require("bufferline").setup({
      options = {
        always_show_bufferline = false,
      },
    })
  end,
}
