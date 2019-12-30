local wibox = require("wibox")
local gears = require("gears")
local theme_name = "ectoplasmatic"
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local layout_icon_path ="/usr/share/awesome/themes/default/layouts"
local titlebar_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/titlebar/"
local taglist_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/taglist/"
local tip = titlebar_icon_path --alias to save time/space
local xrdb = xresources.get_current_theme()
 local theme = dofile(themes_path.."default/theme.lua")
local theme = {}

 theme.tip = titlebar_icon_path -- NOT local so that scripts can access it

-- This is used to make it easier to align the panels in specific monitor positions
local awful = require("awful")
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

-- Set theme wallpaper.
-- It won't change anything if you are using feh to set the wallpaper like I do.
theme.wallpaper = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/wallpaper.jpg"
-- A blurred version of your wallpaper would be nice
theme.wallpaper_lock = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/wallpaper_lock.jpg"

-- Set the theme font. This is the font that will be used by default in menus, bars, titlebars etc.
-- theme.font          = "sa fsns 11"
theme.font          = "Source Code Pro Black 13"

theme.awesome_icon = os.getenv("HOME") .. "/.config/awesome/themes/ectoplasmatic/awesome_icon.png"
-- Get colors from .Xresources and set fallback colors
theme.xbackground = "#1D1F28" -- black-ish with navy vlue tone
theme.xforeground = "#E5E5E5" -- white/grey
theme.xcolor0 = "#282A36"  -- black-ish with blue tone
theme.xcolor1 = "#F48FB1" -- light red
theme.xcolor2 = "#5ADECD" --  light blue
theme.xcolor3 = "#FFCB6B" -- orange
theme.xcolor4 = "#82AAFF"  -- baby blue
theme.xcolor5 = "#BD99FF" -- purple
theme.xcolor6 = "#24D1E7" -- teal
theme.xcolor7 = "#D2D3D5" -- gray
theme.xcolor8 = "#323F4E" -- black-ish
theme.xcolor9 = "#EE4F84" -- rich red
theme.xcolor10 = "#A1EEFD" -- pastel light blue
theme.xcolor11 = "#F8F880" -- yellow
theme.xcolor12 = "#56687E" -- blue gray
theme.xcolor13 = "#985EFF" -- royal purple
theme.xcolor14 = "#87DFEB" -- yet another light blue
theme.xcolor15 = "#707C8D" -- vallejo gray (707)
theme.xcolor16 = "#848D9A" -- yet another gray tone
theme.xcolor17 = "#3D4C5F" -- blue-black (deepest blue)
theme.xcolor18 = "#8777BC" -- lavender

-- This is how to get other .Xresources values (beyond colors 0-15, or custom variables)
-- local cool_color = awesome.xrdb_get_value("", "color16")

theme.bg_dark       = theme.xbackground
theme.bg_normal     = theme.xcolor0
theme.bg_focus      = theme.xcolor17
theme.bg_urgent     = theme.xcolor8
theme.bg_minimize   = theme.xforeground .. '77'
theme.bg_systray    = theme.xcolor9

theme.fg_normal     = theme.xcolor8
theme.fg_focus      = theme.xcolor4
theme.fg_urgent     = theme.xcolor3
theme.fg_minimize   = theme.xcolor8

-- Gaps
theme.useless_gap   = dpi(7)
-- This could be used to manually determine how far away from the
-- screen edge the bars / notifications should be.
theme.screen_margin = dpi(10)

-- Borders
theme.border_width  = dpi(2)
 theme.border_color = theme.xcolor0
theme.border_normal = theme.xbackground
theme.border_focus  = theme.xbackground
-- Rounded corners
theme.border_radius = dpi(0)

-- Titlebars
-- (Titlebar items can be customized in titlebars.lua)
theme.titlebars_enabled = true
theme.titlebar_size = dpi(32)
theme.titlebar_title_enabled = true
theme.titlebar_font = "Source Code Pro Semibold 14"
-- Window title alignment: left, right, center
theme.titlebar_title_align = "left"
-- Titlebar position: top, bottom, left, right
theme.titlebar_position = "top"
-- Use 4 titlebars around the window to imitate borders
theme.titlebars_imitate_borders = false
theme.titlebar_bg = theme.xbackground .. "77"
theme.titlebar_bg_focus = "#56687E"
theme.titlebar_bg = theme.xbackground .. "77"
theme.titlebar_fg_focus = theme.foreground
theme.titlebar_fg_normal = theme.xcolor8
theme.titlebar_fg = theme.xcolor7

