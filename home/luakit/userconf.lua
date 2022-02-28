--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--  User config.  Be sure to require() any modules you desire access to.

print(os.clock(), "loading userconf.lua")

local window = require("window")
local webview = require("webview")

local downloads = require("downloads")
local settings = require("settings")

local modes = require("modes")
local binds = require("binds")

local noscript = require("noscript") --  Toggle JS &/or plugins on a per-domain basis.
local lousy = require("lousy") --  Library.Of.Useful.Stuff.You can use in luakit
local widgets = require("lousy.widget")

local styles = require("styles")
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

settings.window.home_page = "$HOME/.config/luakit/newtab.html"
settings.window.new_window_size = "1920x1080"

--  Whether JavaScript will be able to create & run modal dialogs
settings.webview.allow_modal_dialogs = true
settings.webview.auto_load_images = true
--  favicons
settings.webview.load_icons_ignoring_image_load_setting = true

settings.webview.enable_media_stream = true
--  settings .webview .media_playback_requires_gesture  = true

settings.webview.minimum_font_size = 10
settings.webview.enable_fullscreen = false
settings.webview.enable_developer_extras = true
settings.webview.enable_xss_auditor = true --  cross-scripting

settings.webview.enable_java = true
settings.webview.enable_javascript = true
settings.webview.javascript_can_access_clipboard = true
settings.webview.javascript_can_open_windows_automatically = true

settings.webview.enable_webgl = true
--settings.webview.hardware_acceleration_policy = 'never'
settings.webview.enable_accelerated_2d_canvas = true

--  user-agents.net
local UA = "Mozilla/5.0 (Linux i686) AppleWebKit/535.22+ (KHTML, like Gecko) WebKitGTK+/2.2.0 luakit"
local alt_UA = "Mozilla/5.0 (X11; Linux x86_32) Gecko/20100101 Firefox/69.0 r/theyknew"

local twitter_UA =
	"Mozilla/5.0 (X11; Linux x86_32) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Mobile Safari/537.36"

local android_UA =
	"Mozilla/5.0 (Linux; Android 9; SM-G973F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Mobile Safari/537.36"

local alt_tor = "Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0"

settings.webview.user_agent = UA
settings.webview.zoom_level = 100

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

noscript.enable_scripts = true
noscript.enable_plugins = true

--  allow access to audio & video devices for capture.
--  settings .on['discord.com'] .webview .enable_media_stream = true

--  twitter is a bitch & cries about your browser type
settings.on["twitter.com"].webview.user_agent = twitter_UA
settings.on["mobile.twitter.com"].webview.user_agent = twitter_UA

--  appear mobile
settings.on["instagram.com"].webview.user_agent = android_UA
settings.on["m.youtube.com"].webview.user_agent = android_UA
settings.on["www.youtube.com"].webview.user_agent = android_UA

--  Example using xdg-open for opening downloads /showing download folders
downloads.add_signal(
	"open-file",
	function(file)
		local str = "xdg-open %q"
		luakit.spawn(str:format(file))
		return true
	end
)

downloads.default_dir = os.getenv("HOME") .. "/Downloads"

--  default D/L location w/o asking?  luakit.github.io/docs/pages/02-faq.html
downloads.add_signal(
	"download-location",
	function(uri, file)
		if not file or file == "" then
			file = (uri:match("/([^/]+)$") or uri:match("^%w+://(.+)") or uri:gsub("/", "_") or "untitled")
		end
		return downloads.default_dir .. "/" .. file
	end
)

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--  tabs to destroy, such as adblocked content that you have no desre to interact with

local begins = {"adblock-blocked:"}
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

webview.add_signal(
	"init",
	function(view) --  during initialization of a new tab
		--  open certain schemes w/ other apps?  luakit.github.io/docs/pages/02-faq.html
		view:add_signal(
			"navigation-request",
			function(v, uri, reason)
				--  return  false  to prevent requested navigation from taking place
				local low = uri:lower()

				if low:match("youtube%.com/%?app=desktop") then
					return false --  no redirects from mobile
				elseif low:match("www%.reddit%.com/chat/minimize") then
					return false --  skip reddit's slow-@ss chat
				elseif
					low:match("%.webv") or low:match("%.gifv") or low:match("%.mp4") or low:match("%.avi") or low:match("v%.redd%.it/") or
						low:match("gfycat%.com/") or
						low:match("%.redgifs%.com/") or
						low:match("%.xvideos%.com/") or
						low:match("clipwatching%.com/")
				 then
					--  https://github.com/ytdl-org/youtube-dl/blob/master/docs/supportedsites.md
					local str = "youtube-dl -o '~/Videos/%%(title)s_%%(id)s.%%(ext)s' %q"
					print(os.clock(), str:format(uri))
					luakit.spawn(str:format(uri))
					return false
				elseif low:match("^magnet:") then
					local str = "transmission-gtk %q"
					print(os.clock(), str:format(uri))
					luakit.spawn(str:format(uri))
					return false
				end --  if low ...
			end
		) --  view :add_signal( 'navigation-request',  ... )
	end
) --  window .add_signal( 'init',  ... )

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

modes.add_binds(
	"normal",
	{
		{
			"<Control-c>",
			"Copy selected text.",
			function()
				luakit.selection.clipboard = luakit.selection.primary
			end
		}
	}
)

--  combination 'R' to reload Userstyles & current webpage
modes.add_binds(
	"normal",
	{
		{
			"<Shift-r>",
			"combination Reload",
			function(window)
				window:notify("Reloading Userstyles...")
				styles.detect_files()
				window:notify("Reloading Userstyles complete, loading webpage now...")
				window:reload()
			end
		}
	}
) --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--  print right-click menu

webview.add_signal(
	"init",
	function(v)
		v:add_signal(
			"populate-popup",
			function(_, menu)
				for key, val in pairs(menu) do
					print(key, val)
				end
			end
		)
	end
)

print(os.clock(), "userconf loaded ")

--  eof  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
