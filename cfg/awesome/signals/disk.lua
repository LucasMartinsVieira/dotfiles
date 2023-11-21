local awful = require("awful")
local gears = require("gears")

local user_likes = require("user_vars")

local main_disk = user_likes.user.main_disk

local function get_disk()
  local script = [[
	df -kH -B 1MB ]] .. main_disk .. [[ | tail -2 | awk '{printf $5}' | sed -e 's/%//' -e 's/Use//'
	]]

  awful.spawn.easy_async_with_shell(script, function(disk_perc)
    --disk_perc = disk_perc:match("%d+")
    awesome.emit_signal("signal::disk", disk_perc)
  end)
end

gears.timer({
  timeout = 2000,
  call_now = true,
  autostart = true,
  callback = function()
    get_disk()
  end,
})
