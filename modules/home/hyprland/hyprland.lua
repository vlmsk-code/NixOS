hl.monitor({
	output = "eDP-1",
	mode = "2880x1800@120",
	position = "auto",
	scale = "1.8",
	vrr = true,
	bitdepth = 8,
	cm = "auto",
	sdrsaturation = 1,
	sdrbrightness = 1,
})
hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})
local terminal = "foot"
local fileManager = "thunar"
local menu = "noctalia msg panel-toggle launcher"
local browser = "zen"
local shell = "noctalia"

hl.on("hyprland.start", function()
	hl.exec_cmd(shell)
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("STEAM_FORCE_DESKTOPUI_SCALING", "1.8")

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 20,
		border_size = 2,
		col = {
			active_border = "rgba(a9a9a9aa)",
			inactive_border = "rgba(595959aa)",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 10,
		rounding_power = 2,
		-- active_opacity = 0.9,
		-- inactive_opacity = 0.9,
		fullscreen_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},
		blur = {
			enabled = true,
			size = 8,
			passes = 3,
			vibrancy = 0.1696,
		},
	},
	animations = {
		enabled = true,
	},
})

hl.curve("superSnap", { type = "bezier", points = { { 0.1, 1.0 }, { 0.1, 1.0 } } })
hl.curve("decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1.0 } } })

hl.animation({ leaf = "global", enabled = true, speed = 3, bezier = "decel" })
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "decel", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "decel", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, bezier = "superSnap" })
hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "decel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "superSnap", style = "fade" })

hl.config({
	dwindle = {
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
	scrolling = {
		fullscreen_on_one_column = true,
	},
	misc = {
		vrr = 1,
		disable_hyprland_logo = true,
		force_default_wallpaper = 3,
		background_color = 0xff000000,
		disable_splash_rendering = true,
	},
	input = {
		kb_layout = "us,ru",
		kb_options = "grp:caps_toggle,grp_led:caps",
		repeat_rate = 50,
		repeat_delay = 300,
		follow_mouse = 1,
		touchpad = {
			natural_scroll = true,
		},
	},
	cursor = {
		no_hardware_cursors = 1,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + SHIFT + S ", hl.dsp.exec_cmd("noctalia msg screenshot-region [widget-name]"))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("ALT + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia msg volume-up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia msg volume-down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("noctalia msg volume-mute"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("noctalia msg mic-mute"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("noctalia msg brightness-up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("noctalia msg brightness-down"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("noctalia msg media next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("noctalia msg media toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("noctalia msg media toggle"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("noctalia msg media previous"), { locked = true })

-- hl.bind("XF86PowerOff", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	name = "zen-browser",
	match = { class = "zen" },
	opaque = true,
})

-- hl.layer_rule({
-- 	name = "noctalia",
-- 	match = {
-- 		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$",
-- 	},
-- 	no_anim = true,
-- 	ignore_alpha = 0.5,
-- 	blur = true,
-- 	blur_popups = true,
-- })

require("noctalia").apply_theme()
