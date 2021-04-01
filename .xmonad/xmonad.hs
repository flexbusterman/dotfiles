import Data.Monoid
import Graphics.X11.ExtraTypes.XF86
import qualified Data.Map        as M
import qualified XMonad.StackSet as W
import System.Exit
import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce

-- The preferred terminal program, which is used in a binding below and by
--
-- certain contrib modules.

myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 3

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod1Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#222222"
myFocusedBorderColor = "#52a7DD"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_Return     ), spawn "dmenu_run")

    -- launch gmrun
    -- , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm, xK_w     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_Tab ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
		, ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    -- , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    -- , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_space), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm .|. shiftMask,               xK_f     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    , ((modm              , xK_p     ), spawn "alacritty -t Htop -e htop")
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))

    -- , ((modm .|. shiftMask, xK_comma ), spawn ("alacritty -o env.SHELL=/bin/zsh -e vifmrun"))
    , ((modm .|. shiftMask, xK_comma ), spawn ("alacritty -o env.SHELL=/bin/zsh -e vifm"))
    , ((modm .|. shiftMask, xK_period ), spawn ("qutebrowser"))
    , ((modm .|. controlMask .|. shiftMask, xK_period ), spawn ("brave"))
		, ((modm .|. shiftMask, xK_x), spawn ("xkill"))
		, ((modm .|. shiftMask, xK_n), spawn ("alacritty -t Newsboat -e newsboat"))
		, ((modm, xK_c), spawn ("alacritty -t Calcurse -e calcurse"))
		, ((modm, xK_i), spawn ("brave --app='http://www.instagram.com/direct/inbox/'"))
		, ((modm, xK_e), spawn ("alacritty -t NeoMutt -e neomutt"))
		, ((modm, xK_t), spawn ("alacritty -t Telegram -e tg"))
		, ((0, xK_Print), spawn ("maim -f jpg -m 9 \"/home/flex/Pictures/SCREENSHOTS/$(date +\"%F %H_%M_%S.jpg\")\""))
		, ((shiftMask, xK_Print), spawn ("maim -f jpg -m 9 -s \"/home/flex/Pictures/SCREENSHOTS/$(date +\"%F %H_%M_%S.jpg\")\""))
		, ((0, 0x1008ff12), spawn ("pamixer -t"))
		, ((0, 0x1008ff11), spawn ("pamixer --allow-boost -d 3"))
		, ((0, 0x1008ff13), spawn ("pamixer --allow-boost -i 3"))
		, ((0, 0x1008ff03), spawn ("xbacklight -dec $(bc <<< \"$(xbacklight) * 0.5\")"))
		, ((0, 0x1008ff02), spawn ("xbacklight -inc $(bc <<< \"$(xbacklight) * 0.5 + 0.15\")"))
		, ((0, 0x1008ff94), spawn ("bluetoothctl show | grep -i powered | grep -i yes && notify-send 'Bluetooth is on' && pactl set-card-profile bluez_card.74_5C_4B_D2_86_F7 a2dp_sink || notify-send 'Starting bluetooth' && bluetoothctl power on && bluetoothctl -- connect 74:5C:4B:D2:86:F7 && pactl set-card-profile bluez_card.74_5C_4B_D2_86_F7 a2dp_sink"))
		, ((modm, xK_n), spawn ("cd ~/Dropbox/NOTES/; alacritty -e nvim -c VimwikiIndex"))
		-- , ((modm, xK_F1),    spawn ("groff -mom /usr/local/share/dwm/larbs.mom -Tpdf | zathura -"))
		-- , ((modm, xK_F2),    spawn ("tutorialvids"))
		, ((modm, xK_F3),    spawn ("displayselect"))
		, ((modm, xK_F4), spawn ("alacritty -e pulsemixer"))
		-- , ((modm), xK_F5,    xr db,ULL })
		, ((modm, xK_F6),    spawn ("torwrap"))
		, ((modm, xK_F7),    spawn ("td-toggle"))
		, ((modm, xK_F8),    spawn ("mailsync"))
		, ((modm, xK_F9),    spawn ("dmenumount"))
		, ((modm, xK_F10),   spawn ("dmenuumount"))
		, ((modm, xK_F11),   spawn ("mpv --no-cache --no-osc --no-input-default-bindings --input-conf=/dev/null --title=webcam $(ls /dev/video[0,2,4,6,8] | tail -n 1)"))
		-- , ((modm, xK_F12,   xrdb,   {.v = NULL }
	-- , ((modm .|. shiftMask,                       xK_l), spawn ("slock"))
		,	((modm .|. shiftMask,                       xK_s), spawn ("alacritty -e zsh -c yt" ))
		-- ,	((modm,                       xK_d), spawn ("sleep 0.2 && xdotool type --clearmodifiers \"$(date +\"%F \")\"")
		,	((modm .|. controlMask .|. shiftMask,                       xK_s), spawn ("setxkbmap se; setxkbmap -option 'caps:swapescape'; xset r rate 300 50"))
		,	((modm .|. controlMask .|. shiftMask,                       xK_u), spawn ("setxkbmap us; setxkbmap -option \"caps:swapescape\"; xset r rate 300 50"))
		, ((modm .|. controlMask .|. shiftMask,             xK_r), spawn ("reboot"))
		, ((modm .|. controlMask .|. shiftMask,             xK_r), spawn ("poweroff"))
	-- ,	((modm .|. shiftMask,   xK_w),   spawn ("alacritty -e sudo nmtui")))
	-- ,	((modm .|. shiftMask,   xK_e),   spawn ("alacritty -e abook -C ~/.config/abook/abookrc --datafile ~/.config/abook/addressbook")))
	-- ,	((modm,   xK_p),   spawn ("keepassxc")))
	-- ,	((modm .|. controlMask .|. shiftMask,    xK_c),   spawn ("cadence")))
	-- ,	((modm,     xK_m),   spawn ("alacritty -e ncmpcpp")))
	-- ,	((modm .|. shiftMask,   xK_m),   spawn ("aconnect 127:7 16:0; aconnect 128:7 16:0; aconnect 129:7 16:0; aconnect 130:7 16:0")))
	-- ,	((modm,     xK_F2),    spawn ("tutorialvids")))
	-- ,	((modm,     xK_F3),    spawn ("displayselect")))
	-- ,	((modm,     xK_F4),    spawn ("alacritty -e pulsemixer; kill -44 $(pidof dwmblocks)")))
		-- -- (,	(modm,     xK_F5),    xrdb,   {.v = NULL } },)
	-- ,	((modm,     xK_F6),    spawn ("torwrap")))
	-- ,	((modm,     xK_F7),    spawn ("td-toggle")))
	-- ,	((modm,     xK_F8),    spawn ("mailsync")))
	-- ,	((modm,     xK_F9),    spawn ("dmenumount")))
	-- ,	((modm,     xK_F10),   spawn ("dmenuumount")))
	-- ,	((modm,     xK_F11),   spawn ("mpv --no-cache --no-osc --no-input-default-bindings --input-conf=/dev/null --title=webcam $(ls /dev/video[0,2,4,6,8] .|.  tail -n 1)")))
	-- ,	((modm,     xK_Print), spawn ("dmenurecord")))
	-- ,	((modm .|. shiftMask,   xK_Print), spawn ("dmenurecord kill")))
	-- ,	((modm,     xK_Delete),  spawn ("dmenurecord kill")))
	-- ,	((modm,     xK_Scroll_Lock), spawn ("killall screenkey .|. .|.  screenkey &")))
	,	((controlMask .|. shiftMask, xK_k), spawn ("deadbeef --prev"))
	,	((controlMask .|. shiftMask, xK_j), spawn ("deadbeef --next"))
	,	((controlMask .|. shiftMask, xK_space), spawn ("deadbeef --play-pause"))
	,	((controlMask .|. shiftMask, xK_q), spawn ("deadbeef --quit"))
	,	((controlMask .|. shiftMask, xK_Return), spawn ("deadbeef"))
	-- ,	(modm .|. controlMask .|. shiftMask, xK_t), spawn ("tetris")))
		-- --,	(( 0, XF86xK_AudioMute),    spawn ("pamixer -t; kill -44 $(pidof dwmblocks)")))
			-- -- { 0, XF86xK_AudioRaiseVolume, spawn,    SHCMD("pamixer --allow-booalacritty -i 3; kill -44 $(pidof dwmblocks)") },)
			-- -- { 0, XF86xK_AudioLowerVolume, spawn,    SHCMD("pamixer --allow-booalacritty -d 3; kill -44 $(pidof dwmblocks)") },)
			-- -- { 0, XF86xK_MonBrightnessUp,  spawn,    SHCMD("xbacklight -inc $(bc <<< \"$(xbacklight) * 0.5 + 0.15\")") },)
			-- -- { 0, XF86xK_MonBrightnessDown,  spawn,    SHCMD("xbacklight -dec $(bc <<< \"$(xbacklight) * 0.5\")") },)


    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
  --
  --
    -- ++
    -- [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        -- | (key, sc) <- zip [xK_b, xK_n, xK_m] [0..]
        -- , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts (spiral (6/7) ||| tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 2/3

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
  spawnOnce "/usr/bin/xmobar /home/flex/.xmobar/xmobar.hs"
-- myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--

-- main = do
	-- xmproc <- spawnPipe "/usr/bin/xmobar /home/flex/.xmobar/xmobar.hs"
	-- xmonad $ docks defaults

main = do
  xmproc <- spawnPipe ("/usr/bin/xmobar /home/flex/.xmobar/xmobar.hs")
  -- xmonad $ fullscreenSupport $ defaults {
  xmonad $ defaults {
      logHook = dynamicLogWithPP $ xmobarPP {
            ppOutput = hPutStrLn xmproc
					-- , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
          -- , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
					, ppSep = " "
      }
--      , startupHook = docksStartupHook <+> setWMName "LG3D"
  }

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
				manageHook				 = myManageHook <+> manageDocks,
        handleEventHook    = myEventHook <+> docksEventHook,
				logHook            = myLogHook,
        startupHook        = myStartupHook <+> setWMName "LG3D"
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
