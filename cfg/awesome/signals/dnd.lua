local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

local function get_dnd()
  local dnd_status = naughty.is_suspended()
  awesome.emit_signal('signal::dnd', dnd_status)
end

gears.timer({
  timeout = 2,
  call_now = true,
  autostart = true,
  callback = function()
    get_dnd()
  end,
})
