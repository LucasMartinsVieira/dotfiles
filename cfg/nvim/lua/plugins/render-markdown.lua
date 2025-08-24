local icons = require("user.icons")

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  ft = { "markdown" },
  enabled = false,
  config = function()
    require("render-markdown").setup({
      heading = {
        enabled = false,
      },
      bullet = {
        enabled = false,
        icons = { "•", "", "•", "" },
        -- highlight = "RenderMarkdownH4",
      },
      dash = { width = 15 },
      pipe_table = {
        enabled = false,
        preset = "round",
      },
      checkbox = {
        enabled = true,
        unchecked = {
          icon = "󰄱",
        },
        checked = {
          icon = "󰄲",
        },
        custom = {
          in_progress = { raw = "[/]", rendered = "󱎖", highlight = "RenderMarkdownTodo" },
          fowarded = { raw = "[>]", rendered = icons.ui.ChevronRight, highlight = "RenderMarkdownTodo" },
          scheduled = { raw = "[<]", rendered = "󰨳", highlight = "RenderMarkdownTodo" },
        },
      },
    })
  end,
}
