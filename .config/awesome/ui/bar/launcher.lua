local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local theme = require("theme.theme")

local applications = require("config.applications")

local launcher = wibox.widget.textbox()
launcher.font = beautiful.font .. " 20"
launcher.markup = ""

launcher:connect_signal("mouse::enter", function()
  launcher.markup = "<span foreground='"..theme.blue.."'></span>"
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
