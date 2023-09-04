local colorscheme = "nightfly"

-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not status_ok then
--   return
-- end

local status_ok, _ = pcall(function()
  vim.cmd.colorscheme(colorscheme)
end)
if not status_ok then
  return
end
