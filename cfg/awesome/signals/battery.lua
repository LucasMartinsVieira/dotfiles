local awful = require("awful")
local gears = require("gears")


local battery_level = [[
cat /sys/class/power_supply/BAT?/capacity 2>/dev/null | head -1
]]

local function get_bat()
  awful.spawn.easy_async_with_shell(battery_level, function(bat_level)
    awesome.emit_signal("signal::battery", bat_level)
  end)
end

gears.timer {
	timeout = 5,
	call_now = true,
	autostart = true,
	callback = function()
		get_bat()
	end
}
