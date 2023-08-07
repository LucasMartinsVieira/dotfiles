local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local theme = require("theme.theme")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")
local icons = require("utils.icons")

require("ui.notification_center")

local notification = wibox.widget.textbox()
notification.font = theme.font .. " 14"
notification.markup = icons.notification.normal
helpers.add_hover_cursor(notification, "hand1")

awesome.connect_signal("signal::dnd", function(dnd_status)
  if dnd_status then
    notification.markup = icons.notification.off
  end
end)

notification:connect_signal("mouse::enter", function()
  if notifs.visible == false then
    notification.markup =
      helpers.colorize_text(icons.notification.normal, theme.blue)
    notification.font = theme.font .. " 16"
  end
end)

notification:connect_signal("mouse::leave", function()
  if notifs.visible == false then
    notification.markup = icons.notification.normal
    notification.font = theme.font .. " 14"
  end
end)

notification:buttons(gears.table.join(awful.button({}, 1, function()
  notifs_toggle()

  if notifs.visible == true then
    notification.markup =
      helpers.colorize_text(icons.notification.on, theme.blue)
  else
    notification.markup = icons.notification.normal
  end
end)))

return notification
