local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local theme = require("theme.theme")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")
require("ui.notification_center")

local notification = wibox.widget.textbox()
notification.font = theme.font .. " 20"
notification.markup = "󰂚"
helpers.add_hover_cursor(notification, "hand1")

notification:connect_signal("mouse::enter", function()
  if notifs.visible == false then
    notification.markup = helpers.colorize_text("󰂚", theme.blue)
    notification.font = theme.font .. " 22"
  end
end)

notification:connect_signal("mouse::leave", function()
  if notifs.visible == false then
    notification.markup = "󰂚"
    notification.font = theme.font .. " 20"
  end
end)

notification:buttons(gears.table.join(awful.button({}, 1, function()
  notifs_toggle()

  if notifs.visible == true then
    notification.markup = helpers.colorize_text("󰂞", theme.blue)
  else
    notification.markup = "󰂚"
  end
end)))

return notification
