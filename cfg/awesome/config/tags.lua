local awful = require "awful"

screen.connect_signal("request::desktop_decoration", function(s)
      -- awful.tag({ " I ", " II ", " III ", " IV ", " V ", " VI " }, s, awful.layout.layouts[1])
      awful.tag({ "  ", "  ", "  ", "  ", "  ", "  " }, s, awful.layout.layouts[1])
end)
