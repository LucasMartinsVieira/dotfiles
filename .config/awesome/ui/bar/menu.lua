local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local theme = require("theme.theme")
local helpers = require("helpers")

require("ui.dashboard")

local menu = wibox.widget.textbox()
menu.font = theme.font .. " 30"
menu.markup = ""

menu:connect_signal("mouse::enter", function ()
  menu.markup = helpers.colorize_text("", theme.blue)
end)

menu:connect_signal("mouse::leave", function ()
  menu.markup = ""
end)

menu:buttons(gears.table.join(
  awful.button({}, 1, function ()
    dashboard_show()
  end)
))

return menu