-- Notifications
-- ============================
-- Note: Some of these options are ignored by my custom
-- notification widget_template
-- ============================
-- Position: bottom_left, bottom_right, bottom_middle,
--         top_left, top_right, top_middle
theme.notification_position = "top_left"
theme.notification_border_width = dpi(2)
theme.notification_border_radius = theme.border_radius
theme.notification_border_color = theme.xcolor10
theme.notification_bg = theme.xbackground
theme.notification_bg = theme.xcolor8
theme.notification_fg = theme.xforeground
theme.notification_crit_bg = theme.xbackground
theme.notification_crit_fg = theme.xcolor1
theme.notification_icon_size = dpi(60)
theme.notification_height = dpi(80)
theme.notification_width = dpi(300)
theme.notification_margin = dpi(16)
theme.notification_opacity = 0.85
theme.notification_font = "Source Code Pro Semibold 11"
theme.notification_padding = theme.screen_margin * 2
theme.notification_spacing = theme.screen_margin * 2

-- Edge snap
theme.snap_shape = gears.shape.rectangle
theme.snap_bg = theme.xforeground
theme.snap_border_width = dpi(3)

-- Tag names
theme.tagnames = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
}

-- Widget separator
theme.separator_text = "|"
--theme.separator_text = " :: "
--theme.separator_text = " • "
-- theme.separator_text = " •• "
theme.separator_fg = theme.xcolor8

-- Wibar(s)
-- (Bar items can be customized in bar_themes/<bar_theme>.lua)
-- Keep in mind that these settings could be ignored by the bar theme
theme.wibar_position = "bottom"
theme.wibar_height = dpi(36)
theme.wibar_fg = theme.xcolor7
theme.wibar_bg = theme.xbackground
theme.wibar_opacity = 0.95
theme.wibar_border_color = theme.xcolor0
theme.wibar_border_width = dpi(2)
theme.wibar_border_radius = dpi(0)
theme.wibar_width = screen_width - theme.screen_margin * 4 -theme.wibar_border_width * 2
--theme.wibar_width = dpi(700)
--theme.wibar_x = screen_width / 2 - theme.wibar_width - theme.screen_margin * 2
--theme.wibar_x = theme.screen_margin * 2
--theme.wibar_x = screen_width - theme.wibar_width - theme.wibar_border_width * 2 - theme.screen_margin * 2
theme.wibar_y = theme.screen_margin * 2

theme.prefix_fg = theme.xcolor8

 --There are other variable sets
 --overriding the default one when
 --defined, the sets are:
 --taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
 --tasklist_[bg|fg]_[focus|urgent]
 --titlebar_[bg|fg]_[normal|focus]
 --tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
 --mouse_finder_[color|timeout|animate_timeout|radius|factor]
 --prompt_[fg|bg|fg_cursor|bg_cursor|font]
 --hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
 --Example:
--theme.taglist_bg_focus = "#ff0000"

 --Tasklist
theme.tasklist_font = "Source Code Pro Black 13"
theme.tasklist_disable_icon = false
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = theme.xcolor0
theme.tasklist_fg_focus = theme.xforeground
theme.tasklist_bg_normal = "#1D1F28"
theme.tasklist_fg_normal = theme.xforeground.."77"
theme.tasklist_bg_minimize = "#1D1F28"
theme.tasklist_fg_minimize = theme.xforeground
theme.tasklist_font_minimized = "Source Code Pro Italic 13e"
theme.tasklist_bg_urgent = theme.xbackground
theme.tasklist_fg_urgent = theme.xcolor3
theme.tasklist_spacing = dpi(0)
theme.tasklist_align = "left"
theme.tasklist_opacity_minimized = 0.7
-- Sidebar
-- (Sidebar items can be customized in sidebar.lua)
theme.sidebar_bg = theme.xbackground
theme.sidebar_fg = theme.xcolor7
theme.sidebar_opacity = 0.9
theme.sidebar_position = "right" -- left or right
theme.sidebar_width = dpi(300)
theme.sidebar_height = screen_height
theme.sidebar_x = 0
theme.sidebar_y = 0
theme.sidebar_border_radius = 0
theme.sidebar_border_radius = theme.border_radius

