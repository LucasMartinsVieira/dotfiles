local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local helpers = require("helpers")
local theme = require("theme.theme")

require("ui.power_popup")

local power = wibox.widget.textbox()
power.font = theme.font .. " 18"
power.markup = "⏻"

power:connect_signal("mouse::enter", function()
  power.markup = helpers.colorize_text("⏻", theme.red)
  power.font = theme.font .. " 20"
end)

power:connect_signal("mouse::leave", function()
  power.markup = "⏻"
  power.font = theme.font .. " 18"
end)

power:buttons(gears.table.join(
	awful.button({}, 1, function()
    power_popup_show()
	end)
))

return power
