-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

local scratch = require("scratch")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")
-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.spiral,
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

mySeparator = wibox.widget.textbox("<span color=\"#555555\"> │ </span>")

-- {{{ Wibar

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
						s.mytaglist,
						mySeparator,
            s.mylayoutbox,
						mySeparator,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- mykeyboardlayout,
						mySeparator,
						-- awful.widget.watch('bash -c "sensors | grep temp1"', 15),
						-- awful.widget.watch(amixer sget Master, 5),
						-- awful.widget.watch('bash -c "sensors | grep temp1"', 15),
						-- wibox.widget.textbox("<span color=\"#ff5555\"> 0 </span>"),
						-- wibox.widget.textclock("<span color=\"#50fa7b\">%F </span>%H:%M",10),
            -- wibox.widget{
-- markup = "<span foreground='#ff0kjf'>'" .. awful.widget.watch('cpu', 1) .. "'</span>",
                -- markup = "<span color=\"#ff79c6\">" .. stdout .. "</span>",
-- markup = "<span foreground='" .. beautiful.border_focus .."'>Lembretes</span>",
                -- markup = "<span color=\"#ff79c6\">" .. stdout .. "</span>",
                -- align  = "center",
                -- valign = "center",
                -- widget = awful.widget.watch('cpu', 1) 
            -- },
						-- awful.widget.watch('sensors', 15, function(widget, stdout)
							 -- for line in stdout:gmatch("[^\r\n]+") do
								 -- if line:match("temp1") then
									 -- widget:set_text(line)
									 -- return
								 -- end
							 -- end
						 -- end),
						awful.widget.watch('mailbox', 30),
						mySeparator,
						awful.widget.watch('localip', 10),
						mySeparator,
						awful.widget.watch('curl ipinfo.io/ip', 10),
						mySeparator,
						awful.widget.watch('trafdown', 1),
						mySeparator,
						awful.widget.watch('trafup', 1),
						mySeparator,
            awful.widget.watch('cpu', 1),
-- wibox.container.background (awful.widget.watch('cpu', 1)),
            -- wibox.widget {
              -- widget = wibox.widget.textbox,
              -- font = "Cabin 13",
              -- align = "center",
              -- valign = "center",
              -- text = "test",
              -- color = "8be9fd",
            -- },
						mySeparator,
						awful.widget.watch('battery', 30),
						mySeparator,
						awful.widget.watch('disk', 10),
						mySeparator,
						-- awful.widget.watch('nettraf', 5),
						-- mySeparator,
						awful.widget.watch('memory', 10),
						mySeparator,
						awful.widget.watch('volume', 10),
						mySeparator,
						-- wibox.widget.textbox("<span color=\"#ff79c6\">0 </span>"),
						-- wibox.widget.textbox("<span color=\"#8be9fd\">0 </span>"),
						-- wibox.widget.textbox("<span color=\"#50fa7b\">0 </span>"),
						-- wibox.widget.textbox("<span color=\"#f1fa8c\">0 </span>"),
						-- wibox.widget.textbox("<span color=\"#bd93f9\">0</span>"),
						wibox.widget.textclock("%F %H:%M ",10),
            wibox.widget.systray(),
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(

		-- Flexbindings launch programs
		awful.key({modkey}, "Return", function () awful.util.spawn("dmenu_run") end),
		awful.key({modkey}, "n", function () awful.util.spawn_with_shell("cd ~/Dropbox/NOTES/; alacritty -t VimWiki -e nvim -c VimwikiIndex") end),
		awful.key({modkey, "Shift" }, "n", function () awful.util.spawn_with_shell("cd ~/Dropbox/NOTES/; alacritty -t VimWiki -e nvim ~/Dropbox/NOTES/TODO.md") end),
		awful.key({modkey}, "m", function () awful.util.spawn_with_shell("mullvadconnect") end),
		awful.key({modkey, "Shift" }, "m", function () awful.util.spawn_with_shell("mullvaddisconnect") end),
		awful.key({modkey}, "r", function () awful.util.spawn("alacritty -t Newsboat -e newsboat") end),
		awful.key({modkey}, "q", function () awful.util.spawn("qjackctl") end),
		awful.key({modkey, "Shift" }, "Return", function () awful.util.spawn("alacritty -t ZSH -e zsh") end),
    awful.key({modkey, "Shift" }, "comma", function () awful.util.spawn("alacritty -t Vifm -e vifmrun") end),
		-- awful.key({modkey, "Shift" }, "comma", function () awful.util.spawn("alacritty -t Ranger -e ranger") end),
		awful.key({modkey, "Shift" }, "period", function () awful.util.spawn("brave") end),
		awful.key({modkey, "Control", "Shift" }, "period", function () awful.util.spawn("brave https://youtube.com") end),
		awful.key({modkey}, "p", function () awful.util.spawn("passmenu") end),
		awful.key({modkey}, "e", function () awful.util.spawn_with_shell("cd ~/Downloads/; alacritty -t Neomutt -e neomutt") end),
		awful.key({modkey, "Shift"}, "t", function () awful.util.spawn("alacritty -t Telegram -e tg") end),
		awful.key({modkey, "Control", "Shift"}, "l", function () awful.util.spawn("slock") end),
		awful.key({modkey, "Shift"}, "c", function () awful.util.spawn("alacritty -t Calcurse -e calcurse") end),
		awful.key({modkey}, "t", function () awful.util.spawn("alacritty -t Htop -e htop") end),
		awful.key({modkey, "Shift"}, "s", function () awful.util.spawn("alacritty -t SC-IM -e sc-im") end),
		awful.key({modkey, "Shift"}, "x", function () awful.util.spawn("xkill") end),
		awful.key({modkey,"Control", "Shift"}, "comma", function () awful.util.spawn("thunar" ) end),
		awful.key({modkey}, "F3", function () awful.util.spawn("displayselect") end),
    awful.key({modkey}, "F4", function () awful.util.spawn("alacritty -t PulseMixer -e pulsemixer") end),
    awful.key({modkey, "Shift"}, "F4", function () awful.util.spawn("alacritty -t AlsaMixer -e alsamixer") end),
		awful.key({modkey}, "F6", function () awful.util.spawn("torwrap") end),
		awful.key({modkey}, "F7", function () awful.util.spawn("td-toggle") end),
		awful.key({modkey}, "F9", function () awful.util.spawn("dmenumount") end),
		awful.key({modkey}, "F10", function () awful.util.spawn("dmenuumount") end),
    awful.key({modkey}, "Up", function () awful.util.spawn_with_shell("cpuperformance") end),
    awful.key({modkey}, "Down", function () awful.util.spawn_with_shell("cpupowersave") end),

		-- Flexbindings HID control
		awful.key({}, "#122", function () awful.util.spawn("pamixer --allow-boost -d 3") end),
    awful.key({}, "#123", function () awful.util.spawn("pamixer --allow-boost -i 3") end),
    awful.key({}, "#121", function () awful.util.spawn("pamixer -t") end),
    awful.key({}, "#232", function () awful.util.spawn_with_shell("xbacklight -dec $(bc <<< \"$(xbacklight) * 0.5\")") end),
    awful.key({}, "#233", function () awful.util.spawn_with_shell("xbacklight -inc $(bc <<< \"$(xbacklight) * 0.5 + 0.15\")") end),
    awful.key({}, "#233", function () awful.util.spawn_with_shell("xbacklight -inc $(bc <<< \"$(xbacklight) * 0.5 + 0.15\")") end),
    awful.key({modkey}, "b", function () awful.util.spawn_with_shell("bluetoothconnect 74:5C:4B:D2:86:F7") end),
    awful.key({modkey, "Shift"}, "b", function () awful.util.spawn("bluetoothctl disconnect 74:5C:4B:D2:86:F7") end),

		-- Flexbindings audio and media
		awful.key({"Control", "Shift"}, "Return", function () awful.util.spawn("deadbeef") end),
		awful.key({"Control", "Shift"}, "j", function () awful.util.spawn("musicnext") end),
		awful.key({"Control", "Shift"}, "k", function () awful.util.spawn("musicprev") end),
		awful.key({"Control", "Shift"}, "q", function () awful.util.spawn("deadbeef --quit") end),
		awful.key({"Control", "Shift"}, "space", function () awful.util.spawn("musicplaypause") end),
		awful.key({modkey, "Shift"}, "p", function () awful.util.spawn("pulseeffects") end),

		-- Flexbindings youtube-dl
		awful.key({modkey}, "y", function () awful.util.spawn("ytfzf -Df") end, {description = "search youtube and choose format", group = "flexbindings"}),
		awful.key({"Control", "Shift"}, "y", function () awful.util.spawn("ytfzf -DH") end),
		awful.key({modkey, "Shift"}, "y", function () awful.util.spawn("ytfzf -D") end),
		awful.key({modkey,"Control", "Shift"}, "y", function () awful.util.spawn_with_shell("cd ~/Downloads/VIDEO/; ytfzf -Dd") end),
		awful.key({modkey}, "s", function () awful.util.spawn("supercollider") end),
		-- awful.key({modkey}, "m", function () awful.util.spawn("ytfzf -Dm") end),
		-- awful.key({modkey,"Control", "Shift"}, "m", function () awful.util.spawn_with_shell("cd ~/Downloads; ytfzf -Dmd") end),
		awful.key({modkey}, "d", function () awful.util.spawn_with_shell("sleep 0.2 && xdotool type --clearmodifiers \"$(date +\"%F \")\"") end),
		awful.key({modkey, "Shift"}, "i", function () awful.util.spawn("xcalib -invert -alter") end),
		awful.key({}, "Print", function () awful.util.spawn_with_shell("maim -f jpg -m 9 \"/home/flex/Pictures/SCREENSHOTS/$(date +\"%F %H_%M_%S.jpg\")\"") end),
		awful.key({ "Shift"}, "Print", function () awful.util.spawn_with_shell("maim -f jpg -m 9 -s \"/home/flex/Pictures/SCREENSHOTS/$(date +\"%F %H_%M_%S.jpg\")\"") end),
		awful.key({modkey,"Control", "Shift"}, "p",	function () awful.util.spawn("poweroff") end),
		awful.key({modkey,"Control", "Shift"}, "r",	function () awful.util.spawn("reboot") end),
		awful.key({modkey, "Shift"}, "Up", function () awful.util.spawn("xdotool keydown --clearmodifiers w") end),
		awful.key({modkey, "Shift"}, "Down", function () awful.util.spawn("xdotool keydown shift w") end),

		-- other
    -- awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              -- {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              -- {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    -- awful.key({ modkey,           }, "Tab",
        -- function ()
            -- awful.client.focus.history.previous()
            -- if client.focus then
                -- client.focus:raise()
            -- end
        -- end,
        -- {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "Tab", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "Tab", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    -- awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              -- {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "[", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey }, "w",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Shift" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey }, "space", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    -- awful.key({ modkey, "Control", "Shift" }, "m",
    awful.key({ modkey, "Control", "Shift" }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control", "Shift" }, "=",
    -- awful.key({ modkey, "Control" }, "m",
        function (c)

            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
										 -- tasklist_disable_icon = true
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          -- "DTA",  -- Firefox addon DownThemAll.
          -- "copyq",  -- Includes session name in class.
          -- "pinentry",
        },
        class = {
          -- "Arandr",
          -- "Blueman-manager",
          -- "Gpick",
          -- "Kruler",
          -- "MessageWin",  -- kalarm.
          -- "Sxiv",
          -- "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          -- "Wpa_gui",
          -- "veromix",
          -- "xtightvncviewer"
				},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          -- "Event Tester",  -- xev.
        },
        role = {
          -- "AlarmWindow",  -- Thunderbird's calendar.
          -- "ConfigManager",  -- Thunderbird's about:config.
          -- "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Force clients to behave normally
    { rule_any = {
        instance = {
        },
        class = {
					"qutebrowser",
					"factorio",
					"voxygen",
					"dropbox",
					"brave-browser",
				},
        name = {
        },
        role = {
        }
      }, properties = { floating = false, maximized = false }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- TODO: could probably be combined
    { rule = { class = "Pulseeffects" },
      properties = { screen = 1, tag = "9" } },

    { rule_any = { class = { "QjackCtl" } },
      properties = { tag = "9" }
    }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- https://stackoverflow.com/questions/30324250/how-to-hide-borders-dynamically-from-windows-when-not-tiled-awesome-wm
screen.connect_signal("arrange", function (s)
    local max = s.selected_tag.layout.name == "max"
    local only_one = #s.tiled_clients == 1 -- use tiled_clients so that other floating windows don't affect the count
    -- but iterate over clients instead of tiled_clients as tiled_clients doesn't include maximized windows
    for _, c in pairs(s.clients) do
        if (max or only_one) and not c.floating or c.maximized then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
-- client.connect_signal("request::titlebars", function(c)
    -- -- buttons for the titlebar
    -- local buttons = gears.table.join(
        -- awful.button({ }, 1, function()
            -- c:emit_signal("request::activate", "titlebar", {raise = true})
            -- awful.mouse.client.move(c)
        -- end),
        -- awful.button({ }, 3, function()
            -- c:emit_signal("request::activate", "titlebar", {raise = true})
            -- awful.mouse.client.resize(c)
        -- end)
    -- )

    -- awful.titlebar(c) : setup {
        -- { -- Left
            -- awful.titlebar.widget.iconwidget(c),
            -- buttons = buttons,
            -- layout  = wibox.layout.fixed.horizontal
        -- },
        -- { -- Middle
            -- { -- Title
                -- align  = "center",
                -- widget = awful.titlebar.widget.titlewidget(c)
            -- },
            -- buttons = buttons,
            -- layout  = wibox.layout.flex.horizontal
        -- },
        -- { -- Right
            -- awful.titlebar.widget.floatingbutton (c),
            -- awful.titlebar.widget.maximizedbutton(c),
            -- awful.titlebar.widget.stickybutton   (c),
            -- awful.titlebar.widget.ontopbutton    (c),
            -- awful.titlebar.widget.closebutton    (c),
            -- layout = wibox.layout.fixed.horizontal()
        -- },
        -- layout = wibox.layout.align.horizontal
    -- }
-- end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
