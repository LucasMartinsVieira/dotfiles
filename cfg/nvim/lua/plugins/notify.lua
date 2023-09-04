return {
  "rcarriga/nvim-notify",
  enabled = true,
  config = function()
    require("notify").setup({
      stages = "slide",
      timeout = 1000,
      render = "default",
    })
  end,
}
