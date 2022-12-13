local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local applications = require("config.applications")

local _M = {}

_M.updates = wibox.widget.textbox()

_M.updates_icon = wibox.widget {
  text = "  ",
  font = "JetBrains Mono 16",
  ellipsize = "none",
  widget = wibox.widget.textbox,
}

function _M.updates_num()
  local command = "checkupdates | wc -l"
  awful.spawn.easy_async_with_shell(command, function(out)
    _M.updates.text = string.format("%s ", out)
  end)
end

function _M.updates_()
  local command = "checkupdates"
  awful.spawn.easy_async_with_shell(command, function(out)
    naughty.notification({
      message = string.format("Updates:\n%s", out),
      timeout = 2.5,
    })
  end)
end

_M.updates:buttons(gears.table.join(
  awful.button({}, 1, function()
    awful.spawn(applications.default.terminal_emulator .. " -e paru -Syu --noconfirm")
  end),
  awful.button({}, 3, function()
    _M.updates_()
  end)
))

_M.updates_icon:buttons(gears.table.join(
  awful.button({}, 1, function()
    awful.spawn(applications.default.terminal_emulator .. " -e paru -Syu --noconfirm")
  end),
  awful.button({}, 3, function()
    _M.updates_()
  end)
))

_M.updates_num()

return _M
