local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local theme = require("theme.theme")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")

-- "Album" Art
local album_art = wibox.widget({
  widget = wibox.widget.imagebox,
  image = theme.album_art,
  resize = true,
  clip_shape = helpers.rrect(),
  forced_height = dpi(115),
  forced_width = dpi(115),
})

-- Title
local title = wibox.widget.textbox()
title.font = theme.font .. " Bold 14"
title.align = "center"
title.valign = "center"

-- Artist
local artist = wibox.widget.textbox()
artist.font = theme.font .. " SemiBold 12"
artist.align = "center"
artist.valign = "center"

-- Lenght
local lenght = wibox.widget.textbox()
lenght.font = theme.font .. " Italic 12"
lenght.align = "center"
lenght.valign = "center"

-- Buttons
local toggle = wibox.widget.textbox()
toggle.font = theme.font .. " 18"

toggle:buttons(gears.table.join(awful.button({}, 1, function()
  awful.spawn("playerctl play-pause")
  if toggle.markup:match("") then
    toggle.markup = ""
  else
    toggle.markup = ""
  end
end)))

local next = wibox.widget.textbox()
next.font = theme.font .. " 22"
next.markup = ""

next:buttons(gears.table.join(awful.button({}, 1, function()
  awful.spawn("playerctl next")
end)))

local previous = wibox.widget.textbox()
previous.font = theme.font .. " 22"
previous.markup = ""

previous:buttons(gears.table.join(awful.button({}, 1, function()
  awful.spawn("playerctl previous")
end)))

-- Hover
toggle:connect_signal("mouse::enter", function()
  toggle.font = theme.font .. " 20"
end)
toggle:connect_signal("mouse::leave", function()
  toggle.font = theme.font .. " 18"
end)

next:connect_signal("mouse::enter", function()
  next.font = theme.font .. " 24"
end)
next:connect_signal("mouse::leave", function()
  next.font = theme.font .. " 22"
end)

previous:connect_signal("mouse::enter", function()
  previous.font = theme.font .. " 24"
end)
previous:connect_signal("mouse::leave", function()
  previous.font = theme.font .. " 22"
end)

-- Data
awesome.connect_signal("signal::player", function(t, a, s, l)
  if not s:match("Playing") then
    toggle.markup = ""
  else
    toggle.markup = ""
  end

  if t == "" then
    title.markup = "None"
  else
    title.markup = t
  end

  if a == "" then
    artist.markup = "Unknown"
  else
    artist.markup = a
  end

  lenght.markup = l
end)

local buttons = wibox.widget({
  previous,
  toggle,
  next,
  spacing = dpi(8),
  layout = wibox.layout.fixed.horizontal,
})

return wibox.widget({
  {
    nil,
    {
      album_art,
      layout = wibox.layout.fixed.vertical,
    },
    expand = "none",
    layout = wibox.layout.align.vertical,
  },
  {
    nil,
    nil,
    {
      {
        title,
        artist,
        layout = wibox.layout.fixed.vertical,
      },
     lenght,
      {
        nil,
        buttons,
        expand = "none",
        layout = wibox.layout.align.horizontal,
      },
      spacing = dpi(12),
      layout = wibox.layout.fixed.vertical,
    },
    layout = wibox.layout.align.vertical,
  },
  layout = wibox.layout.flex.horizontal,
})
