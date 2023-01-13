local awful = require("awful")
local gears = require("gears")

local script = [[
nmcli -t connection show --active
]]

local wifi_stregth = [[
awk '/^\s*w/ { print  int($3 * 100 / 70) }' /proc/net/wireless
]]

local function wifi_sc()
  awful.spawn.easy_async_with_shell(script, function(stdout)
    awful.spawn.easy_async_with_shell(wifi_stregth, function(out)
      
    local net_ssid = stdout
    local net_status = true

    if net_ssid == "" then
      net_status = false
    else
      net_status = true
    end

    local net_stregth = out

    awesome.emit_signal("signal::wifi", net_status, net_stregth )
    end)
  end)
end

gears.timer({
  timeout = 3,
  autostart = true,
  call_now = true,
  callback = function()
    wifi_sc()
  end,
})
