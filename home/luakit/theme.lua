--------------------------
-- Default luakit theme --
--------------------------

local theme = {}

-- Default settings
theme.font = "12px SFMono Nerd Font Mono Heavy"
theme.fg   = "#f4f4f7"
theme.bg   = "#17191e"

-- Genaral colours
theme.success_fg = "#00ffcc"
theme.loaded_fg  = "#44ddff"
theme.error_fg = "#22262d62d"
theme.error_bg = "#FF00AA"

-- Warning colours
theme.warning_fg = "#17191e"
theme.warning_bg = "#f4f4f7"

-- Notification colours
theme.notif_fg = "#e9efff"
theme.notif_bg = "#22262d"

-- Menu colours
theme.menu_fg                   = "#b2bfd9"
theme.menu_bg                   = "#17191e"
theme.menu_selected_fg          = "#17191e"
theme.menu_selected_bg          = "#0badff"
theme.menu_title_bg             = "#2f303d"
theme.menu_primary_title_fg     = "#b2bfd9"
theme.menu_secondary_title_fg   = "#8b9cbe"

theme.menu_disabled_fg = "#8b9cbe"
theme.menu_disabled_bg = theme.menu_bg
theme.menu_enabled_fg = theme.menu_fg
theme.menu_enabled_bg = theme.menu_bg
theme.menu_active_fg = "#f4f4f7"
theme.menu_active_bg = theme.menu_bg

-- Proxy manager
theme.proxy_active_menu_fg      = '#f4f4f7'
theme.proxy_active_menu_bg      = '#17191e'
theme.proxy_inactive_menu_fg    = '#b2bfd9'
theme.proxy_inactive_menu_bg    = '#2f303d'

-- Statusbar specific
theme.sbar_fg         = "#f4f4f8"
theme.sbar_bg         = "#17191e"

-- Downloadbar specific
theme.dbar_fg         = "#f4f4f8"
theme.dbar_bg         = "#17191e"
theme.dbar_error_fg   = "#8265ff"

-- Input bar specific
theme.ibar_fg           = "#17191e"
theme.ibar_bg           = "rgba(0,0,0,0)"

-- Tab label
theme.tab_fg            = "#e9efff"
theme.tab_bg            = "#22262d"
theme.tab_hover_bg      = "#292929"
theme.tab_ntheme        = "#ddd"
theme.selected_fg       = "#f4f4f8"
theme.selected_bg       = "#17191e"
theme.selected_ntheme   = "#ddd"
theme.loading_fg        = "#33AADD"
theme.loading_bg        = "#17191e"

theme.selected_private_tab_bg = "#3d295b"
theme.private_tab_bg    = "#22262d"

-- Trusted/untrusted ssl colours
theme.trust_fg          = "#00ffcc"
theme.notrust_fg        = "#FF00AA"

-- Follow mode hints
theme.hint_font = "10px monospace, courier, sans-serif"
theme.hint_fg = "#f4f4f8"
theme.hint_bg = "#17191e088"
theme.hint_border = "1px dashed #17191e"
theme.hint_opacity = "0.3"
theme.hint_overlay_bg = "rgba(255,255,153,0.3)"
theme.hint_overlay_border = "1px dotted #17191e"
theme.hint_overlay_selected_bg = "rgba(0,255,0,0.3)"
theme.hint_overlay_selected_border = theme.hint_overlay_border

-- General colour pairings
theme.ok = { fg = "#17191e", bg = "#f4f4f8" }
theme.warn = { fg = "#F00", bg = "#f4f4f8" }
theme.error = { fg = "#f4f4f8", bg = "#F00" }

-- Gopher page style (override defaults)
theme.gopher_light = { bg = "#17191e", fg = "#e9efff", link = "#00caff" }
theme.gopher_dark  = { bg = "#17191e", fg = "#e9efff", link = "#8265ff" }

return theme

-- vim: et:sw=4:ts=8:sts=4:tw=80
