local gears = require("gears")
local awful = require("awful")
local theme = require("theme.theme")
local dpi = require("beautiful").xresources.apply_dpi
local naughty = require("naughty")
local wibox = require("wibox")
local helpers = require("helpers")

-- Notification center

-- Title
local notif_header = wibox.widget({
  markup = "<b>Notification Center</b>",
  font = theme.font .. " 12",
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox,
})

-- Clear button
local clear = wibox.widget({
  markup = "",
  font = theme.font .. " 24",
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox,
})

helpers.add_hover_cursor(clear, "hand1")

clear:buttons(gears.table.join(awful.button({}, 1, function()
  _G.reset_notif_container()
end)))

-- Empty notifications
local empty = wibox.widget({
  {
    {
      expand = "none",
      layout = wibox.layout.align.horizontal,
      nil,
      {
        markup = helpers.colorize_text("󰵚", theme.blue),
        font = theme.font .. " 45",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
      },
      nil,
    },
    {
      markup = helpers.colorize_text("No Notifications!", theme.blue),
      font = theme.font .. " 13",
      align = "center",
      valign = "center",
      widget = wibox.widget.textbox,
    },
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(5),
  },
  top = dpi(250),
  widget = wibox.container.margin,
})

-- Mouse scroll
local notif_container = wibox.layout.fixed.vertical()
notif_container.spacing = dpi(5)
notif_container.forced_width = dpi(270)

local remove_notif_empty = true

reset_notif_container = function()
  notif_container:reset(notif_container)
  notif_container:insert(1, empty)
  remove_notif_empty = true
end

remove_notifbox = function(box)
  notif_container:remove_widgets(box)

  if #notif_container.children == 0 then
    notif_container:insert(1, empty)
    remove_notif_empty = true
  end
end

-- notifications.
local create_notif = function(icon, n, width)
  local time = os.date("%H:%M")
  local box = {}

  local dismiss = wibox.widget({
    markup = helpers.colorize_text("", theme.blue),
    font = theme.font .. " 12",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox,
  })

  dismiss:buttons(gears.table.join(awful.button({}, 1, function()
    _G.remove_notifbox(box)
  end)))

  helpers.add_hover_cursor(dismiss, "hand1")

  box = wibox.widget({
    {
      {
        {
          {
            {
              {
                image = icon or theme.notifications,
                resize = true,
                clip_shape = helpers.rrect(dpi(8)),
                halign = "center",
                valign = "center",
                widget = wibox.widget.imagebox,
              },
              strategy = "exact",
              height = 40,
              width = 40,
              widget = wibox.container.constraint,
            },
            layout = wibox.layout.align.vertical,
          },
          left = dpi(10),
          right = dpi(4),
          top = dpi(16),
          bottom = dpi(12),
          widget = wibox.container.margin,
        },
        {
          {
            nil,
            {
              {
                {
                  step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
                  speed = 50,
                  {
                    markup = helpers.colorize_text(n.title, theme.blue),
                    font = theme.font .. " 11",
                    align = "left",
                    widget = wibox.widget.textbox,
                  },
                  forced_width = dpi(220),
                  widget = wibox.container.scroll.horizontal,
                },
                {
                  {
                    dismiss,
                    halign = "right",
                    widget = wibox.container.place,
                  },
                  left = dpi(10),
                  widget = wibox.container.margin,
                },
                layout = wibox.layout.fixed.horizontal,
              },
              {
                {
                  step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
                  speed = 50,
                  {
                    markup = n.message,
                    align = "left",
                    font = theme.font .. " 10",
                    widget = wibox.widget.textbox,
                  },
                  forced_width = dpi(205),
                  widget = wibox.container.scroll.horizontal,
                },
                {
                  {
                    markup = time,
                    align = "right",
                    valign = "bottom",
                    font = theme.font .. " 9",
                    widget = wibox.widget.textbox,
                  },
                  left = dpi(10),
                  widget = wibox.container.margin,
                },
                layout = wibox.layout.fixed.horizontal,
              },
              layout = wibox.layout.fixed.vertical,
            },
            nil,
            expand = "none",
            layout = wibox.layout.align.vertical,
          },
          margins = dpi(8),
          widget = wibox.container.margin,
        },
        layout = wibox.layout.align.horizontal,
      },
      top = dpi(2),
      bottom = dpi(2),
      widget = wibox.container.margin,
    },
    bg = theme.bg_alt,
    shape_border_width = dpi(1),
    shape_border_color = theme.bg_alt,
    shape = helpers.rrect(dpi(6)),
    widget = wibox.container.background,
  })

  return box
end

notif_container:buttons(gears.table.join(
  awful.button({}, 4, nil, function()
    if #notif_container.children == 1 then
      return
    end
    notif_container:insert(1, notif_container.children[#notif_container.children])
    notif_container:remove(#notif_container.children)
  end),

  awful.button({}, 5, nil, function()
    if #notif_container.children == 1 then
      return
    end
    notif_container:insert(#notif_container.children + 1, notif_container.children[1])
    notif_container:remove(1)
  end)
))

notif_container:insert(1, empty)

naughty.connect_signal("request::display", function(n)
  if #notif_container.children == 1 and remove_notif_empty then
    notif_container:reset(notif_container)
    remove_notif_empty = false
  end

  local notif_color = theme.bg_alt
  if n.urgency == "critical" then
    notif_color = theme.red .. "66"
  end
  local appicon = n.icon or n.app_icon
  if not appicon then
    appicon = theme.notification
  end

  notif_container:insert(1, create_notif(appicon, n, width))
end)

local notif_center = wibox.widget({
  {
    {
      notif_header,
      nil,
      clear,
      expand = "none",
      spacing = dpi(5),
      forced_height = dpi(30),
      layout = wibox.layout.align.horizontal,
    },
    left = dpi(5),
    right = dpi(5),
    bottom = dpi(15),
    top = dpi(5),
    layout = wibox.container.margin,
  },
  notif_container,
  layout = wibox.layout.fixed.vertical,
})

notifs = wibox({
  type = "dock",
  width = dpi(350),
  height = awful.screen.focused().geometry.height - dpi(120),
  --height = awful.screen.focused().geometry.height - dpi(50),
  screen = screen.primary,
  shape = helpers.rrect(),
  ontop = true,
  visible = false,
})

awful.placement.top_right(notifs, {
  honor_workarea = true,
  margins = { top = dpi(40), right = dpi(10) },
})

local notifs_status = false

notifs.visible = false

function notifs_toggle()
  if notifs.visible == false then
    notifs.visible = true
    notifs_timer:start()
  else
    notifs.visible = false
  end
end

notifs_timer = gears.timer({
  timeout = 16,
  single_shot = true,
  callback = function()
    notifs.visible = false
  end,
})

notifs:setup({
  notif_center,
  margins = dpi(15),
  widget = wibox.container.margin,
})
