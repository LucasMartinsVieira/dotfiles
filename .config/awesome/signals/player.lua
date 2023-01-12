local awful = require("awful")
local gears = require("gears")

-- Info
local music_title = "playerctl  metadata xesam:title"
local music_artist = "playerctl metadata xesam:artist"
local music_status = "playerctl status"
local music_length = 'playerctl -i firefox metadata --format "{{duration(position)}}"/"{{duration(mpris:length)}}"'

-- Function
local function get_player()
  awful.spawn.easy_async_with_shell(music_title, function(title)
    awful.spawn.easy_async_with_shell(music_artist, function(artist)
      awful.spawn.easy_async_with_shell(music_status, function(status)
          awful.spawn.easy_async_with_shell(music_length, function(length)
            title = string.gsub(title, "\n", "")
            artist = string.gsub(artist, "\n", "")
            status = string.gsub(status, "\n", "")
            length = string.gsub(length, "\n", "")
            awesome.emit_signal("signal::player", title, artist, status, length)
        end)
      end)
    end)
  end)
end

gears.timer({
  timeout = 5,
  call_now = true,
  autostart = true,
  callback = function()
    get_player()
  end,
})
