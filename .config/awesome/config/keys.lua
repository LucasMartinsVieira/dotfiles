local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local naughty = require("naughty")
local applications = require("config.applications")

require("awful.autofocus")
local modkey = "Mod4"

local show_volume_percent_notification = function()
	local command = "pamixer --get-volume"
	awful.spawn.easy_async_with_shell(command, function(out)
		naughty.notification({
			message = string.format("Volume: %s", out),
			timeout = 0.5,
		})
	end)
end

globalkeys = gears.table.join(
  awful.key({ modkey }, "/", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
  awful.key({ modkey }, "a", awful.tag.viewprev, { description = "view previous", group = "tag" }),
  awful.key({ modkey }, "d", awful.tag.viewnext, { description = "view next", group = "tag" }),
  awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

  awful.key({ modkey }, "j", function()
    awful.client.focus.byidx(1)
  end, { description = "focus next by index", group = "client" }),
  awful.key({ modkey }, "k", function()
    awful.client.focus.byidx(-1)
  end, { description = "focus previous by index", group = "client" }),
  awful.key({ modkey, "Control" }, "w", function()
    mainmenu:show()
  end, { description = "show main menu", group = "awesome" }),

  -- Layout manipulation
  awful.key({ modkey, "Shift" }, "j", function()
    awful.client.swap.byidx(1)
  end, { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function()
    awful.client.swap.byidx(-1)
  end, { description = "swap with previous client by index", group = "client" }),
  awful.key({ modkey, "Control" }, "j", function()
    awful.screen.focus_relative(1)
  end, { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, "Control" }, "k", function()
    awful.screen.focus_relative(-1)
  end, { description = "focus the previous screen", group = "screen" }),
  awful.key({ modkey }, "g", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
  --[[ awful.key({ modkey }, "Tab", function() ]]
  --[[   awful.client.focus.history.previous() ]]
  --[[   if client.focus then ]]
  --[[     client.focus:raise() ]]
  --[[   end ]]
  --[[ end, { description = "go back", group = "client" }), ]]

  -- Standard program
  awful.key({ modkey }, "Return", function()
    awful.spawn(applications.default.terminal_emulator)
  end, { description = "open a terminal", group = "launcher" }),

  awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Control" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

  awful.key({ modkey }, "l", function()
    awful.tag.incmwfact(0.05)
  end, { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey }, "h", function()
    awful.tag.incmwfact(-0.05)
  end, { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, "Shift" }, "h", function()
    awful.tag.incnmaster(1, nil, true)
  end, { description = "increase the number of master clients", group = "layout" }),
  awful.key({ modkey, "Shift" }, "l", function()
    awful.tag.incnmaster(-1, nil, true)
  end, { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ modkey, "Control" }, "h", function()
    awful.tag.incncol(1, nil, true)
  end, { description = "increase the number of columns", group = "layout" }),
  awful.key({ modkey, "Control" }, "l", function()
    awful.tag.incncol(-1, nil, true)
  end, { description = "decrease the number of columns", group = "layout" }),
  awful.key({ modkey }, "Tab", function()
    awful.layout.inc(1)
  end, { description = "select next", group = "layout" }),
  awful.key({ modkey, "Shift" }, "Tab", function()
    awful.layout.inc(-1)
  end, { description = "select previous", group = "layout" }),

  awful.key({ modkey, "Control" }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end
  end, { description = "restore minimized", group = "client" }),

  -- Rofi Keybindings
  awful.key( {modkey}, "r", function()
      local grabber
      grabber =
        awful.keygrabber.run(
          function(_, key, event)
            if event == "release" then return end

            if key == "f" then awful.spawn.with_shell("rofi-files")
            elseif key == "s" then awful.spawn.with_shell("rofi-search")
            elseif key == "d" then awful.spawn.with_shell("rofi-powermenu")
            elseif key == "b" then awful.spawn.with_shell("rofi-beats")
            elseif key == "i" then awful.spawn.with_shell("rofi-maim")
            elseif key == "c" then awful.spawn.with_shell("rofi -show calc")
            elseif key == "w" then awful.spawn.with_shell("rofi-wallpaper")
            elseif key == "t" then awful.spawn.with_shell("rofi-colorscheme")
            end
            awful.keygrabber.stop(grabber)
            end
          )
        end,
        {description = "followed by KEY", group = "Rofi"}
        ),

  awful.key({ modkey, "Shift" }, "Return", function()
    awful.util.spawn(applications.default.app_launcher)
  end, { description = "Rofi", group = "Rofi" }),

  awful.key({ modkey }, "w", function()
    awful.util.spawn("rofi -show window")
  end, { description = "Rofi window ", group = "Rofi" }),

  -- Neovim Keybindings
  
 awful.key( {modkey}, "v", function()
      local grabber
      grabber =
        awful.keygrabber.run(
          function(_, key, event)
            if event == "release" then return end

            if     key == "v" then awful.spawn.with_shell(applications.default.terminal_emulator .. " -e nvim")
            elseif key == "w" then awful.spawn.with_shell(applications.default.terminal_emulator .. " -e nvim ~/Documentos/vimwiki/index.md")
            elseif key == "n" then awful.spawn.with_shell(applications.default.terminal_emulator .. " -e nvim ~/Documentos/vimwiki/Notes.md")
            elseif key == "o" then awful.spawn.with_shell(applications.default.terminal_emulator .. " -e nvim ~/Documentos/vimwiki/one-piece-manga.md")
            end
            awful.keygrabber.stop(grabber)
            end
          )
        end,
        {description = "followed by KEY", group = "Neovim"}
        ),

  -- Playerctl

  awful.key({ modkey, }, ";", function()
    awful.util.spawn("playerctl play-pause")
  end, { description = "Play or Pause", group = "Playerctl" }),

  awful.key({ modkey, }, ".", function()
    awful.util.spawn("playerctl next")
  end, { description = "Next", group = "Playerctl" }),

  awful.key({ modkey, }, ",", function()
    awful.util.spawn("playerctl previous")
  end, { description = "Previous", group = "Playerctl" }),

  -- Scripts

  awful.key({ modkey }, "u", function()
    awful.util.spawn("arch-checkupdates")
  end, { description = "checkupdates", group = "awesome" }),

  awful.key({ modkey }, "=", function()
    awful.util.spawn("pamixer -i 5")
   	show_volume_percent_notification()
  end, { description = "volume +", group = "awesome" }),

  awful.key({ modkey }, "-", function()
    awful.util.spawn("pamixer -d 5")
   	show_volume_percent_notification()
  end, { description = "volume -", group = "awesome" }),

  -- applications keybindings
  awful.key({ modkey }, "b", function()
    awful.util.spawn(applications.default.browser)
  end, { description = "Browser", group = "applications" }),

  awful.key({ modkey }, "g", function()
    awful.util.spawn(applications.default.music_player)
  end, { description = "Music Player", group = "applications" }),

  awful.key({ modkey }, "p", function()
    awful.util.spawn(applications.default.terminal_emulator .. " -e lfrun")
  end, { description = "Lf", group = "applications" }),

  awful.key({ modkey, "Shift" }, "b", function()
    awful.util.spawn("qutebrowser")
  end, { description = "Qutebrowser", group = "applications" }),

  awful.key({ modkey }, "y", function()
    visibility = not visibility
    awful.screen.focused().mywibox.visible = visibility
  end, { description = "toggle Wibar", group = "awesome" }),

  awful.key({ modkey }, "x", function()
    awful.prompt.run({
      prompt = "Run Lua code: ",
      textbox = awful.screen.focused().mypromptbox.widget,
      exe_callback = awful.util.eval,
      history_path = awful.util.get_cache_dir() .. "/history_eval",
    })
  end, { description = "lua execute prompt", group = "awesome" })
)

clientkeys = gears.table.join(
  awful.key({ modkey }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey, "Shift" }, "c", function(c)
    c:kill()
  end, { description = "close", group = "client" }),
  awful.key(
    { modkey, "Control" },
    "space",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }
  ),
  awful.key({ modkey, "Control" }, "Return", function(c)
    c:swap(awful.client.getmaster())
  end, { description = "move to master", group = "client" }),
  awful.key({ modkey }, "o", function(c)
    c:move_to_screen()
  end, { description = "move to screen", group = "client" }),
  awful.key({ modkey }, "t", function(c)
    c.ontop = not c.ontop
  end, { description = "toggle keep on top", group = "client" }),
  awful.key({ modkey }, "n", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end, { description = "minimize", group = "client" }),
  awful.key({ modkey }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, { description = "(un)maximize", group = "client" }),
  awful.key({ modkey, "Control" }, "m", function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
  end, { description = "(un)maximize vertically", group = "client" }),
  awful.key({ modkey, "Shift" }, "m", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
  end, { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(
    globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end, { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end, { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end, { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end, { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

 -- {{{ Mouse bindings
 root.buttons(gears.table.join(
   awful.button({}, 3, function()
     mainmenu:toggle()
   end)
 ))
