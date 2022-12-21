local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"

local vol_sc = [[
amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }' | sed -e 's/%//'
]]
local mute_sc = [[
amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $4 }'
]]

local function get_vol()
	awful.spawn.easy_async_with_shell(vol_sc, function(vol)
		awful.spawn.easy_async_with_shell(mute_sc, function(mute)
			if mute:match("on") then
				muted = false
			else
				muted = true
			end

			awesome.emit_signal("signal::volume", vol, muted)
		end)
	end)
end
	
gears.timer {
	timeout = 2,
	call_now = true,
	autostart = true,
	callback = function()
		get_vol()
	end
}
