local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local theme = require("theme.theme")
local helpers = require("helpers")
local calendar_widget = require("ui.calendar")
local calendar = calendar_widget()

local clock = wibox.widget({
  format = "%H:%M",
  --format = "%a %d %b, %H:%M",
  font = theme.font .. " 10",
  widget = wibox.widget.textclock,
})
helpers.add_hover_cursor(clock, "hand1")

clock:connect_signal("mouse::enter", function()
  clock.font = theme.font .. " 11"
  clock.format = "%d/%m/%Y"
end)

clock:connect_signal("mouse::leave", function()
  clock.font = theme.font .. " 10"
  clock.format = "%H:%M"
end)

clock:buttons(gears.table.join(awful.button({}, 1, function()
  calendar.toggle()
end)))

return clock
