
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gears = require("gears")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local beautiful = require("beautiful")

-- Inherit default theme
local themes_path = require("gears.filesystem").get_themes_dir()


-- font
theme.font          = "FuraMono NF Medium 11"


-- Load ~/.Xresources colors and set fallback colors
theme.xbackground = "#17161B"
theme.xforeground = xrdb.foreground or "#DEE6E7"
theme.xcolor0 = xrdb.color0 or "#24262A"
theme.xcolor1 = xrdb.color1 or "#F0719B"
theme.xcolor2 = xrdb.color2 or "#5AF7B0"
theme.xcolor3 = xrdb.color3 or "#FFA56B"
theme.xcolor4 = xrdb.color4 or "#2196F3"
theme.xcolor5 = xrdb.color5 or "#C792EA"
theme.xcolor6 = xrdb.color6 or "#89DDFF"
theme.xcolor7 = xrdb.color7 or "#DEE6E7"
theme.xcolor8 = xrdb.color8 or "#4E515B"
theme.xcolor9 = xrdb.color9 or "#F02E6E"
theme.xcolor10 = xrdb.color10 or "#2CE592"
theme.xcolor11 = xrdb.color11 or "#FF8537"
theme.xcolor12 = xrdb.color12 or "#1DA0E2"
theme.xcolor13 = xrdb.color13 or "#A742EA"
theme.xcolor14 = xrdb.color14 or "#47BAE8"
theme.xcolor15 = xrdb.color15 or "#DEE6E7"
theme.xcolor16 = "#282A33"

theme.bg_normal     = theme.xbackground
theme.bg_focus      = theme.xcolor0 
theme.bg_urgent     = theme.xcolor0
theme.bg_minimize   = theme.xcolor0
theme.bg_systray    = theme.xcolor0

theme.fg_normal     = theme.xforeground
theme.fg_focus      = theme.xcolor4
theme.fg_urgent     = theme.xcolor1
theme.fg_minimize   = theme.xforeground

theme.useless_gap   = dpi(8)
theme.border_width  = dpi(7)

theme.border_normal = theme.xcolor0
theme.border_focus  = theme.xcolor4
theme.border_marked = theme.xcolor4

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]


-- Tasklist
-- tasklist_[bg|fg]_[focus|urgent]
theme.tasklist_font = "FuraMono NF Medium 9"
theme.tasklist_bg_focus = theme.xbackground
theme.tasklist_fg_focus = theme.xforeground
theme.tasklist_bg_urgent = theme.xbackground
theme.tasklist_fg_urgent = theme.xcolor1
theme.tasklist_bg_normal = theme.xbackground
theme.tasklist_fg_normal = theme.xcolor7
theme.tasklist_shape = gears.shape.square
theme.tasklist_shape_border_width = 0
theme.tasklist_align = "left"
theme.tasklist_font_focus = "FuraMono NF Medium 11"
theme.tasklist_spacing = 10

-- Titlebars
-- titlebar_[bg|fg]_[normal|focus]
theme.titlebar_bg_focus = theme.xcolor0
theme.titlebar_bg_normal = theme.xbackground
theme.titlebar_fg_focus = theme.xforeground
theme.titlebar_fg_normal = theme.xcolor16

-- Tooltips
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
theme.tooltip_fg = theme.fg_normal
theme.tooltip_bg = theme.bg_normal
theme.tooltip_font = "FuraMono NF Medium 11"
theme.tooltip_border_width = dpi(3)
theme.tooltip_border_color = xcolor4

-- Notifications
theme.notification_position = "top_right"
theme.notification_border_width = dpi(3)
theme.notification_border_radius = theme.border_radius
theme.notification_border_color = theme.xcolor0
theme.notification_bg = theme.xcolor4
theme.notification_fg = theme.xcolor7
theme.notification_crit_bg = theme.xcolor9
theme.notification_crit_fg = theme.xcolor0
theme.notification_opacity = 1
theme.notification_font = theme.font
theme.notification_icon_size_normal = 50
theme.notification_icon_size_selected = 50
theme.notification_margin = dpi(3)
theme.notification_font = "FuraMono NF Medium 11"

-- Edge snap
theme.snap_bg = theme.xcolor4
theme.snap_shape = gears.shape.rounded_rect

-- Prompts
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
theme.prompt_bg = theme.xcolor0
theme.prompt_fg = theme.xforeground
theme.prompt_fg_cursor = theme.xcolor7
theme.prompt_bg_cursor = theme.xcolor7
theme.prompt_font = "FuraMono NF Bold 11"
-- Menu
theme.menu_bg_focus = theme.xcolor0
theme.menu_fg_focus = theme.xcolor4
theme.menu_bg_normal = theme.xbackground
theme.menu_fg_normal = theme.xcolor7
--theme.menu_submenu_icon = "~/.config/awesome/themes/clone/icons/Suru/terminus.svg"
theme.menu_height = dpi(50)
theme.menu_width  = dpi(280)
theme.menu_border_color  = theme.xcolor4
theme.menu_border_width  = dpi (3)
theme.menu_font = "FuraMono NF Medium 9"


-- Hotkeys Popup
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
theme.hotkeys_bg = theme.xbackground
theme.hotkeys_fg = theme.xcolor7
theme.hotkeys_border_width = dpi(3)
theme.hotkeys_shape = gears.shape.rounded_rect
theme.hotkeys_labal_fg = theme.xcolor4
theme.hotkeys_border_color = theme.xcolor4
theme.hotkeys_modifiers_fg = theme.xcolor4
theme.hotkeys_label_bg = theme.xcolor1
theme.hotkeys_label_fg = theme.xcolor0
theme.hotkeys_font = "FuraMono NF Bold 9"
theme.hotkeys_description_font = "FuraMono NF Medium 8"
theme.hotkeys_group_margin = 2

-- Taglist
theme.taglist_font = "awesomewm-font 25"
theme.taglist_bg = theme.xbackground
theme.taglist_shape = gears.shape.rounded_rect
theme.taglist_bg_focus = theme.xforeground
theme.taglist_fg_focus = theme.xbackground
theme.taglist_bg_urgent = theme.xcolor1
theme.taglist_fg_urgent = theme.xbackground
theme.taglist_bg_occupied = theme.xcolor0
theme.taglist_fg_occupied = theme.xforeground
theme.taglist_bg_empty = theme.xbackground
theme.taglist_fg_empty = theme.xcolor16
theme.taglist_bg_volatile = theme.xcolor0
theme.taglist_fg_volatile = theme.xcolor3




-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

--Icon Theme 
theme.icon_theme = "/usr/share/icons/Suru++"
--theme.icon_theme = home .. "/.icons/Suru++"

