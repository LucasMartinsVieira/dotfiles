-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
require("awful.autofocus")

-- Vars
local applications = require("config.applications")
local modkey = "Mod4"
local menu = require("config.menu")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
require("config.dashboard")
local volume = require("widgets.volume")
local updates = require("widgets.updates")
--  Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock("%d %B %Y, %H:%M", 1)

local awful_icon = wibox.widget {
  --image = beautiful.awesome_icon,
  image = "/home/lucas/Imagens/dragon-svgrepo-com.svg",
  resize = true,
  --forced_width = dpi(20),
  widget = wibox.widget.imagebox,
  visible = true,
  clip_shape = gears.shape.rectangle,
  buttons = {
    awful.button({}, 1, nil, function ()
      if dashboard.visible == false then
        dashboard.visible = true
      else
        dashboard.visible = false
      end
    end)
  }
}

mytextclock_icon = wibox.widget {
   text = "",
   font = "jetbrains mono 16",
   ellipsize = "none",
   widget = wibox.widget.textbox,
}
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

  s.mypromptbox = awful.widget.prompt()
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
  local visibility = true
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

  --  Add widgets to the wibox
  s.mywibox:setup({
    layout = wibox.layout.align.horizontal,

    -- Left widgets
    {
      awful_icon,
      wibox.widget.textbox(" "),
      s.mytaglist,
      wibox.widget.textbox(" | "),
      layout = wibox.layout.fixed.horizontal,
    },
    s.mytasklist, -- Middle Widgets
    
    -- Right widgets
    {
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.textbox("   "),
      volume.volume_icon,
      volume.volume,
      wibox.widget.textbox(" "),
      updates.updates_icon,
      updates.updates,
      wibox.widget.textbox("  "),
      mytextclock_icon,
      wibox.widget.textbox(" "),
      mytextclock,
      wibox.widget.textbox("  "),
      wibox.widget.systray(),
    },
  })
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c):setup({
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout = wibox.layout.fixed.horizontal,
    },
    { -- Middle
      { -- Title
        align = "center",
        widget = awful.titlebar.widget.titlewidget(c),
      },
      buttons = buttons,
      layout = wibox.layout.flex.horizontal,
    },
    { -- Right
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal(),
    },
    layout = wibox.layout.align.horizontal,
  })
end)
