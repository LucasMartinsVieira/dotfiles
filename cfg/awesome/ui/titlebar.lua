local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
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
    {
      -- Left
      {
        awful.titlebar.widget.closebutton(c),
        awful.titlebar.widget.minimizebutton(c),
        awful.titlebar.widget.maximizedbutton(c),
        spacing = dpi(2),
        layout = wibox.layout.fixed.horizontal,
      },
      left = dpi(6),
      widget = wibox.container.margin,
    },
    {
      --nil,
      layout = wibox.layout.flex.horizontal,
      -- buttons for the titlebar
      buttons = gears.table.join(
        awful.button({}, 1, function()
          client.focus = c
          c:raise()
          awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
          client.focus = c
          c:raise()
          awful.mouse.client.resize(c)
        end)
      ),
    },
    {
      -- Right
      {
        {
          --awful.titlebar.widget.iconwidget(c),
          widget = awful.titlebar.widget.titlewidget(c),
          font = theme.font .. " Italic",
          halign = "right",
        },
        layout = wibox.layout.fixed.horizontal(),
      },
      right = dpi(20),
      widget = wibox.container.margin,
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
