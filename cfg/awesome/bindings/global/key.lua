local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

local mod = require("bindings.mod")

awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { mod.super },
    key = "s",
    description = "Show Help",
    group = "Awesome",
    on_press = hotkeys_popup.show_help,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "a",
    desription = "View Previous",
    group = "Tag",
    on_press = awful.tag.viewprev,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "d",
    description = "View Next",
    group = "Tag",
    on_press = awful.tag.viewnext,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "Left",
    description = "View Previous",
    group = "Tag",
    on_press = awful.tag.viewprev,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "Right",
    description = "View Next",
    group = "Tag",
    on_press = awful.tag.viewnext,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "Escape",
    description = "Go Back",
    group = "Tag",
    on_press = awful.tag.history.restore,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "j",
    description = "Focus Next by Index",
    group = "Client",
    on_press = function()
      awful.client.focus.byidx(1)
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "k",
    description = "Focus Previous by Index",
    group = "Client",
    on_press = function()
      awful.client.focus.byidx(-1)
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "w",
    description = "Show Main Menu",
    group = "Awesome",
    on_press = function()
      mainmenu:show()
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.shift },
    key = "j",
    description = "Swap With Next Client by Index",
    group = "Client",
    on_press = function()
      awful.client.swap.byidx(1)
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.shift },
    key = "k",
    description = "Swap With Previous Client by Index",
    group = "Client",
    on_press = function()
      awful.client.swap.byidx(-1)
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.ctrl },
    key = "j",
    description = "Focus the Next Screen",
    group = "Screen",
    on_press = function()
      awful.screen.focus_relative(1)
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.ctrl },
    key = "k",
    description = "Focus the Previous Screen",
    group = "Screen",
    on_press = function()
      awful.screen.focus_relative(-1)
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "g",
    description = "Jump to Urgent Client",
    group = "Client",
    on_press = function()
      awful.client.urgent.jumpto()
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.ctrl },
    key = "r",
    description = "Reload Awesome",
    group = "Awesome",
    on_press = awesome.restart,
  }),
  awful.key({
    modifiers = { mod.super, mod.ctrl },
    key = "q",
    description = "Quit Awesome",
    group = "Awesome",
    on_press = awesome.quit,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "l",
    description = "Increase Master Width",
    group = "Layout",
    on_press = function()
      awful.tag.incmwfact(0.05)
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "h",
    description = "Decrease Master Width",
    group = "Layout",
    on_press = function()
      awful.tag.incmwfact(-0.05)
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.shift },
    key = "h",
    description = "Increase the Number of Master Clients",
    group = "Layout",
    on_press = function()
      awful.tag.incnmaster(1, nil, true)
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.shift },
    key = "l",
    description = "Decrease the Number of Master Clients",
    group = "Layout",
    on_press = function()
      awful.tag.incnmaster(-1, nil, true)
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.ctrl },
    key = "h",
    description = "Increase the Number of Columns",
    group = "Layout",
    on_press = function()
      awful.tag.incncol(1, nil, true)
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.ctrl },
    key = "l",
    description = "Decrease the Number of Columns",
    group = "Layout",
    on_press = function()
      awful.tag.incncol(-1, nil, true)
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.shift },
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
    modifiers = { mod.super },
    key = "y",
    description = "Toggle Wibar",
    group = "Awesome",
    on_press = function()
      visibility = not visibility
      awful.screen.focused().mywibox.visible = visibility
    end,
  }),

  awful.key({
    modifiers = { mod.super },
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
    modifiers = { mod.super, mod.shift },
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
    modifiers = { mod.super, mod.ctrl },
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
