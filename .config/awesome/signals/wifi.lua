local awful = require("awful")
local gears = require ("gears")

local script = [[
nmcli -t connection show --active
]]

local function wifi_sc()
  awful.spawn.easy_async_with_shell(script, function (stdout)
    local net_ssid = stdout
    local net_status = true

    if net_ssid == "" then
      net_status = false
    else
      net_status = true
    end

    awesome.emit_signal("signal::wifi", net_status)
  end)
end

gears.timer {
	timeout = 3,
	autostart = true,
	call_now = true,
	callback = function()
		wifi_sc()
	end,
}
