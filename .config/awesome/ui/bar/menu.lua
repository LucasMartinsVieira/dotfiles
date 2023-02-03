local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local theme = require("theme.theme")
local helpers = require("helpers")

require("ui.dashboard")

local menu = wibox.widget.textbox()
menu.font = theme.font .. " 30"
menu.markup = ""
helpers.add_hover_cursor(menu, "hand1")

menu:connect_signal("mouse::enter", function ()
  menu.markup = helpers.colorize_text("", theme.blue)
  menu.font = theme.font .. " 32"
end)

menu:connect_signal("mouse::leave", function ()
  menu.markup = ""
  menu.font = theme.font .. " 30"
end)

menu:buttons(gears.table.join(
  awful.button({}, 1, function ()
    dashboard_show()
  end)
))

return menu
