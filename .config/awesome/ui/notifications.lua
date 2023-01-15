local gears = require('gears')
local wibox = require('wibox')
local awful = require('awful')
local naughty = require('naughty')
local helpers = require("helpers")
local dpi = require("beautiful").xresources.apply_dpi

-- Defaults
naughty.config.defaults.ontop = true
naughty.config.defaults.border_width = 0
naughty.config.defaults.timeout = 5
naughty.config.defaults.icon_size = dpi(50)
naughty.config.defaults.timeout = 5
naughty.config.defaults.title = 'Notification'
naughty.config.defaults.margin = dpi(5)
naughty.config.defaults.position = 'top_right'
naughty.config.defaults.shape = helpers.rrect(dpi(4))

-- Apply theme variables
naughty.config.padding = dpi(8)
naughty.config.spacing = dpi(8)
