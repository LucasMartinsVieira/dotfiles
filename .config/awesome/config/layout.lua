local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

local scale = true

-- Rounded Corners
client.connect_signal("manage", function(c)
    c.shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 10)
    end
end)

-- layouts
local l = awful.layout.suit
awful.layout.layouts = {
  l.tile,
  l.floating,
  --l.max,
  l.max.fullscreen,
}
