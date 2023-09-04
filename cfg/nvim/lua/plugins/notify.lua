return {
  "rcarriga/nvim-notify",
  enabled = false,
  config = function()
    require("notify").setup({
      stages = "slide",
      timeout = 1000,
      render = "default",
    })
  end,
}
