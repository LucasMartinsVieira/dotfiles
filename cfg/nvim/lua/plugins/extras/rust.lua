return {
  "saecki/crates.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
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
}
