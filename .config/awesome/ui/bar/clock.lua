local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local theme = require("theme.theme")
local calendar_widget = require("ui.calendar")
local calendar = calendar_widget()

local clock = wibox.widget({
  format = "%H:%M",
  --format = "%a %d %b, %H:%M",
  font = theme.font .. " 11",
  widget = wibox.widget.textclock,
})

clock:connect_signal("mouse::enter", function()
  clock.font = theme.font .. " 12"
end)

clock:connect_signal("mouse::leave", function()
  clock.font = theme.font .. " 11"
end)

clock:buttons(gears.table.join(awful.button({}, 1, function()
  calendar.toggle()
end)))

return clock
