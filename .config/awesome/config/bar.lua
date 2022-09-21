-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

local wibox = require("wibox")
local beautiful = require("beautiful")

-- Awesome wm Widgets

local weather_widget = require("awesome-wm-widgets.weather-widget.weather")
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")

-- Vars
local user_vars = require("user_variables")
local applications = require("config.applications")
local modkey = "Mod4"
require("config.menu")

--  Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock("%a %d %b, %H:%M", 1)
local cw = calendar_widget({
	theme = "dracula",
	placement = "top_center",
	start_sunday = true,
	radius = 6,
	-- with customized next/previous (see table above)
	previous_month_button = 1,
	next_month_button = 3,
})

mytextclock:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		cw.toggle()
	end
end)

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
	s.wifi = awful.widget.watch(".config/awesome/widgets/wifi", 1)

	s.wifi:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.spawn(applications.default.terminal_emulator .. " -e nmtui")
		end),
		awful.button({}, 3, function()
			awful.spawn("rofi-wifi")
		end)
	))

	-- Updates Widget
	s.updates = awful.widget.watch('bash -c "checkupdates | wc -l"', 20, function(widget, stdout)
		widget:set_markup("  " .. stdout)
	end)

	s.updates:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.spawn(applications.default.terminal_emulator .. " -e yay -Syu --noconfirm")
		end),
		awful.button({}, 3, function()
			awful.spawn("arch-checkupdates")
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
			s.wifi,
			wibox.widget.textbox(" "),
			s.updates,
			wibox.widget.textbox("   "),
			volume_widget({
				widget_type = "icon_and_text",
			}),
			wibox.widget.textbox(" "),
			weather_widget({
				api_key = user_vars.widget.weather.key,
				coordinates = user_vars.widget.weather.cordinates,
				show_hourly_forecast = true,
				show_daily_forecast = true,
			}),
			wibox.widget.textbox(" "),
      logout_menu_widget(),
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
