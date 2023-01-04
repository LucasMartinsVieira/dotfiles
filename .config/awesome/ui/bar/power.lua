local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local theme = require("theme.theme")

local power = wibox.widget.textbox()
power.font = beautiful.font .. " 18"
power.markup = "⏻"

power:connect_signal("mouse::enter", function()
  power.markup = "<span foreground='" .. theme.red .. "'>⏻</span>"
end)

power:connect_signal("mouse::leave", function()
  power.markup = "⏻"
end)

power:buttons(gears.table.join(
	awful.button({}, 1, function()
		awful.spawn.with_shell("systemctl poweroff")
	end),
	awful.button({}, 3, function()
		awful.spawn.with_shell("systemctl reboot")
	end)
))

return power
