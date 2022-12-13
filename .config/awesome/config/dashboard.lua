local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
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
            {
                value         = 0.5,
                forced_height = 800,
                forced_width  = 600,
                widget        = wibox.widget.progressbar
            },
            layout = wibox.layout.fixed.vertical,
        },
      margins = 10,
    
      widget  = wibox.container.margin
    },
    border_color = "#00ff00",
    border_width = 2,
    placement    = awful.placement.top_right,
    shape        = gears.shape.rounded_rect,
    --ontop = true,
    visible = false,
}
