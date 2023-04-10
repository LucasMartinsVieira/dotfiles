return {
  "rcarriga/nvim-notify",
  config = function()
        require("notify").setup({
          stages = "slide",
          timeout = 1000,
          render = "default",
        })
      end,
}
