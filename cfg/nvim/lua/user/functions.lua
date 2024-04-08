local M = {}

function M.get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not status_ok then
    return nil
  else
    return buf_option
  end
end

function M.toggle_option(option)
  local value = not vim.api.nvim_get_option_value(option, {})
  vim.opt[option] = value
end

local enabled = true
function M.toggle_diagnostics()
  enabled = not enabled
  local status_ok, notify = pcall(require, "notify")
  if not status_ok then
    vim.print("Enable rcarriga/nvim-notify")
  end

  if enabled then
    vim.diagnostic.enable()

    if notify then
      notify("Diagnostics enabled", "warn", {
        title = "Diagnostics",
        icon = require("user.icons").diagnostics.Warning,
      })
    else
      vim.print("Diagnostics enabled")
    end
  else
    vim.diagnostic.disable()
    if notify then
      notify("Diagnostics disabled", "warn", {
        title = "Diagnostics",
        icon = require("user.icons").diagnostics.Warning,
      })
    else
      vim.print("Diagnostics disabled")
    end
  end
end

return M
