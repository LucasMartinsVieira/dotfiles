return {
  "rcarriga/nvim-notify",
  enabled = false,
  config = function()
    ---@diagnostic disable: missing-fields
    require("notify").setup({
      stages = "slide",
      timeout = 1000,
      render = "default",
    })
  end,
}
