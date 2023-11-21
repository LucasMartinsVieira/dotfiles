local awful = require("awful")
local gears = require("gears")

-- amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $3 }' | sed -e 's/%//'
local vol_sc = [[
wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}'
]]
-- amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $4 }'
local mute_sc = [[
wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}'
]]

local function get_vol()
  awful.spawn.easy_async_with_shell(vol_sc, function(vol)
    awful.spawn.easy_async_with_shell(mute_sc, function(mute)
      if mute:match("[MUTED]") then
        muted = true
      else
        muted = false
      end

      awesome.emit_signal("signal::volume", vol, muted)
    end)
  end)
end

gears.timer({
  timeout = 2,
  call_now = true,
  autostart = true,
  callback = function()
    get_vol()
  end,
})
