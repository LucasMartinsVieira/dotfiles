local bling = require("lib.bling")
local theme = require("theme.theme")
local wibox = require("wibox")
local awful = require("awful")
local helpers = require("helpers")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local naughty = require("naughty")
local playerctl = bling.signal.playerctl.lib()

local prev = wibox.widget {
  align = 'center',
  font = theme.font .. " 28",
  text = '󰒮',
  widget = wibox.widget.textbox,
}

local next = wibox.widget {
  align = 'center',
  font = theme.font .. " 28",
  text = '󰒭',
  widget = wibox.widget.textbox,
}

local play = wibox.widget {
  align = 'center',
  font = theme.font .. " 25",
  markup = '󰐊',
  widget = wibox.widget.textbox,
}

play:buttons(gears.table.join(
  awful.button({}, 1, function() playerctl:play_pause() end)))

next:buttons(gears.table.join(
  awful.button({}, 1, function() playerctl:next() end)))

prev:buttons(gears.table.join(
  awful.button({}, 1, function() playerctl:previous() end)))

local position = wibox.widget {
  forced_height      = dpi(3),
  shape              = helpers.rrect(),
  color              = theme.purple,
  background_color   = theme.fg_normal.. '4D',
  forced_width       = dpi(175),
  widget             = wibox.widget.progressbar,
}

local art = wibox.widget {
  image = theme.album_art,
  resize = true,
  opacity = 0.50,
  forced_height = dpi(120),
  forced_width = dpi(120),
  widget = wibox.widget.imagebox
}

local name = wibox.widget {
  markup = '<b>Nothing Playing</b>',
  align = 'center',
  valign = 'center',
  forced_height = dpi(15),
  widget = wibox.widget.textbox
}

local artist_name = wibox.widget {
  markup = 'None',
  align = 'center',
  valign = 'center',
  forced_height = dpi(20),
  widget = wibox.widget.textbox
}

local player = wibox.widget {
  {
    art,
    {
      {
        widget = wibox.widget.textbox,
      },
      bg = {
        type = "linear",
        from = { 0, 0},
        to = { 120, 0},
        --stops = { { 0, theme.bg2.."00" }, { 1, beautiful.bg2.."FF" } }
        stops = { { 0, theme.bg_alt.."00" }, { 1, theme.bg_alt.."FF" } }
      },
      widget = wibox.container.background,
    },
    {
      {
        name,
        artist_name,
        position,
        {
          prev,
          play,
          next,
          layout = wibox.layout.flex.horizontal,
        },
        spacing = dpi(10),
        layout = wibox.layout.fixed.vertical,
      },
      margins = dpi(20),
      widget = wibox.container.margin,
    },
    layout = wibox.layout.stack,
  },
  forced_height = dpi(120),
  shape = helpers.rrect(),
  bg = theme.blue,
  widget = wibox.container.background,
}

-- Get Song Info
playerctl:connect_signal("metadata", function(_, title, artist, album_path, album, new, player_name)
    -- Set art widget  
  if new then
    art.image = theme.album_art
  end
  art:set_image(gears.surface.load_uncached(album_path))
  name:set_markup_silently(helpers.colorize_text("<b>"..title.."</b>", theme.blue))
  artist_name:set_markup_silently(artist)

  if not player_name == "spotify" then
    naughty.notify { app_name = "Music Tool", title = title, text = artist .. "\n" .. album, icon = album_path }
  end
end)

playerctl:connect_signal("playback_status", function (_, playing, _)
  if playing then
    play:set_markup_silently(helpers.colorize_text("󰏤", theme.blue))
    position.color = theme.blue
  else
    play:set_markup_silently("󰐊")
    position.color = theme.fg_normal.."66"
  end
end)

playerctl:connect_signal("position", function (_, a, b, _)
  position.value = a
  position.max_value = b
end)

return player
