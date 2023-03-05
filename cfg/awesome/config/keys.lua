local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local applications = require("config.applications")
local user_likes = require("user_vars")
local vol = require("lib.volume")
local volume = require("ui.bar.volume")
local screenshot = require("lib.screenshot")
local updates = require("lib.updates")

local isDark = true
require("awful.autofocus")
require("ui.power_popup")
require("ui.dashboard")
require("ui.notification_center")
local modkey = "Mod4"

awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { modkey },
    key = "s",
    description = "Show Help",
    group = "Awesome",
    on_press = hotkeys_popup.show_help,
  }),
  awful.key({
    modifiers = { modkey },
    key = "a",
    description = "View Previous",
    group = "Tag",
    on_press = awful.tag.viewprev,
  }),
  awful.key({
    modifiers = { modkey },
    key = "d",
    description = "View Next",
    group = "Tag",
    on_press = awful.tag.viewnext,
  }),
  awful.key({
    modifiers = { modkey },
    key = "Escape",
    description = "Go Back",
    group = "Tag",
    on_press = awful.tag.history.restore,
  }),
  awful.key({
    modifiers = { modkey },
    key = "j",
    description = "Focus Next by Index",
    group = "Client",
    on_press = function()
      awful.client.focus.byidx(1)
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "k",
    description = "Focus Previous by Index",
    group = "Client",
    on_press = function()
      awful.client.focus.byidx(-1)
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "w",
    description = "Show Main Menu",
    group = "Awesome",
    on_press = function()
      mainmenu:show()
    end,
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "j",
    description = "Swap With Next Client by Index",
    group = "Client",
    on_press = function()
      awful.client.swap.byidx(1)
    end,
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "k",
    description = "Swap With Previous Client by Index",
    group = "Client",
    on_press = function()
      awful.client.swap.byidx(-1)
    end,
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    key = "j",
    description = "Focus the Next Screen",
    group = "Screen",
    on_press = function()
      awful.screen.focus_relative(1)
    end,
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    key = "k",
    description = "Focus the Previous Screen",
    group = "Screen",
    on_press = function()
      awful.screen.focus_relative(-1)
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "g",
    description = "Jump to Urgent Client",
    group = "Client",
    on_press = function()
      awful.client.urgent.jumpto()
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "Return",
    description = "Open a Terminal",
    group = "Applications",
    on_press = function()
      awful.spawn(applications.default.terminal_emulator)
    end,
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    key = "r",
    description = "Reload Awesome",
    group = "Awesome",
    on_press = awesome.restart,
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    key = "d",
    description = "Open Dashboard",
    group = "User",
    on_press = function()
      dashboard_show()
    end,
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    key = "p",
    description = "Open Exit Screen",
    group = "User",
    on_press = function()
      power_popup_show()
    end,
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    key = "n",
    description = "Notification Center",
    group = "User",
    on_press = function()
      notifs_toggle()
    end,
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    key = "w",
    description = "Set a Random Wallpaper",
    group = "User",
    on_press = function()
      local feh_cmd = "feh --no-fehbg --bg-scale --randomize --no-xinerama"
      awful.spawn.with_shell(feh_cmd .. " " .. tostring(user_likes.user.wallpapers_dir))
    end,
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    key = "q",
    description = "Quit Awesome",
    group = "Awesome",
    on_press = awesome.quit,
  }),
  awful.key({
    modifiers = { modkey },
    key = "l",
    description = "Increase Master Width",
    group = "Layout",
    on_press = function()
      awful.tag.incmwfact(0.05)
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "h",
    description = "Decrease Master Width",
    group = "Layout",
    on_press = function()
      awful.tag.incmwfact(-0.05)
    end,
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "h",
    description = "Increase the Number of Master Clients",
    group = "Layout",
    on_press = function()
      awful.tag.incnmaster(1, nil, true)
    end,
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "l",
    description = "Decrease the Number of Master Clients",
    group = "Layout",
    on_press = function()
      awful.tag.incnmaster(-1, nil, true)
    end,
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    key = "h",
    description = "Increase the Number of Columns",
    group = "Layout",
    on_press = function()
      awful.tag.incncol(1, nil, true)
    end,
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    key = "l",
    description = "Decrease the Number of Columns",
    group = "Layout",
    on_press = function()
      awful.tag.incncol(-1, nil, true)
    end,
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "n",
    description = "Restored Minimized",
    group = "Client",
    on_press = function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
      end
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "r",
    description = "Application Launcher",
    group = "Applications",
    on_press = function()
      awful.util.spawn(applications.default.app_launcher)
      -- menubar.show()
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "e",
    description = "Rofi-Emoji",
    group = "User",
    on_press = function()
      awful.util.spawn("rofi -show emoji")
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "i",
    description = "Fullscreen Screenshot",
    group = "User",
    on_press = function()
      awful.util.spawn(screenshot.full())
    end,
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    key = "i",
    description = "Area Screenshot",
    group = "User",
    on_press = function()
      awful.util.spawn(screenshot.area())
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "u",
    description = "Checkupdates",
    group = "User",
    on_press = function()
      awful.util.spawn(updates.num())
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "=",
    description = "Volume +",
    group = "User",
    on_press = function()
      awful.util.spawn(vol.increase())
      volume.get_vol()
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "-",
    description = "Volume -",
    group = "User",
    on_press = function()
      awful.util.spawn(vol.decrease())
      volume.get_vol()
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "0",
    description = "Mute/Desmute",
    group = "User",
    on_press = function()
      awful.util.spawn(vol.mute())
      volume.get_vol()
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = ";",
    description = "Playerctl Play-Pause",
    group = "User",
    on_press = function()
      awful.util.spawn("playerctl play-pause")
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = ".",
    description = "Playerctl Next",
    group = "User",
    on_press = function()
      awful.util.spawn("playerctl next")
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = ",",
    description = "Playerctl Previous",
    group = "User",
    on_press = function()
      awful.util.spawn("playerctl previous")
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "b",
    description = "Browser",
    group = "Applications",
    on_press = function()
      awful.util.spawn(applications.default.browser)
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "p",
    description = "File Manager",
    group = "Applications",
    on_press = function()
      awful.util.spawn(applications.default.file_manager)
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "y",
    description = "Toggle Wibar",
    group = "Awesome",
    on_press = function()
      visibility = not visibility
      awful.screen.focused().mywibox.visible = visibility
    end,
  }),
  awful.key({
    modifiers = { modkey },
    key = "x",
    description = "Switch Color Temperature",
    group = "User",
    on_press = function()
      isDark = not isDark
      if isDark then
        awful.spawn("redshift -P -O 4800")
      else
        awful.spawn("redshift -P -O 5800")
      end
    end,
  }),
})

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    awful.key({
      modifiers = { modkey },
      key = "f",
      description = "Toggle Fullscreen",
      group = "Client",
      on_press = function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
    }),
    awful.key({
      modifiers = { modkey, "Shift" },
      key = "c",
      description = "Close",
      group = "Client",
      on_press = function(c)
        c:kill()
      end,
    }),
    awful.key({
      modifiers = { modkey, "Control" },
      key = "space",
      description = "Toggle Floating",
      group = "Client",
      on_press = awful.client.floating.toggle,
    }),
    awful.key({
      modifiers = { modkey },
      key = "o",
      description = "Move to Screen",
      group = "Client",
      on_press = function(c)
        c:move_to_screen()
      end,
    }),
    awful.key({
      modifiers = { modkey },
      key = "t",
      description = "Toggle Keep On Top",
      group = "Client",
      on_press = function(c)
        c.ontop = not c.ontop
      end,
    }),
    awful.key({
      modifiers = { modkey },
      key = "n",
      description = "Minimize",
      group = "Client",
      on_press = function(c)
        c.minimized = true
      end,
    }),
    awful.key({
      modifiers = { modkey },
      key = "m",
      description = "(Un)maximize",
      group = "Client",
      on_press = function(c)
        c.maximized = not c.maximized
        c:raise()
      end,
    }),
    awful.key({
      modifiers = { modkey, "Control" },
      key = "m",
      description = "(Un)maximize Verticaly",
      group = "Client",
      on_press = function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
      end,
    }),
    awful.key({
      modifiers = { modkey, "Shift" },
      key = "m",
      description = "(Un)maximize Horizontally",
      group = "Client",
      on_press = function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
      end,
    }),
  })
end)

awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { modkey },
    keygroup = "numrow",
    description = "Only View Tag",
    group = "Tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only(tag)
      end
    end,
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    keygroup = "numrow",
    description = "Move Focused Client to Tag",
    group = "Tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    keygroup = "numrow",
    description = "Toggle Tag",
    group = "Tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  }),
})

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c)
      c:activate({ context = "mouse_click" })
    end),
    awful.button({ modkey }, 1, function(c)
      c.floating = true
      c:activate({ context = "mouse_click", action = "mouse_move" })
    end),
    awful.button({ modkey }, 3, function(c)
      c:activate({ context = "mouse_click", action = "mouse_resize" })
    end),
  })
end)

awful.mouse.append_global_mousebindings({
  awful.button({}, 3, function()
    mainmenu:toggle()
  end),
  awful.button({}, 4, awful.tag.viewprev),
  awful.button({}, 5, awful.tag.viewnext),
})
