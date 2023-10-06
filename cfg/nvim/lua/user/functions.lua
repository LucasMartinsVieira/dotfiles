local M = {}

function M.isempty(s)
  return s == nil or s == "" or s == "."
end

function M.get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not status_ok then
    return nil
  else
    return buf_option
  end
end

function M.smart_quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/n) ",
    }, function(input)
      if input == "y" then
        vim.cmd("q!")
      end
    end)
  else
    vim.cmd("q!")
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
        icon = require("user.icons").diagnostics.warning,
      })
    else
      vim.print("Diagnostics enabled")
    end
  else
    vim.diagnostic.disable()
    if notify then
      notify("Diagnostics disabled", "warn", {
        title = "Diagnostics",
        icon = require("user.icons").diagnostics.warning,
      })
    else
      vim.print("Diagnostics disabled")
    end
  end
end

M.lazygit_toggle = function()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
      border = "none",
      width = 100000,
      height = 100000,
    },
    on_open = function(_)
      vim.cmd("startinsert!")
    end,
    on_close = function(_) end,
    count = 99,
  })
  lazygit:toggle()
end

M.lua_terminal = function()
  local Terminal = require("toggleterm.terminal").Terminal
  local lua = Terminal:new({
    cmd = "lua",
    hidden = true,
    direction = "horizontal",
    on_open = function(_)
      vim.cmd("startinsert!")
    end,
    on_close = function(_) end,
    count = 99,
  })
  lua:toggle()
end

M.node_terminal = function()
  local Terminal = require("toggleterm.terminal").Terminal
  local node = Terminal:new({
    cmd = "node",
    hidden = true,
    direction = "horizontal",
    on_open = function(_)
      vim.cmd("startinsert!")
    end,
    on_close = function(_) end,
    count = 99,
  })
  node:toggle()
end

M.deno_terminal = function()
  local Terminal = require("toggleterm.terminal").Terminal
  local deno = Terminal:new({
    cmd = "deno",
    hidden = true,
    direction = "horizontal",
    on_open = function(_)
      vim.cmd("startinsert!")
    end,
    on_close = function(_) end,
    count = 99,
  })
  deno:toggle()
end

M.btop_terminal = function()
  local Terminal = require("toggleterm.terminal").Terminal
  local btop = Terminal:new({
    cmd = "btop",
    hidden = true,
    direction = "float",
    float_opts = {
      border = "none",
      width = 100000,
      height = 100000,
    },
    on_open = function(_)
      vim.cmd("startinsert!")
    end,
    on_close = function(_) end,
    count = 99,
  })
  btop:toggle()
end

return M
