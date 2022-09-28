-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
require("awful.autofocus")

-- Vars
local applications = require("config.applications")
local modkey = "Mod4"
require("config.menu")

--  Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock("%a %d %b, %H:%M", 1)

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

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
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
		-- buttons = tasklist_buttons,
	})
  

	-- Wifi Widget
	s.wifi = awful.widget.watch(".config/awesome/widgets/wifi", 10)

	s.wifi:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.spawn(applications.default.terminal_emulator .. " -e nmtui")
		end)
	))

  s.wifi_icon = wibox.widget {
    text = "直",
    font = "JetBrains Mono 18",
    ellipsize = "none",
    widget = wibox.widget.textbox,
  }

	s.wifi_icon:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.spawn(applications.default.terminal_emulator .. " -e nmtui")
		end),
		awful.button({}, 3, function()
			awful.spawn("rofi-wifi")
		end)
	))

	-- Updates Widget
	s.updates = awful.widget.watch(".config/awesome/widgets/updates")
  
  s.updates_icon = wibox.widget {
    text = "  ",
    font = "jetbrains mono 16",
    ellipsize = "none",
    widget = wibox.widget.textbox,
  }

	s.updates:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.spawn(applications.default.terminal_emulator .. " -e yay -Syu --noconfirm")
		end),
		awful.button({}, 3, function()
			awful.spawn("arch-checkupdates")
		end)
	))

	s.updates_icon:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.spawn(applications.default.terminal_emulator .. " -e yay -Syu --noconfirm")
		end),
		awful.button({}, 3, function()
			awful.spawn("arch-checkupdates")
		end)
	))

  -- Volume Widget
  s.volume = awful.widget.watch(".config/awesome/widgets/volume", 1)

  s.volume_icon = wibox.widget {
    text = "墳",
    font = "JetBrains Mono 18",
    ellipsize = "none",
    widget = wibox.widget.textbox,
  }

	s.volume:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.spawn("pamixer -t")
		end),
		awful.button({}, 3, function()
			awful.spawn("pavucontrol")
		end),
		awful.button({}, 4, function()
			awful.spawn("pamixer -i 5")
		end),
		awful.button({}, 5, function()
			awful.spawn("pamixer -d 5")
		end)
	))

	s.volume_icon:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.spawn("pamixer -t")
		end),
		awful.button({}, 3, function()
			awful.spawn("pavucontrol")
		end),
		awful.button({}, 4, function()
			awful.spawn("pamixer -i 5")
		end),
		awful.button({}, 5, function()
			awful.spawn("pamixer -d 5")
		end)
	))

  -- Weather Widget
  s.weather = awful.widget.watch(".config/awesome/widgets/weather")
  
  s.weather:buttons(gears.table.join(
    awful.button({}, 1, function ()
      awful.spawn(applications.default.terminal_emulator .. " -e curl -s https://wttr.in/")
    end)
  ))
  -- powerbutton
  s.powerbutton = wibox.widget {
    text = "⏻",
    font = "jetbrains mono 18",
    ellipsize = "none",
    widget = wibox.widget.textbox,
  }

  s.powerbutton:buttons(gears.table.join(
    awful.button({}, 1, function ()
      awful.spawn("rofi-powermenu")
    end)
  ))

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
			gears.shape.rounded_rect(cr, width, height, 10)
		end,
	})

	--  Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,

		-- Left widgets
		{
			s.mylayoutbox,
			wibox.widget.textbox("  "),
			s.mytaglist,
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.textbox("    "),
			s.mypromptbox,
		},

		-- Middle Widgets
		{
			layout = wibox.layout.ratio.horizontal,
			wibox.container.place(mytextclock),
		},

		-- Right widgets
		{
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.textbox("   "),
      s.wifi_icon,
			wibox.widget.textbox(" "),
			s.wifi,
      s.updates_icon,
			s.updates,
			wibox.widget.textbox("  "),
      s.volume_icon,
			wibox.widget.textbox(" "),
      s.volume,
			wibox.widget.textbox("  "),
      s.weather,
			wibox.widget.textbox(" "),
      s.powerbutton,
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
