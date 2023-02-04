local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local theme = require("theme.theme")
local helpers = require("helpers")

require("ui.dashboard")

local menu = wibox.widget.textbox()
menu.font = theme.font .. " 28"
menu.markup = ""
helpers.add_hover_cursor(menu, "hand1")

menu:connect_signal("mouse::enter", function()
  if dashboard.visible == false then
    menu.markup = helpers.colorize_text("", theme.blue)
    menu.font = theme.font .. " 30"
  end
end)

menu:connect_signal("mouse::leave", function()
  if dashboard.visible == false then
    menu.markup = ""
    menu.font = theme.font .. " 28"
  end
end)

menu:buttons(gears.table.join(awful.button({}, 1, function()
  dashboard_show()

  if dashboard.visible == true then
    menu.markup = helpers.colorize_text("", theme.blue)
  else
    menu.markup = ""
  end
end)))

return menu
