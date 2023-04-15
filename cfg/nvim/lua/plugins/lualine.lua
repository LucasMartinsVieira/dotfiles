local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local icons = require("user.icons")

local diff = {
  "diff",
  colored = false,
  symbols = { added = icons.git.Add .. " ", modified = icons.git.Mod .. " ", removed = icons.git.Remove .. " " }, -- changes diff symbols
  cond = hide_in_width,
}

local mode = {
  "mode",
  fmt = function(str)
    return " " .. str
  end,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = icons.git.Branch,
  right_padding = 2
}

local location = {
  "location",
  padding = {
    left = 0,
    right = 1,
  },
}

local progress = {
  "progress",
  padding = {
    left = 1,
    right = 1,
  },
}

local filename = {
  "filename",
  path = 0,
}

return {
  "nvim-lualine/lualine.nvim",
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
        lualine_a = { branch },
        lualine_b = { mode },
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 1, right = 0 },
          },
          filename,
        },
        lualine_x = { diff, "encoding", "filetype" },
        lualine_y = {},
        lualine_z = { progress, location },
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
  end
}
