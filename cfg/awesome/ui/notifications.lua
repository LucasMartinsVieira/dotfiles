local naughty = require('naughty')
local helpers = require("helpers")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local theme = require("theme.theme")

-- Defaults
naughty.config.defaults.ontop = true
naughty.config.defaults.timeout = 5
naughty.config.defaults.title = 'Notification'

-- Display Notification
naughty.connect_signal('request::display', function (n)
    naughty.layout.box {
        notification = n,
        position = 'top_right',
        border_width = 3,
        border_color = theme.purple,
        bg = theme.bg_normal,
        fg = theme.fg_normal,
        shape = helpers.rrect(2),
        minimum_width = dpi(240),
        widget_template = helpers.get_notification_widget(n)
    }
end)
