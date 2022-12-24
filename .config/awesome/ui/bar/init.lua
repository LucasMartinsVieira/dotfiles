-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
require("awful.autofocus")
-- Vars
local modkey = "Mod4"

-- Widgets 
local wifi = require("ui.bar.wifi")
local updates = require("ui.bar.updates")
local clock = require("ui.bar.clock")
local keyboard = require("ui.bar.keyboard")
local user = require("ui.bar.user")
local menu = require("ui.bar.menu")
local volume = require("ui.bar.volume")
local launcher = require("ui.bar.launcher")

--  Wibar

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t)
    t:view_only()
  end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
  end)
)

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
  })

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.focused,
    buttons = {
       awful.button({ }, 1, function (c)
            c:activate { context = "tasklist", action = "toggle_minimization" }
        end),
        awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
        awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
        awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
    },
  })

  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "top",
    screen = s,
    visible = true,
    stretch = true,
    margins = {
      top = 3,
      bottom = 1,
      left = 6,
      right = 6,
    },
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 4)
    end,
  })

  -- Add widgets to the wibox
  s.mywibox:setup({
    layout = wibox.layout.align.horizontal,

    -- Left widgets
    {
      menu,
      wibox.widget.textbox(" "),
      s.mytaglist,
      layout = wibox.layout.fixed.horizontal,
    },

    -- Middle Widgets
    {
      layout = wibox.layout.ratio.horizontal,
      wibox.container.place(clock),
    },
    
    -- Right widgets
    {
      layout = wibox.layout.fixed.horizontal,
      wifi,
      wibox.widget.textbox("  "),
      volume,
      wibox.widget.textbox("  "),
      updates,
      wibox.widget.textbox(" "),
      -- user,
      keyboard,
      wibox.widget.textbox(" "),
      launcher,
      wibox.widget.textbox("  "),
      wibox.widget.systray(),
    },
  })
end)
