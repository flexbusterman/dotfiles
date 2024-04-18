--yout
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
--
import XMonad
import Data.Monoid
import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (doLower)
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig
import System.IO
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)
import XMonad.Layout.NoBorders (noBorders, smartBorders)

-- import Graphics.X11.Types
import Graphics.X11.ExtraTypes.XF86

import qualified XMonad.Util.Hacks as Hacks
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 2

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
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#6272a4"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [
      -- Key bindings for A
      ((modm, xK_a), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_a), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_a), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_a), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_a), spawn "notify-send hello")
      -- Key bindings for B
      , ((modm, xK_b), spawn "bluetoothconnect $HEADPHONES")
      , ((modm .|. shiftMask, xK_b), spawn "bluetoothctl disconnect $HEADPHONES")
      -- , ((modm .|. controlMask, xK_b), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_b), spawn "notify-send hello")
      , ((modm .|. shiftMask .|. controlMask, xK_b), spawn "blueman-manager")
      -- Key bindings for C
      -- , ((modm, xK_c), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_c), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_c), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_c), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_c), spawn "notify-send hello")
      -- Key bindings for D
      , ((modm, xK_d), spawn "sleep 0.2 && xdotool type --clearmodifiers \"$(date +\"%F \")\" && sleep 0.2 && xdotool keyup Alt_L Alt_R Control_L Control_R Shift_L Shift_R")
      -- , ((modm .|. shiftMask, xK_d), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_d), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_d), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_d), spawn "notify-send hello")
      -- Key bindings for E
      -- , ((modm, xK_e), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_e), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_e), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_e), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_e), spawn "notify-send hello")
      -- Key bindings for F
        , ((modm, xK_f), sendMessage (Toggle "Full"))
      -- , ((modm .|. shiftMask, xK_f), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_f), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_f), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_f), spawn "notify-send hello")
      -- Key bindings for G
      -- , ((modm, xK_g), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_g), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_g), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_g), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_g), spawn "notify-send hello")
      -- Key bindings for H
      -- , ((modm, xK_h), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_h), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_h), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_h), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_h), spawn "notify-send hello")
      -- Key bindings for I
      -- , ((modm, xK_i), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_i), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_i), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_i), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_i), spawn "notify-send hello")
      -- Key bindings for J
      , ((modm,               xK_j     ), windows W.focusDown)
			, ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
      -- , ((modm .|. controlMask, xK_j), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_j), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_j), spawn "notify-send hello")
      -- Key bindings for K
			, ((modm,               xK_k     ), windows W.focusUp  )
			, ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
      -- , ((modm .|. controlMask, xK_k), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_k), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_k), spawn "notify-send hello")
      -- Key bindings for L
      -- , ((modm, xK_l), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_l), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_l), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_l), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_l), spawn "notify-send hello")
      -- Key bindings for M
      -- , ((modm, xK_m), spawn "mullvadconnect")
      -- , ((modm .|. shiftMask, xK_m), spawn "mullvaddisconnect")
      -- , ((modm .|. controlMask, xK_m), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_m), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_m), spawn "notify-send hello")
      -- Key bindings for N
      -- , ((modm, xK_n), spawn "cd ~/Dropbox/NOTES/; alacritty -T TODO -e nvim ~/Dropbox/NOTES/TODO.md")
      -- , ((modm .|. shiftMask, xK_n), spawn "alacritty -e ~/.local/bin/fzfnotes")
      -- , ((modm .|. controlMask, xK_n), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_n), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_n), spawn "notify-send hello")
      -- Key bindings for O
      -- , ((modm, xK_o), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_o), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_o), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_o), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_o), spawn "notify-send hello")
      -- Key bindings for P
      -- , ((modm, xK_p), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_p), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_p), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_p), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_p), spawn "notify-send hello")
			, ((modm .|. shiftMask .|. controlMask, xK_p), spawn "poweroff")
      -- Key bindings for Q
      -- , ((modm, xK_q), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_q), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_q), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_q), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_q), spawn "notify-send hello")
      -- Key bindings for R
      -- , ((modm, xK_r), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_r), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_r), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_r), spawn "notify-send hello")
			, ((modm .|. shiftMask .|. controlMask, xK_r), spawn "reboot")

      -- Key bindings for S
      -- , ((modm, xK_s), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_s), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_s), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_s), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_s), spawn "notify-send hello")
      -- Key bindings for T
      -- , ((modm, xK_t), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_t), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_t), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_t), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_t), spawn "notify-send hello")
      -- Key bindings for U
      -- , ((modm, xK_u), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_u), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_u), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_u), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_u), spawn "notify-send hello")
      -- Key bindings for V
      -- , ((modm, xK_v), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_v), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_v), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_v), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_v), spawn "notify-send hello")
      -- Key bindings for W
      , ((modm, xK_w), kill)
      -- , ((modm .|. shiftMask, xK_w), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_w), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_w), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_w), spawn "notify-send hello")
      -- Key bindings for X
      -- , ((modm, xK_x), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_x), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_x), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_x), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_x), spawn "notify-send hello")
      -- Key bindings for Y
      -- , ((modm, xK_y), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_y), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_y), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_y), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_y), spawn "notify-send hello")
      -- Key bindings for Z
      -- , ((modm, xK_z), spawn "notify-send hello")
      -- , ((modm .|. shiftMask, xK_z), spawn "notify-send hello")
      -- , ((modm .|. controlMask, xK_z), spawn "notify-send hello")
      -- , ((shiftMask .|. controlMask, xK_z), spawn "notify-send hello")
      -- , ((modm .|. shiftMask .|. controlMask, xK_z), spawn "notify-send hello")

    -- launch dmenu
    , ((modm,               xK_Return     ), spawn "dmenu_run")

		-- , ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_Tab ), sendMessage NextLayout)

    -- , ((modm,               xK_period ), spawn "qutebrowser")
