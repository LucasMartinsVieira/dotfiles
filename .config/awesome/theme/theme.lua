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
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local gcolor = require("gears.color")
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
naughty.config.defaults.border_width = 0
naughty.config.defaults.timeout = 5
theme.notification_spacing    = dpi(4)
theme.notification_bg         = theme.color_bg
theme.notification_fg         = theme.color_fg
theme.notification_max_width  = dpi(1600)
theme.notification_max_height = dpi(800)
theme.notification_icon_size  = dpi(60)
theme.notification_shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 4)
end

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

-- Layouts
theme.layout_floating       =  gcolor.recolor_image(icons_dir .. "layout/floating.png", theme.green)
theme.layout_max       =  gcolor.recolor_image(icons_dir .. "layout/max.png", theme.yellow)
theme.layout_tile       =  gcolor.recolor_image(icons_dir .. "layout/tile.png", theme.blue)
theme.layout_fairv       =  gcolor.recolor_image(icons_dir .. "layout/fair.png", theme.purple)
theme.layout_fullscreen = gcolor.recolor_image(icons_dir .. "layout/fullscreen.png", theme.red)

--theme.layout_fairh      = themes_path .. "default/layouts/fairhw.png"
--theme.layout_fairv      = themes_path .. "default/layouts/fairvw.png"
--theme.layout_magnifier  = themes_path .. "default/layouts/magnifierw.png"
--theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
--theme.layout_tileleft   = themes_path .. "default/layouts/tileleftw.png"
--theme.layout_tiletop    = themes_path .. "default/layouts/tiletopw.png"
--theme.layout_spiral     = themes_path .. "default/layouts/spiralw.png"
--theme.layout_dwindle    = themes_path .. "default/layouts/dwindlew.png"
--theme.layout_cornernw   = themes_path .. "default/layouts/cornernww.png"
--theme.layout_cornerne   = themes_path .. "default/layouts/cornernew.png"
--theme.layout_cornersw   = themes_path .. "default/layouts/cornersww.png"
--theme.layout_cornerse   = themes_path .. "default/layouts/cornersew.png"
-- Generate Awesome icon:
theme.awesome_icon      = theme_assets.awesome_icon(
  theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
