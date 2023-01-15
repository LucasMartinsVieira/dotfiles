local naughty = require("naughty")
local beautiful = require("beautiful")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    urgency = "critical",
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors,
    app_name = 'System Notification',
    icon = beautiful.awesome_icon,
  })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then
      return
    end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      urgency = "critical",
      text = tostring(err),
      app_name = 'System Notification',
      icon = beautiful.awesome_icon,
    })
    in_error = false
  end)
end
-- }}}
