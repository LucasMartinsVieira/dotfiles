local awful = require("awful")
local naughty = require("naughty")
local icons_dir = require("gears").filesystem.get_configuration_dir() .. "/theme/assets/"
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

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
                icon = icons_dir .. "camera.png",
                message = "Smile 📸",
                ontop = true,
                actions = { open, delete },
                width = dpi(200),
                height = dpi(80),
        }
end

return notify
