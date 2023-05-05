local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local theme = require("theme.theme")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")

local tray = wibox.widget.textbox()
tray.font = theme.font .. " 14"
tray.markup = " "
helpers.add_hover_cursor(tray, "hand1")

tray:connect_signal("mouse::enter", function()
  if tray_popup.visible == false then
    tray.markup = helpers.colorize_text(" ", theme.blue)
    tray.font = theme.font .. " 16"
  end
end)

tray:connect_signal("mouse::leave", function()
  if tray_popup.visible == false then
    tray.markup = " "
    tray.font = theme.font .. " 14"
  end
end)

tray:buttons(gears.table.join(awful.button({}, 1, function()
  tray_popup_show()

  if tray_popup.visible == true then
    tray.markup = helpers.colorize_text(" ", theme.blue)
  else
    tray.markup = " "
  end
end)))

tray.widget = wibox.widget({
  {
    {
      {
        widget = wibox.widget.systray,
        horizontal = false,
        screen = s,
        base_size = 22,
      },
      layout = wibox.layout.fixed.horizontal,
    },
    margins = dpi(12),
    widget = wibox.container.margin,
  },
  bg = theme.bg_normal,
  fg = theme.fg_normal,
  widget = wibox.container.background,
  shape = helpers.rrect(),
})

tray_popup = awful.popup({
  widget = tray.widget,
  screen = s,
  visible = false,
  ontop = true,
  bg = theme.bg_normal,
  fg = theme.fg_normal,
  minimum_width = dpi(200),
  minimum_height = dpi(150),
  shape = helpers.rrect(),
  placement = function(d)
    return awful.placement.top_right(d, {
      margins = {
        top = dpi(40),
        right = dpi(15),
        bottom = dpi(88),
      },
    })
  end,
})

function tray_popup_show()
  if tray_popup.visible == false then
    tray_popup.visible = true
  else
    tray_popup.visible = false
  end
end

return tray
