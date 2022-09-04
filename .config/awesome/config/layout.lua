local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

local scale = true

-- layouts
local l = awful.layout.suit
awful.layout.layouts = {
  l.tile,
  l.floating,
  l.max,
  l.max.fullscreen,
}
