pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Miscellanous awesome library
local menubar = require("menubar")

RC = {} -- global namespace, on top before require any modules
RC.vars = require("main.user-variables")
modkey = RC.vars.modkey

-- Error handling
require("main.error-handling")

-- Themes
require("main.theme")

-- -- --

-- Calling All Module Libraries

-- Custom Local Library
local main = {
  layouts = require("main.layouts"),
  tags    = require("main.tags"),
  menu    = require("main.menu"),
  rules   = require("main.rules"),
}

-- Custom Local Library: Keys and Mouse Binding
local binding = {
  globalbuttons = require("binding.globalbuttons"),
  clientbuttons = require("binding.clientbuttons"),
  globalkeys    = require("binding.globalkeys"),
  clientkeys    = require("binding.clientkeys"),
  bindtotags    = require("binding.bindtotags")
}

-- Layouts
RC.layouts = main.layouts()

-- Tags
RC.tags = main.tags()

-- Menu
RC.mainmenu = awful.menu({ items = main.menu() }) -- in globalkeys
RC.launcher = awful.widget.launcher(
  { image = beautiful.awesome_icon, menu = RC.mainmenu }
)
menubar.utils.terminal = RC.vars.terminal

-- Mouse and Key bindings
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)

-- Set root
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()
-----------------------------------------------------
---------------     Wibar      ------------------
-----------------------------------------------------

-- Statusbar: Wibar
require("deco.statusbar")
-----------------------------------------------------
---------------    Notifications    -----------------
-----------------------------------------------------

require("deco.notifications")
-----------------------------------------------------
---------------     Rules      ----------------------
-----------------------------------------------------

awful.rules.rules = main.rules(
  binding.clientkeys(),
  binding.clientbuttons()
)

-----------------------------------------------------
---------------     Signals      --------------------
-----------------------------------------------------

-- Signals
require("main.signals")

-----------------------------------------------------
---------------     Autostart      ------------------
-----------------------------------------------------
awful.spawn.with_shell("~/.config/awesome/autorun.sh")

awful.spawn.with_shell("numlockx on")


-----------------------------------------------------
------------    Garbage Collection   ----------------
-----------------------------------------------------
 collectgarbage("setpause", 160)
 collectgarbage("setstepmul", 400)

 --collectgarbage("setpause", 110)
 --collectgarbage("setstepmul", 1000)

