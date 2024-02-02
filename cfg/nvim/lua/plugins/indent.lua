return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  enabled = false,
  config = function()
    local hooks = require("ibl.hooks")
    local highlight = { "IblGray" }

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "IblGray", { fg = "#737aa2" })
    end)

    require("ibl").setup({
      indent = {
        smart_indent_cap = true,
      },
      scope = {
        enabled = true,
        char = "│",
        show_start = false,
        show_end = false,
        highlight = highlight,
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "NvimTree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
        },
      },
      whitespace = {
        remove_blankline_trail = true,
      },
    })
  end,
}
