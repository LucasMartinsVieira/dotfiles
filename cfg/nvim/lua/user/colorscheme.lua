local colorscheme = "nightfly"

-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not status_ok then
--   return
-- end

local status_ok, _ = pcall(function()
  vim.cmd.colorscheme(colorscheme)

  -- IndentBlankline
  vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#737aa2", bg = 'NONE' })
end)
if not status_ok then
  return
end
