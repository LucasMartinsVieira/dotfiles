local conditions = require("plugins.lualine.conditions")
local icons = require("user.icons")

return {
  mode = {
    function()
      return " " .. icons.ui.Target .. " "
    end,
    padding = { left = 0, right = 0 },
    color = {},
    cond = nil,
  },

  branch = {
    "branch",
    icons_enabled = true,
    icon = icons.git.Branch,
    right_padding = 2,
  },

  diff = {
    "diff",
    colored = false,
    symbols = {
      added = icons.git.Add .. " ",
      modified = icons.git.Mod .. " ",
      removed = icons.git.Remove .. " ",
    }, -- changes diff symbols
    cond = conditions.hide_in_width,
  },

  filetype = {
    "filetype",
    cond = nil,
  },

  progress = {
    "progress",
    padding = {
      left = 1,
      right = 1,
    },
  },

  spaces = {
    function()
      local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
      return icons.ui.Tab .. " " .. shiftwidth
    end,
    padding = 1,
    color = { gui = "bold" },
  },

  scrollbar = {
    function()
      local current_line = vim.fn.line(".")
      local total_lines = vim.fn.line("$")
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end,
    padding = { left = 0, right = 1 },
    cond = nil,
  },

  location = {
    "location",
    padding = {
      left = 0,
      right = 1,
    },
  },

  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = {
      error = icons.diagnostics.error .. " ",
      warn = icons.diagnostics.warning .. " ",
      info = icons.diagnostics.information .. " ",
      hint = icons.diagnostics.hint .. " ",
    },
  },

  lsp = {
    function()
      local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
      if #buf_clients == 0 then
        return "LSP Inactive"
      end

      -- Retrieve the LSP clients for the current buffer
      local clients = vim.lsp.buf_get_clients()

      -- Extract the client names
      local names = {}
      for _, client in ipairs(clients) do
        if client.name ~= "null-ls" then
          table.insert(names, client.name)
        end
      end

      -- Concatenate the client names
      local uniq_names = vim.fn.uniq(names)
      local language_servers = "[" .. table.concat(uniq_names, ", ") .. "]"

      return language_servers
    end,
    color = { gui = "bold" },
    cond = conditions.hide_in_width,
  },
}
