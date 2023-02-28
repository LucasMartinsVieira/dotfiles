local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local icons = require("user.icons")

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "info", "hint" },
  symbols = { error = icons.diagnostics.error .. " ", warn = icons.diagnostics.warning .. " ", info = icons.diagnostics.information .. " ", hint = icons.diagnostics.hint .. " " },
  colored = false,
  update_in_insert = true,
  always_visible = true,
}

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

local filetype = {
  "filetype",
  icons_enabled = true,
  icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = icons.git.Branch,
}

local location = {
  "location",
  padding = {
    left = 0,
    right = 0,
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
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { branch, diagnostics },
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
        lualine_x = { diff, "encoding", filetype },
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
