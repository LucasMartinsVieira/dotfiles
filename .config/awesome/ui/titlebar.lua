local awful = require("awful")
local wibox = require("wibox")
local ruled = require("ruled")
local theme = require("theme.theme")
local dpi = require("beautiful").xresources.apply_dpi

ruled.client.append_rule({
  id = "titlebars",
  rule_any = { type = { "normal", "dialog" } },
  properties = { titlebars_enabled = false },
})

client.connect_signal("request::titlebars", function(c)
  local titlebar = awful.titlebar(c, {
    size = dpi(22),
  })

  titlebar.widget = {
    { -- Left
      awful.titlebar.widget.closebutton(c),
      awful.titlebar.widget.minimizebutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      layout = wibox.layout.fixed.horizontal,
    },
    { -- Middle
      { -- Title
        halign = "center",
        font = theme.font,
        widget = awful.titlebar.widget.titlewidget(c),
      },
      layout = wibox.layout.flex.horizontal,
    },
    { -- Right
      awful.titlebar.widget.iconwidget(c),
      wibox.widget.textbox(" "),
      layout = wibox.layout.fixed.horizontal(),
    },
    layout = wibox.layout.align.horizontal,
  }
end)

-- turn titlebar on when client is floating
-------------------------------------------------------------------------------
client.connect_signal("property::floating", function(c)
  if c.floating and not c.requests_no_titlebar then
    awful.titlebar.show(c)
  else
    awful.titlebar.hide(c)
  end
end)

-- turn tilebars on when layout is floating
-------------------------------------------------------------------------------
awful.tag.attached_connect_signal(nil, "property::layout", function(t)
  local float = t.layout.name == "floating"
  for _, c in pairs(t:clients()) do
    c.floating = float
  end
end)
