local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local helpers = require("helpers")
local theme = require("theme.theme")

local applications = require("config.applications")

local launcher = wibox.widget.textbox()
launcher.font = theme.font .. " 18"
launcher.markup = ""

launcher:connect_signal("mouse::enter", function()
  launcher.markup = helpers.colorize_text("", theme.blue)
end)

launcher:connect_signal("mouse::leave", function()
  launcher.markup = ""
end)

launcher:buttons(gears.table.join(
	awful.button({}, 1, function()
		awful.spawn(applications.default.app_launcher, true)
	end)
))

return launcher
