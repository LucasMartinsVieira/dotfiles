local awful = require("awful")
local helpers = require("helpers")

-- Rounded Corners
client.connect_signal("manage", function(c)
    c.shape = helpers.rrect(10)
end)

-- layouts
local l = awful.layout.suit
awful.layout.layouts = {
  l.tile,
  l.floating,
  l.fair,
  l.max,
  l.max.fullscreen,
}
