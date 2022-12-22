local awful = require("awful")
local naughty = require("naughty")

-- Some more notif function
local notify = {}

-- Notify after screenshot
notify.screenshot = function(location)
        local open = naughty.action {
                name = "Open"
        }

        open:connect_signal("invoked", function(n)
                awful.spawn('xdg-open ' .. location, false)
        end)

        local delete = naughty.action {
                name = "Delete"
        }

        delete:connect_signal("invoked", function(n)
                awful.spawn('rm -rf ' .. location, true)
        end)

        naughty.notification {
                app_name = "Screenshot Tool",
                title = "Screenshot",
                icon = location,
                message = "Screenshot: " .. location,
                actions = { open, delete },
        }
end

return notify
