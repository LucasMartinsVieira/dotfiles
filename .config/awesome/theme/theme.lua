--[[
 ______     ______     ______     __  __     ______   __     ______   __  __     __        
/\  == \   /\  ___\   /\  __ \   /\ \/\ \   /\__  _\ /\ \   /\  ___\ /\ \/\ \   /\ \       
\ \  __<   \ \  __\   \ \  __ \  \ \ \_\ \  \/_/\ \/ \ \ \  \ \  __\ \ \ \_\ \  \ \ \____  
 \ \_____\  \ \_____\  \ \_\ \_\  \ \_____\    \ \_\  \ \_\  \ \_\    \ \_____\  \ \_____\ 
  \/_____/   \/_____/   \/_/\/_/   \/_____/     \/_/   \/_/   \/_/     \/_____/   \/_____/ 
                                                                                          
  --]]

local gears = require("gears")
local naughty = require("naughty")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gcolor = require("gears.color")
local helpers = require("helpers")
local icons_dir = require("gears").filesystem.get_configuration_dir() .. "/theme/assets/"
local theme = {}

local colors = require('theme.nightfly') -- This has to be in single quotes for rofi-colorscheme to work

theme.yellow = colors.yellow
theme.blue = colors.blue
theme.red = colors.red
theme.green = colors.green
theme.purple = colors.purple

-- Base colors
theme.color_bg    = colors.bg_color
theme.color_bg_alt = colors.bg_alt
theme.focus_bg    = colors.bg_focus
theme.urgent_bg   = colors.bg_urgent
theme.minimize_bg = colors.bg_minimize
theme.systray_bg  = colors.bg_systray
theme.color_fg    = colors.fg_color

-- Taglist
theme.taglist_fg_focus = theme.yellow
theme.taglist_fg_occupied = theme.blue
theme.taglist_bg_focus = colors.bg_color

-- Tasklist
theme.tasklist_bg_focus = colors.bg_color
theme.tasklist_disable_task_name = true

-- Font
theme.font = "JetBrains Mono 9"

-- Colors
theme.bg_normal   = theme.color_bg
theme.bg_alt      = theme.color_bg_alt
theme.bg_focus    = theme.focus_bg
theme.bg_urgent   = theme.urgent_bg
theme.bg_minimize = theme.minimize_bg
theme.bg_systray  = theme.systray_bg

theme.fg_normal   = theme.color_fg
theme.fg_focus    = theme.color_fg
theme.fg_urgent   = theme.color_fg
theme.fg_minimize = theme.color_fg

-- Gaps
theme.useless_gap   = dpi(4)
theme.border_width  = dpi(2)
theme.border_normal = theme.color_fg
theme.border_marked = theme.urgent_bg

-- Notifications 
theme.notification_spacing    = dpi(4)
theme.notification_bg         = theme.color_bg
theme.notification_fg         = theme.color_fg
theme.notification_max_width  = dpi(1600)
theme.notification_max_height = dpi(800)
theme.notification_icon_size  = dpi(60)
theme.notification_shape = helpers.rrect(4)

-- Menu
theme.submenu = "    "
theme.menu_height           = dpi(25)
theme.menu_width            = dpi(180)
theme.menu_border_width	    = dpi(0)
theme.menu_border_color     = theme.fg_normal

-- Hotkeys Popup
theme.hotkeys_bg                = "#011627"
theme.hotkeys_fg                = "#c3ccdc"
theme.hotkeys_border_color      = "#ffffff"
theme.hotkeys_modifiers_fg      = "#ecc48d"
theme.hotkeys_border_width      = dpi(2)
theme.hotkeys_font              = theme.font
theme.hotkeys_description_font  = theme.font
theme.hotkeys_group_margin      = dpi(10)

-- Icons
theme.pfp = icons_dir .. "pfp.png"
theme.camera = icons_dir .. "camera.png"
theme.volume = icons_dir .. "volume.png"
theme.updates = icons_dir .. "updates.png"
theme.album_art = icons_dir .. "album.jpg"

-- Power Popup
theme.power = gcolor.recolor_image(icons_dir .. "power/power.png", theme.red)
theme.reboot = gcolor.recolor_image(icons_dir .. "power/reboot.png", theme.yellow)
theme.logout = gcolor.recolor_image(icons_dir .. "power/logout.png", theme.blue)
theme.suspend = gcolor.recolor_image(icons_dir .. "power/suspend.png", theme.green)

-- Layouts
theme.layout_floating       =  gcolor.recolor_image(icons_dir .. "layout/floating.png", theme.green)
theme.layout_max       =  gcolor.recolor_image(icons_dir .. "layout/max.png", theme.yellow)
theme.layout_tile       =  gcolor.recolor_image(icons_dir .. "layout/tile.png", theme.blue)
theme.layout_fairv       =  gcolor.recolor_image(icons_dir .. "layout/fair.png", theme.purple)
theme.layout_fullscreen = gcolor.recolor_image(icons_dir .. "layout/fullscreen.png", theme.red)

theme.awesome_icon      = theme_assets.awesome_icon(
  theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/kora"

return theme
