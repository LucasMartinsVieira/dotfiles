local components = require("plugins.lualine.components")

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = true,
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "dashboard", "NvimTree", "Outline", "alpha" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { components.mode },
        lualine_b = { components.branch },
        lualine_c = { components.diff, components.filename },
        lualine_x = {
          -- components.lsp,
          components.diagnostics,
          components.spaces,
          components.filetype,
        },
        lualine_y = {},
        lualine_z = { components.location, components.progress },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end,
}
