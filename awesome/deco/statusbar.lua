-- Standard awesome library
local gears = require("gears")
local awful     = require("awful")
local beautiful = require("beautiful")
-- Wibox handling library
local wibox = require("wibox")

-- Custom Local Library: Common Functional Decoration
local deco = {
  wallpaper = require("deco.wallpaper"),
  taglist   = require("deco.taglist"),
  tasklist  = require("deco.tasklist"),

}
local calendar_widget = require("deco.calendar")
local vicious = require("vicious")
require("main.menu")
local taglist_buttons  = deco.taglist()
local tasklist_buttons = deco.tasklist()

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Wibar
-- memory widget
memwidget = wibox.widget.textbox()
vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem, "<span color='#939597'>RAM:</span> $1% <span color='#282A33'>|</span> ", 15)

-- cpu widget
cpuwidget = wibox.widget.textbox()
vicious.cache(vicious.widgets.cpu)
vicious.register(cpuwidget, vicious.widgets.cpu, "<span color='#282A33'> ||| </span><span color='#939597'> CPU:</span> $1% <span color='#282A33'>|</span> ", 15)

--filesystem widget
fswidget = wibox.widget.textbox()
vicious.register(fswidget, vicious.widgets.fs, "<span color='#939597'>HDD:</span> ${/ avail_gb} GB Left <span color='#282A33'>|||</span> ")



-- Create a textclock widget
mytextclock = wibox.widget.textclock()
local cw = calendar_widget({
    placement = 'bottom_right'
})
mytextclock:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)
awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))

  -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        layout   = {
           spacing = 15,
	  padding = 8,
           margins = 15,
	  bottom = 15,
	  top = 15,
           valign = 'center',
           halign = 'center',          
            layout  = wibox.layout.flex.horizontal
        },
    }


   -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        style    = {
            shape_border_width = 3,
            shape_border_color = beautiful.xcolor0,
            shape  = gears.shape.bar,
        },
        layout   = {
            spacing = 1,
            spacing_widget = {
                {
                    forced_width = 100,
            shape  = gears.shape.square,
                    color        = beautiful.xbackground,
                    widget       = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            layout  = wibox.layout.flex.horizontal
        },
        }
  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s, height = 40, ontop = true })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
     expand = "none",
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
    --z  mylauncher,
        s.mypromptbox,
       cpuwidget,
        memwidget,
        fswidget,

    },
    {-- Middle widgets

   {
     s.mytaglist,
     widget = wibox.container.margin,
                  },
                  bg = beautiful.taglist_bg,
                  shape = gears.shape.rounded_rect,
                  align = "center",
                  widget = wibox.container.background,
                  margins = 2,
                  top = 5,
                  bottom = 5,
                  padding = 1,
},
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      --s.mylayoutbox,

    },
    margin = 15,
  }
  s.mywibox2 = awful.wibar({ position = "bottom", screen = s, height = 30, ontop = true })

    -- Add widgets to the wibox
    s.mywibox2:setup {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        mylauncher,
        s.mypromptbox,
        spacing = 30,
      },
         { -- Middle widget
                s.mytasklist,
                -- Add top and bottom margins to force text to one line
                widget = wibox.container.margin,
            },
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        spacing = 10,
        mytextclock,
        s.mylayoutbox,
      },
      bottom = 10,
      margin = 10,
      top = 10,
      right = 10,
      left = 10,

    }
end)
-- }}}
