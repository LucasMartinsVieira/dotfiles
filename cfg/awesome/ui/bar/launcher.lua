local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local helpers = require("helpers")
local theme = require("theme.theme")

local user_likes = require("user_vars")

local launcher = wibox.widget.textbox()
launcher.font = theme.font .. " 18"
launcher.markup = "󰍉 "
helpers.add_hover_cursor(launcher, "hand1")

launcher:connect_signal("mouse::enter", function()
  launcher.markup = helpers.colorize_text("󰍉 ", theme.blue)
  launcher.font = theme.font .. " 20"
end)

launcher:connect_signal("mouse::leave", function()
  launcher.markup = "󰍉 "
  launcher.font = theme.font .. " 18"
end)

launcher:buttons(gears.table.join(
	awful.button({}, 1, function()
		awful.spawn(user_likes.apps.app_launcher, true)
	end)
))

return launcher
