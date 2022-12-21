local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local theme = require("theme.theme")

require("ui.dashboard")

local menu = wibox.widget.textbox()
menu.font = beautiful.font .. " 30"
menu.markup = ""

menu:connect_signal("mouse::enter", function ()
  menu.markup = "<span foreground='".. theme.blue .."'></span>"
end)

menu:connect_signal("mouse::leave", function ()
  menu.markup = ""
end)

menu:buttons(gears.table.join(
  awful.button({}, 1, function ()
      if dashboard.visible == false then
        dashboard.visible = true
      else
        dashboard.visible = false
      end
  end)
))

return menu