--
    , ((modm,               xK_comma ), spawn "alacritty -e rangerstart")
    , ((modm,               xK_equal ), spawn "calculate")
    , ((0,               xK_Print ), spawn "maim -f jpg -m 9 \"/home/flex/Pictures/SCREENSHOTS/$(date +\"%F %H_%M_%S.jpg\")\"")
    , ((shiftMask,               xK_Print ), spawn "maim -f jpg -m 9 -s \"/home/flex/Pictures/SCREENSHOTS/$(date +\"%F %H_%M_%S.jpg\")\"")

    , ((modm,               xK_grave ), spawn "dmenuunicode")

    , ((modm,               xK_F1 ), spawn "bindings")
    , ((modm,               xK_F2 ), spawn "resolution")
    , ((modm,               xK_F3 ), spawn "displaydefault")
    , ((modm .|. shiftMask, xK_F3 ), spawn "displayselect")
    , ((modm,               xK_F4 ), spawn "alacritty -T PulseMixer -e pulsemixer; kill -44 $(pidof dwmblocks)")
    -- , ((modm,               xK_F5 ), spawn "")
    -- , ((modm,               xK_F6 ), spawn "")
    , ((modm,               xK_F7 ), spawn "td-toggle")
    , ((modm,               xK_F8 ), spawn "mounter")
    , ((modm,               xK_F9 ), spawn "unmounter")
    , ((modm,               xK_F10 ), spawn "campreview")
    , ((modm,               xK_F11 ), spawn "dmenurecord")
    , ((modm,               xK_F12 ), spawn "killrecording")

		, ((modm, xK_semicolon), spawn "clipstream")
		, ((modm .|. shiftMask, xK_semicolon), spawn "clipdownload")
		, ((modm .|. shiftMask .|. controlMask, xK_semicolon), spawn "clipdownload -a")

    , ((0,               xF86XK_AudioLowerVolume ), spawn "notify-send hello")

		, (( 0,						xF86XK_AudioMute),								spawn "pamixer -t; kill -44 $(pidof dwmblocks)")
		, (( 0,						xF86XK_AudioRaiseVolume),				spawn "pamixer --allow-boost -i 5; kill -44 $(pidof dwmblocks)")
		, (( 0,						xF86XK_AudioLowerVolume),				spawn "pamixer --allow-boost -d 5; kill -44 $(pidof dwmblocks)")
		, (( 0,						xF86XK_AudioMicMute),						spawn "amixer set Capture toggle")
		, (( 0,						xF86XK_MonBrightnessUp),					spawn "brightnessup")
		, (( 0,						xF86XK_MonBrightnessDown),				spawn "brightnessdown")

    -- , ((0,               xF86_AudioRaiseVolume ), spawn "notify-send hello")

    --  Reset the layouts on the current workspace to default
    -- , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    -- , ((modm,               xK_n     ), refresh)

    -- Move focus to the master window
    -- , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_space), windows W.swapMaster)

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    -- , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    -- , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm .|. shiftMask, xK_r     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    -- , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

    -- ++
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    -- [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --     | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

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

myLayout = toggleLayouts (noBorders Full) (avoidStruts (tiled ||| Mirror tiled ||| Full))
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

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
    , resource  =? "kdesktop"       --> doIgnore
		, checkDock                   --> doLower
		]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- myEventHook = mempty
myEventHook = Hacks.trayerAboveXmobarEventHook <> Hacks.trayerPaddingXmobarEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
-- myLogHook = return ()
myLogHook = dynamicLog

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
-- myStartupHook = return (
--     spawn "xmobar &"
-- )

-- myStartupHook = return ()
myStartupHook = do
	spawnOnce "notify-send hello"
	spawn "killall sxhkd; exec /usr/bin/env sxhkd &"
	-- spawn "killall trayer; exec /usr/bin/env trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 4 --transparent true --alpha 0 --tint 0x000000 --height 19 &"
	spawn "killall trayer; exec /usr/bin/env trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype request --transparent true --alpha 0 --tint 0x000000 --height 19 &"
	spawn "killall xmobar; xmobar ~/.config/xmobar/xmobarrc &"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
-- main = xmonad defaults

main = do
	-- xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc"
	xmonad $ docks defaults

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
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
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