-- Exit screen
theme.exit_screen_bg = theme.xcolor0 .. "CC"
theme.exit_screen_fg = theme.xcolor7
theme.exit_screen_font = "Source Code Pro Black  20"
theme.exit_screen_icon_size = dpi(180)

-- Lock screen
theme.lock_screen_bg = theme.xcolor0 .. "CC"
theme.lock_screen_fg = theme.xcolor7


-- Noodle Text Taglist
theme.taglist_fg_focus    = theme.xcolor6
theme.taglist_fg_occupied = theme.xcolor4
theme.taglist_fg_urgent   = theme.xcolor1
theme.taglist_fg_empty    = "#56687E"
theme.taglist_spacing     = 5
theme.taglist_font = "awesomewm-font 20"



-- Prompt
theme.prompt_fg = theme.xcolor13
theme.taglist_disable_icon = true
theme.taglist_spacing = dpi(1)
theme.taglist_item_roundness = dpi(0)
-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_focus
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming the menu:
-- theme.menu_submenu_icon = icons.submenu
theme.menu_height = dpi(55)
theme.menu_width  = dpi(180)
theme.menu_bg_normal = theme.xcolor0
theme.menu_fg_normal= theme.xcolor7
theme.menu_bg_focus = theme.xcolor8
theme.menu_fg_focus= theme.xcolor7
theme.menu_border_width = dpi(3)
theme.menu_border_color = theme.xcolor0

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"


-- Hotkeys Pop Up
theme.hotkeys_fg = theme.xforeground
theme.hotkeys_bg = theme.xbackground
theme.hotkeys_border_width = dpi(2)
theme.hotkeys_label_fg = theme.xcolor0
theme.hotkeys_modifiers_fg = theme.xcolor14


-- Titlebar buttons
-- Define the images to load
theme.titlebar_close_button_normal = tip .. "close_normal.svg"
theme.titlebar_close_button_focus  = tip .. "close_focus.svg"
theme.titlebar_minimize_button_normal = tip .. "minimize_normal.svg"
theme.titlebar_minimize_button_focus  = tip .. "minimize_focus.svg"
theme.titlebar_ontop_button_normal_inactive = tip .. "ontop_normal_inactive.svg"
theme.titlebar_ontop_button_focus_inactive  = tip .. "ontop_focus_inactive.svg"
theme.titlebar_ontop_button_normal_active = tip .. "ontop_normal_active.svg"
theme.titlebar_ontop_button_focus_active  = tip .. "ontop_focus_active.svg"
theme.titlebar_sticky_button_normal_inactive = tip .. "sticky_normal_inactive.svg"
theme.titlebar_sticky_button_focus_inactive  = tip .. "sticky_focus_inactive.svg"
theme.titlebar_sticky_button_normal_active = tip .. "sticky_normal_active.svg"
theme.titlebar_sticky_button_focus_active  = tip .. "sticky_focus_active.svg"
theme.titlebar_floating_button_normal_inactive = tip .. "floating_normal_inactive.svg"
theme.titlebar_floating_button_focus_inactive  = tip .. "floating_focus_inactive.svg"
theme.titlebar_floating_button_normal_active = tip .. "floating_normal_active.svg"
theme.titlebar_floating_button_focus_active  = tip .. "floating_focus_active.svg"
theme.titlebar_maximized_button_normal_inactive = tip .. "maximized_normal_inactive.svg"
theme.titlebar_maximized_button_focus_inactive  = tip .. "maximized_focus_inactive.svg"
theme.titlebar_maximized_button_normal_active = tip .. "maximized_normal_active.svg"
theme.titlebar_maximized_button_focus_active  = tip .. "maximized_focus_active.svg"
-- (hover)
theme.titlebar_close_button_normal_hover = tip .. "close_normal_hover.svg"
theme.titlebar_close_button_focus_hover  = tip .. "close_focus_hover.svg"
theme.titlebar_minimize_button_normal_hover = tip .. "minimize_normal_hover.svg"
theme.titlebar_minimize_button_focus_hover  = tip .. "minimize_focus_hover.svg"
theme.titlebar_ontop_button_normal_inactive_hover = tip .. "ontop_normal_inactive_hover.svg"
theme.titlebar_ontop_button_focus_inactive_hover  = tip .. "ontop_focus_inactive_hover.svg"
theme.titlebar_ontop_button_normal_active_hover = tip .. "ontop_normal_active_hover.svg"
theme.titlebar_ontop_button_focus_active_hover  = tip .. "ontop_focus_active_hover.svg"
theme.titlebar_sticky_button_normal_inactive_hover = tip .. "sticky_normal_inactive_hover.svg"
theme.titlebar_sticky_button_focus_inactive_hover  = tip .. "sticky_focus_inactive_hover.svg"
theme.titlebar_sticky_button_normal_active_hover = tip .. "sticky_normal_active_hover.svg"
theme.titlebar_sticky_button_focus_active_hover  = tip .. "sticky_focus_active_hover.svg"
theme.titlebar_floating_button_normal_inactive_hover = tip .. "floating_normal_inactive_hover.svg"
theme.titlebar_floating_button_focus_inactive_hover  = tip .. "floating_focus_inactive_hover.svg"
theme.titlebar_floating_button_normal_active_hover = tip .. "floating_normal_active_hover.svg"
theme.titlebar_floating_button_focus_active_hover  = tip .. "floating_focus_active_hover.svg"
theme.titlebar_maximized_button_normal_inactive_hover = tip .. "maximized_normal_inactive_hover.svg"
theme.titlebar_maximized_button_focus_inactive_hover  = tip .. "maximized_focus_inactive_hover.svg"
theme.titlebar_maximized_button_normal_active_hover = tip .. "maximized_normal_active_hover.svg"
theme.titlebar_maximized_button_focus_active_hover  = tip .. "maximized_focus_active_hover.svg"

