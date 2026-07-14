-- Ported from hyprland1.conf and modules/*.conf.

local mainMod = "SUPER"
local monitor = "DP-1"

local function exec_once(cmd)
	hl.on("hyprland.start", function()
		hl.exec_cmd(cmd)
	end)
end

----------------
-- Monitors
----------------

require("modules/resolution")

---------------
--- Envs ------
---------------

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

----------------
-- Autostart
----------------

-- exec_once("dbus-update-activation-environment --systemd --all")
-- exec_once("dms run")
-- exec_once("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
exec_once("nm-applet")
exec_once("systemctl --user start hyprpolkitagent")
exec_once(
	"dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
)
exec_once("uwsm-app -- hypridle")
exec_once("uwsm-app -- mako")
exec_once(
	"uwsm-app -- waybar -c ~/repos/dotfiles/cfg/hypr/waybar/config.jsonc -s ~/repos/dotfiles/cfg/hypr/waybar/style.css"
)
exec_once("wl-paste --type text --watch cliphist store")
exec_once("wl-paste --type image --watch cliphist store")
exec_once("hyprctl setcursor Bibata-Modern-Ice 24")
exec_once("hyprsunset")
exec_once("hyprpaper")

----------------
-- Config
----------------

local activeBorderColor = "rgb(82aaff)"
local inactiveBorderColor = "rgba(595959aa)"

hl.config({
	input = {
		kb_layout = "us,br",
		kb_variant = "intl,",
		kb_model = "",
		kb_options = "grp:shifts_toggle,lv3:ratl_switch,ctrl:nocaps",
		kb_rules = "",
		repeat_rate = 50,
		repeat_delay = 300,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
			disable_while_typing = true,
			clickfinger_behavior = true,
			middle_button_emulation = false,
			tap_to_click = true,
		},
	},

	gestures = {
		workspace_swipe_min_speed_to_force = 4,
		workspace_swipe_create_new = false,
		workspace_swipe_forever = true,
	},

	general = {
		gaps_in = 3,
		gaps_out = 10,
		border_size = 4,
		col = {
			active_border = activeBorderColor,
			inactive_border = inactiveBorderColor,
		},
		layout = "master",
	},

	decoration = {
		rounding = 10,
		shadow = {
			enabled = true,
			range = 2,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 7,
			passes = 3,
			ignore_opacity = true,
			noise = 0.08,
			contrast = 1.5,
			xray = false,
			new_optimizations = true,
		},
	},

	group = {
		col = {
			border_active = activeBorderColor,
			border_inactive = inactiveBorderColor,
		},
		groupbar = {
			font_size = 12,
			font_family = "monospace",
			font_weight_active = "ultraheavy",
			font_weight_inactive = "normal",
			indicator_height = 0,
			indicator_gap = 5,
			height = 22,
			gaps_in = 5,
			gaps_out = 0,
			text_color = "rgb(ffffff)",
			text_color_inactive = "rgba(ffffff90)",
			col = {
				active = "rgba(00000040)",
				inactive = "rgba(00000020)",
			},
			gradients = true,
			gradient_rounding = 0,
			gradient_round_only_edges = false,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	scrolling = {
		fullscreen_on_one_column = true,
		explicit_column_widths = "0.333, 0.5, 0.667, 1.0",
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		focus_on_activate = true,
		anr_missed_pings = 3,
		on_focus_under_fullscreen = true,
	},
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = false, speed = 0, bezier = "ease" })

----------------
-- Workspaces
----------------

for i = 1, 10 do
	hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1", default = i == 1 })

	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + Escape", hl.dsp.focus({ workspace = "previous" }))

----------------
-- Binds
----------------

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd("dms restart"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("fuzzel"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("~/.local/bin/niri-resolution"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker --autocopy"))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("kitty --class floating.kitty"))

-- hl.bind(mainMod .. "N", hl.dsp.)

hl.bind(mainMod .. " + CTRL + code:21", hl.dsp.exec_cmd("~/.local/bin/volume --inc_mic"))
hl.bind(mainMod .. " + CTRL + code:20", hl.dsp.exec_cmd("~/.local/bin/volume --dec_mic"))

hl.bind(mainMod .. " + CTRL + 0", hl.dsp.exec_cmd("~/.local/bin/volume --toggle_mic"))

hl.bind(mainMod .. " + SHIFT + code:21", hl.dsp.exec_cmd("~/.local/bin/brightness --inc"))
hl.bind(mainMod .. " + SHIFT + code:20", hl.dsp.exec_cmd("~/.local/bin/brightness --dec"))

hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("~/.local/bin/screenshot"))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd("~/.local/bin/screenshot --area"))

hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd("~/.local/bin/powermenu"))
hl.bind(
	mainMod .. " + CTRL + Y",
	hl.dsp.exec_cmd("killall waybar && waybar -c ~/.config/hypr/waybar/config.jsonc -s ~/.config/hypr/waybar/style.css")
)
--
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("~/.local/bin/clip"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("bemoji"))
-- hl.bind(mainMod .. " + CTRL + Y", hl.dsp.exec_cmd("~/.local/bin/on-off -y"))
-- hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("~/.local/bin/on-off -b"))
-- hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd("~/.local/bin/on-off -w"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.local/bin/volume --inc"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.local/bin/volume --dec"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.local/bin/volume --toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl --class=backlight set +10%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl --class=backlight set 10%-"))
hl.bind("Print", hl.dsp.exec_cmd("~/.local/bin/screenshot"))

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exit())
hl.bind(
	mainMod .. " + CTRL + Q",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

-- hl.bind(mainMod .. " + A", hl.dsp.workspace.)
hl.bind(mainMod .. " + D", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + A", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Rezise Submap
-- hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
--
-- -- Start a submap called "resize".
-- hl.define_submap("resize", function()
-- 	-- Set repeating binds for resizing the active window.
-- 	hl.bind("l", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
-- 	hl.bind("h", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
-- 	hl.bind("k", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
-- 	hl.bind("j", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
--
-- 	-- Use `reset` to go back to the global submap
-- 	hl.bind("escape", hl.dsp.submap("reset"))
-- end)

hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:276", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse:275", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:music" }))
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("music"))

hl.bind(mainMod .. " + SHIFT + W", hl.dsp.window.move({ workspace = "special:clock" }))
hl.bind(mainMod .. " + W", hl.dsp.workspace.toggle_special("clock"))

-- Scrolling
hl.bind(mainMod .. " + T", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.layout("colresize -conf"))

-- hl.bind(mainMod .. " + period", hl.dsp.layout("move +col"))
-- hl.bind(mainMod .. " + comma", hl.dsp.layout("swapcol l"))

-- Groups

hl.bind(mainMod .. " + CTRL + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + ALT + G", hl.dsp.window.move({ out_of_group = true }))

hl.bind(mainMod .. " + ALT + TAB", hl.dsp.group.next())
hl.bind(mainMod .. " + ALT + SHIFT + TAB", hl.dsp.group.prev())

hl.bind(mainMod .. " + ALT + H", hl.dsp.window.move({ into_group = "l" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.move({ into_group = "r" }))
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.move({ into_group = "u" }))
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.move({ into_group = "d" }))

for index = 1, 5 do
	hl.bind(mainMod .. " + ALT + code:" .. tostring(index + 9), hl.dsp.group.active({ index = index }))
end

----------------
-- Workspace rules
----------------
hl.workspace_rule({ workspace = "1", persistent = true, monitor = monitor, layout = "scrolling" })
hl.workspace_rule({ workspace = "2", persistent = true, monitor = monitor })
hl.workspace_rule({ workspace = "3", persistent = true, monitor = monitor })
hl.workspace_rule({ workspace = "4", persistent = true, monitor = monitor })
hl.workspace_rule({ workspace = "5", persistent = true, monitor = monitor })
hl.workspace_rule({ workspace = "6", persistent = true, monitor = monitor, layout = "scrolling" })
hl.workspace_rule({ workspace = "7", persistent = true, monitor = monitor })
hl.workspace_rule({ workspace = "8", persistent = true, monitor = monitor })
hl.workspace_rule({ workspace = "9", persistent = true, monitor = monitor })

----------------
-- Window rules
----------------

-- hl.window_rule({ name = "steam-last-workspace", match = { class = "^(steam)$" }, workspace = "8" })
hl.window_rule({ name = "obsidian", match = { class = "^(obsidian)$" }, opacity = 0.96, no_screen_share = true })
hl.window_rule({ name = "terminal", match = { class = "^(kitty)$" }, opacity = 0.96 })
hl.window_rule({ name = "zen-pip", match = { class = "zen$", title = "^Picture-in-Picture$" }, float = true })
hl.window_rule({ name = "shotcut", match = { class = "^(org\\.shotcut\\.Shotcut)$" }, maximize = true })
hl.window_rule({ name = "kdenlive", match = { class = "^(org\\.kde\\.kdenlive)$" }, maximize = true })
hl.window_rule({
	name = "pavu",
	match = { class = "^(org.pulseaudio.pavucontrol)$" },
	-- size = "1200 800",
	size = { "monitor_w * 0.4", "monitor_h * 0.6" },
	float = true,
	center = true,
})
hl.window_rule({
	name = "virt-manager",
	match = { class = "virt-manager" },
	-- size = "1200 800",
	size = { "monitor_w * 0.4", "monitor_h * 0.6" },
	float = true,
	center = true,
})
hl.window_rule({
	name = "clock",
	match = { class = "^(org\\.gnome\\.clocks)$" },
	-- size = "1600 1200",
	size = { "monitor_w * 0.4", "monitor_h * 0.6" },
	float = true,
	center = true,
	workspace = "special:clock",
})
hl.window_rule({
	name = "localsend",
	match = { class = "localsend" },
	size = { "monitor_w * 0.2", "monitor_h * 0.4" },
	float = true,
	center = true,
})
hl.window_rule({ name = "mpv", match = { class = "mpv" }, float = true, center = true })
hl.window_rule({
	name = "satty",
	match = { class = "^(com\\.gabm\\.satty)$" },
	float = true,
	center = true,
	-- size = "1200 800",
	size = { "monitor_w * 0.4", "monitor_h * 0.6" },
})
hl.window_rule({
	name = "nautilus",
	match = { class = "^(org\\.gnome\\.Nautilus)$" },
	float = true,
	center = true,
	-- size = "1200 800",
	size = { "monitor_w * 0.3", "monitor_h * 0.5" },
})
hl.window_rule({
	name = "Floating terminal",
	match = { class = "floating.kitty" },
	float = true,
	center = true,
	-- size = "1200 800",
	size = { "monitor_w * 0.4", "monitor_h * 0.6" },
})
hl.window_rule({
	name = "Qbittorrent",
	match = { class = "^(org\\.qbittorrent\\.qBittorrent)$" },
	float = true,
	center = true,
	-- size = "1200 800",
	size = { "monitor_w * 0.4", "monitor_h * 0.6" },
})
hl.window_rule({
	name = "Bitwarden",
	match = { class = "^(Bitwarden)$" },
	float = true,
	center = true,
	-- size = "1600 1200",
	size = { "monitor_w * 0.4", "monitor_h * 0.6" },
	no_screen_share = true,
})
hl.window_rule({
	name = "Youtube Music",
	match = { class = "^(com.github.th-ch.youtube-music)$" },
	float = true,
	center = true,
	-- size = "1600 1200",
	size = { "monitor_w * 0.5", "monitor_h * 0.6" },
	workspace = "special:music",
})
