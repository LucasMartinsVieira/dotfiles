local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local helpers = require("helpers")
local theme = require("theme.theme")
local icons = require("utils.icons")

require("ui.power_popup")

local power = wibox.widget.textbox()
power.font = theme.font .. " 16"
power.markup = icons.power
helpers.add_hover_cursor(power, "hand1")

power:connect_signal("mouse::enter", function()
  if p.visible == false then
    power.markup = helpers.colorize_text(icons.power, theme.red)
    power.font = theme.font .. " 18"
  end
end)

power:connect_signal("mouse::leave", function()
  if p.visible == false then
    power.markup = icons.power
    power.font = theme.font .. " 16"
  end
end)

power:buttons(gears.table.join(awful.button({}, 1, function()
  power_popup_show()

  if p.visible == true then
    power.markup = helpers.colorize_text(icons.power, theme.red)
  else
    power.markup = icons.power
  end
end)))

return power
