local colorscheme = "nightfly"

local status_ok, _ = pcall(function()
  vim.cmd.colorscheme(colorscheme)

  local function set_highlight_colors(bg)
    vim.api.nvim_set_hl(0, "NavicText", { bg = bg })
    vim.api.nvim_set_hl(0, "NavicSeparator", { bg = bg })
    vim.api.nvim_set_hl(0, "NavicIconsOperator", { bg = bg })
    vim.api.nvim_set_hl(0, "NavicIconsClass", { bg = bg })
    vim.api.nvim_set_hl(0, "NavicIconsConstant", { bg = bg })
    vim.api.nvim_set_hl(0, "NavicIconsConstructor", { bg = bg })
    vim.api.nvim_set_hl(0, "NavicIconsEnum", { bg = bg })
    vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { bg = bg })
    vim.api.nvim_set_hl(0, "NavicIconsFile", { bg = bg })
    vim.api.nvim_set_hl(0, "NavicIconsNull", { bg = bg })
    vim.api.nvim_set_hl(0, "NavicIconsString", { bg = bg })
    vim.api.nvim_set_hl(0, "WinBar", { bg = bg })
  end

  if colorscheme == "nightfly" then
    local bg = "#011627"
    set_highlight_colors(bg)
  elseif colorscheme == "moonfly" then
    local bg = "#080808"
    set_highlight_colors(bg)
  end
end)

if not status_ok then
  return
end
