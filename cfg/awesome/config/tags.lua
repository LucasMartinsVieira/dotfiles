local awful = require("awful")
local icons = require("utils.icons")

screen.connect_signal("request::desktop_decoration", function(s)
  -- awful.tag({ " I ", " II ", " III ", " IV ", " V ", " VI " }, s, awful.layout.layouts[1])
  awful.tag({
    icons.tag,
    icons.tag,
    icons.tag,
    icons.tag,
    icons.tag,
    icons.tag,
  }, s, awful.layout.layouts[1])
end)
