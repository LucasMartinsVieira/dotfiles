local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local theme = require("theme.theme")
local helpers = require("helpers")
local applications = require("config.applications")
local updt = require("lib.updates")

local updates = wibox.widget.textbox()
updates.font = theme.font .. " 20"

awesome.connect_signal("signal::updates", function(upd)
  upd = tonumber(upd)
  if upd == 0 then
    updates.markup = helpers.colorize_text("", theme.yellow)
  else
    updates.markup = helpers.colorize_text("", theme.yellow)
  end
end)

updates:buttons(gears.table.join(
  awful.button({}, 1, function()
    awful.spawn(applications.default.terminal_emulator .. " -e paru -Syu --noconfirm")
  end),
  awful.button({}, 3, function()
    updt.num()
  end)
))

return updates
