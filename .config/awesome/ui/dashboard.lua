local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
require("awful.autofocus")

dashboard = awful.popup {
    widget = {
        {
            {
                {
                    text   = "foobar",
                    widget = wibox.widget.textbox
                },
                bg     = "#ff00ff",
                clip   = true,
                shape  = gears.shape.rounded_bar,
                widget = wibox.widget.background
            },
            layout = wibox.layout.fixed.vertical,
        },
      margins = 10,
      top = dpi(40),
      bottom = dpi(40),
      right = dpi(30),
      left = dpi(30),
      forced_width = dpi(290),
      widget  = wibox.container.margin
    },
    border_color = "#00ff00",
    border_width = 2,
    placement = function(c)
    (awful.placement.top_left)(c, { margins = { left = 20, bottom = 10 } })
  end,
    shape = gears.shape.rounded_rect,
    ontop = true,
    visible = false,
}
