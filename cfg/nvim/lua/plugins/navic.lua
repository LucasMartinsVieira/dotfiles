return {
  {
    "LunarVim/breadcrumbs.nvim",
    enabled = true,
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    config = function()
      require("breadcrumbs").setup()
    end,
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    enabled = true,
    config = function()
      local icons = require("user.icons")
      require("nvim-navic").setup({
        icons = {
          File = icons.kind.File .. " ",
          Module = icons.kind.Module .. " ",
          Namespace = icons.kind.Namespace .. " ",
          Package = icons.kind.Package .. " ",
          Class = icons.kind.Class .. " ",
          Method = icons.kind.Method .. " ",
          Property = icons.kind.Property .. " ",
          Field = icons.kind.Field .. " ",
          Constructor = icons.kind.Constructor .. " ",
          Enum = icons.kind.Enum .. " ",
          Interface = icons.kind.Interface .. " ",
          Function = icons.kind.Function .. " ",
          Variable = icons.kind.Variable .. " ",
          Constant = icons.kind.Constant .. " ",
          String = icons.kind.String .. " ",
          Number = icons.kind.Number .. " ",
          Boolean = icons.kind.Boolean .. " ",
          Array = icons.kind.Array .. " ",
          Object = icons.kind.Object .. " ",
          Key = icons.kind.Keyword .. " ",
          Null = icons.kind.Null .. " ",
          EnumMember = icons.kind.EnumMember .. " ",
          Struct = icons.kind.Struct .. " ",
          Event = icons.kind.Event .. " ",
          Operator = icons.kind.Operator .. " ",
          TypeParameter = icons.kind.TypeParameter .. " ",
        },
        lsp = {
          auto_attach = true,
        },
        highlight = true,
        click = true,
        separator = " " .. icons.ui.ChevronRight .. " ",
        depth_limit = 0,
        depth_limit_indicator = "..",
        safe_output = true,
      })
    end,
  },
}