-- You can use your own layout icons like this:
theme.layout_fairh = "/usr/share/awesome/themes/default/layouts/fairh.png"
theme.layout_fairv = "/usr/share/awesome/themes/default/layouts/fairv.png"
theme.layout_floating  = "/usr/share/awesome/themes/default/layouts/floating.png"
theme.layout_magnifier = "/usr/share/awesome/themes/default/layouts/magnifier.png"
theme.layout_max = "/usr/share/awesome/themes/default/layouts/max.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/default/layouts/fullscreen.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/default/layouts/tilebotto.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/default/layouts/tileleft.png"
theme.layout_tile = "/usr/share/awesome/themes/default/layouts/tile.png"
theme.layout_tiletop = "/usr/share/awesome/themes/default/layouts/tiletop.png"
theme.layout_spiral  = "/usr/share/awesome/themes/default/layouts/spiral.png"
theme.layout_dwindle = "/usr/share/awesome/themes/default/layouts/dwindle.png"
theme.layout_cornernw = "/usr/share/awesome/themes/default/layouts/cornernw.png"
theme.layout_cornerne = "/usr/share/awesome/themes/default/layouts/cornerne.png"
theme.layout_cornersw = "/usr/share/awesome/themes/default/layouts/cornersw.png"
theme.layout_cornerse = "/usr/share/awesome/themes/default/layouts/cornerse.png"

-- Recolor layout icons
theme = theme_assets.recolor_layout(theme, theme.xcolor1)

-- Noodle widgets customization --
-- Desktop mode widget variables
-- Symbols     
 theme.desktop_mode_color_floating = theme.xcolor4
 theme.desktop_mode_color_tile = theme.xcolor3
 theme.desktop_mode_color_max = theme.xcolor1


-- Minimal tasklist widget variables
theme.minimal_tasklist_visible_clients_color = theme.xcolor4
theme.minimal_tasklist_visible_clients_text = ""
theme.minimal_tasklist_hidden_clients_color = theme.xcolor7
theme.minimal_tasklist_hidden_clients_text = ""

-- Volume bar
theme.volume_bar_active_color = theme.xcolor6
theme.volume_bar_active_background_color = theme.xcolor0
theme.volume_bar_muted_color = theme.xcolor8
theme.volume_bar_muted_background_color = theme.xcolor0

-- Temperature bar
theme.temperature_bar_active_color = theme.xcolor1
theme.temperature_bar_background_color = theme.xcolor0

-- Battery bar
theme.battery_bar_active_color = theme.xcolor5
theme.battery_bar_background_color = theme.xcolor0

-- CPU bar
theme.cpu_bar_active_color = theme.xcolor2
theme.cpu_bar_background_color = theme.xcolor0

-- RAM bar
theme.ram_bar_active_color = theme.xcolor4
theme.ram_bar_background_color = theme.xcolor0

-- Brightness bar
theme.brightness_bar_active_color = theme.xcolor3
theme.brightness_bar_background_color = theme.xcolor0

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
-   theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/Suru++"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
