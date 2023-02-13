local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local helpers = require("helpers")
local theme = require("theme.theme")

require("ui.power_popup")

local power = wibox.widget.textbox()
power.font = theme.font .. " 18"
power.markup = "⏻"
helpers.add_hover_cursor(power, "hand1")

power:connect_signal("mouse::enter", function()
  if p.visible == false then
    power.markup = helpers.colorize_text("⏻", theme.red)
    power.font = theme.font .. " 20"
  end
end)

power:connect_signal("mouse::leave", function()
  if p.visible == false then
    power.markup = "⏻"
    power.font = theme.font .. " 18"
  end
end)

power:buttons(gears.table.join(awful.button({}, 1, function()
  power_popup_show()

  if p.visible == true then
    power.markup = helpers.colorize_text("⏻", theme.red)
  else
    power.markup = "⏻"
  end
end)))

return power
