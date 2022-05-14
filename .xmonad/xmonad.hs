-- based on Irishluck config https://github.com/boylemic/configs/tree/master/xmonad

-- Imports
import XMonad
import XMonad.Operations
import System.IO
import System.Exit
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Actions.SpawnOn
import XMonad.Actions.CycleWS
import XMonad.Actions.FloatKeys
import XMonad.Util.NamedScratchpad
import XMonad.Util.EZConfig(additionalKeys)
import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8
import XMonad.Hooks.DynamicLog

import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks    -- dock/tray mgmt
import Data.Monoid
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import System.Exit
--Layouts
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.Fullscreen
import XMonad.Layout.Spiral
import XMonad.Layout.ToggleLayouts          -- Full window at any time
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Mosaic
import XMonad.Layout.ThreeColumns

import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing

myTerminal = "alacritty"

-- Colors
gray      = "#7F7F7F"
gray2     = "#222222"
red       = "#900000"
blue      = "#2E9AFE"
white     = "#eeeeee"

myBrowser = "firefox"
---- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
myWorkspaces    = ["1:\xf269","2:\xf120","3:\xf0e0", "4:\xf07c","5:\xf1b6","6:\xf281","7:\xf04b","8:\xf167","9"]
--xmobarEscape = concatMap doubleLts
--  where doubleLts '<' = "<<"
--        doubleLts x    = [x]
--myWorkspaces            :: [String]
--myWorkspaces            = clickable . (map xmobarEscape) $ ["1:\xf269","2:\xf120","3:\xf0e0", "4:\xf07c","5:\xf1b6","6:\xf281","7:\xf04b","8:\xf167","9"]
--                                                                              
--  where                                                                       
--         clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
--                             (i,ws) <- zip [1..9] l,                                        
--                            let n = i ]
--
toggleFloat = withFocused (\windowId -> do
                              { floats <- gets (W.floating . windowset);
                                if windowId `M.member` floats
                                then withFocused $ windows . W.sink
                                else float windowId })

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- launch a terminal
    [ ((modMask .|. shiftMask,              xK_Return), spawn myTerminal)

    -- launch dmenu
    , ((modMask,               xK_d     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")

    , ((modMask,               xK_i     ), spawn myBrowser)
    -- launch gmrun
    , ((modMask, xK_Return     ), spawn "dmenu_run")
   -- close focused window    
    , ((modMask, xK_w     ), kill)

    --- Rotate through the available layout algorithms
    , ((modMask,               xK_Tab ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    -- , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modMask,               xK_n     ), refresh)

    -- Move focus to the next window
    -- , ((modMask,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modMask,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modMask,               xK_k     ), windows W.focusUp  )
    -- Volume Control
    ,((0, xF86XK_AudioMute), spawn "amixer set Master toggle")
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 5%- unmute")
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 5%+ unmute")

    -- Brightness Control
    , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight -inc $(bc <<< \"$(xbacklight) * 0.5 + 0.15\")")
    , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec $(bc <<< \"$(xbacklight) * 0.5\")")

    -- Move focus to the master window
    , ((modMask,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modMask, xK_space), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modMask,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modMask,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    -- , ((modMask .|. shiftMask, xK_space     ), withFocused $ windows . W.sink)
    , ((modMask .|. shiftMask, xK_space     ), toggleFloat )

    -- Increment the number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
     , ((modMask              , xK_b     ), sendMessage ToggleStruts)

     -- , ((modMask              , xK_u     ), sendMessage JumpToLayout "tiled")

    -- Quit xmonad
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modMask .|. shiftMask, xK_r     ), spawn "xmonad --recompile; xmonad --restart")
    , ((modMask              , xK_o    ), namedScratchpadAction myScratchPads "terminal")
    , ((modMask              , xK_p    ), namedScratchpadAction myScratchPads "music")
    , ((modMask              , xK_f), sendMessage (Toggle "Full"))

    -- moving floating windows
   , ((mod4Mask,               xK_h     ), withFocused (keysMoveWindow (-15,0)))
   , ((mod4Mask,               xK_l     ), withFocused (keysMoveWindow (15,0)))
   , ((mod4Mask,               xK_k     ), withFocused (keysMoveWindow (0,-15)))
   , ((mod4Mask,               xK_j     ), withFocused (keysMoveWindow (0,15)))

    -- resizing floating windows
 , ((mod4Mask .|. shiftMask,               xK_h     ), withFocused (keysResizeWindow (-30,0) (1/2,0)))
 , ((mod4Mask .|. shiftMask,               xK_l     ), withFocused (keysResizeWindow (30,0) (1/2,0)))
 , ((mod4Mask .|. shiftMask,               xK_j     ), withFocused (keysResizeWindow (0,-30) (0,1/2)))
 , ((mod4Mask .|. shiftMask,               xK_k     ), withFocused (keysResizeWindow (0,30) (0,1/2)))

 -- , ((mod4Mask .|. shiftMask,               xK_l     ), withFocused (keysResizeWindow (0,0) (0,0)))
 -- , ((mod4Mask .|. shiftMask,               xK_k     ), withFocused (keysResizeWindow (0,0) (0,0)))
 -- , ((mod4Mask .|. shiftMask,               xK_j     ), withFocused (keysResizeWindow (0,0) (0,0)))

 -- , ((modm,               xK_s     ), withFocused (keysResizeWindow (10,10) (1,1)))
 -- , ((modm .|. shiftMask, xK_d     ), withFocused (keysAbsResizeWindow (-10,-10) (1024,752)))
 -- , ((modm .|. shiftMask, xK_s     ), withFocused (keysAbsResizeWindow (10,10) (1024,752)))
 -- , ((mod4Mask,               xK_h     ), withFocused (keysMoveWindowTo (100,100) (1/2,1/2)))

--  ____            _       _       
-- / ___|  ___ _ __(_)_ __ | |_ ___ 
-- \___ \ / __| '__| | '_ \| __/ __|
--  ___) | (__| |  | | |_) | |_\__ \
-- |____/ \___|_|  |_| .__/ \__|___/
--                   |_|            
-- bindings to run scripts

    , ((modMask              , xK_F1    ), spawn "jackrun")
    , ((modMask              , xK_F2    ), spawn "jackkill")
    , ((modMask              , xK_F3    ), spawn "displayselect")
    , ((modMask              , xK_F7    ), spawn "td-toggle")
    , ((modMask              , xK_F8    ), spawn "dmenumount")
    , ((modMask              , xK_F9    ), spawn "dmenuumount")
    , ((modMask .|. shiftMask .|. controlMask, xK_p  ), spawn "poweroff")
    , ((modMask .|. shiftMask .|. controlMask, xK_r  ), spawn "reboot")
    , ((modMask .|. shiftMask, xK_b     ), spawn "bluetoothctl disconnect 74:5C:4B:D2:86:F7")
    , ((modMask              , xK_r     ), spawn "mullvadconnect")
    , ((modMask .|. shiftMask, xK_m     ), spawn "mullvaddisconnect")
    , ((modMask .|. shiftMask, xK_p     ), spawn "passmenu")
    , ((modMask .|. shiftMask, xK_semicolon), spawn "clipdownload")
    , ((modMask .|. shiftMask, xK_y     ), spawn "ytfzfclipboard")
    , ((modMask .|. shiftMask, xK_Up     ), spawn "cpuperformance")
    , ((modMask              , xK_b     ), spawn "bluetoothconnect 74:5C:4B:D2:86:F7")
    , ((modMask              , xK_g     ), spawn "calc")
    , ((modMask              , xK_p     ), spawn "stack -p")
    , ((modMask              , xK_semicolon     ), spawn "clipstream")
    , ((modMask              , xK_y     ), spawn "stack -y")
    , ((modMask              , xK_d     ), spawn "sleep 0.2 && xdotool type --clearmodifiers $(date +\"%F \")")
    , ((controlMask .|. shiftMask, xK_h ), spawn "musicseekbackward")
    , ((controlMask .|. shiftMask, xK_l ), spawn "musicseekforward")
        , ((controlMask .|. shiftMask, xK_j ), spawn "musicnext")
        , ((controlMask .|. shiftMask, xK_k ), spawn "musicprev")
    , ((controlMask .|. shiftMask, xK_space ), spawn "musicplaypause")
    , ((0                    , xK_Print ), spawn "maim -f jpg -m 9 \"/home/flex/Pictures/SCREENSHOTS/$(date +'%F %H_%M_%S.jpg')\"")
    , ((shiftMask            , xK_Print ), spawn "maim -f jpg -m 9 -s \"/home/flex/Pictures/SCREENSHOTS/$(date +'%F %H_%M_%S.jpg')\"")
    , ((modMask .|. shiftMask, xK_x     ), spawn "xkill")

--  _____ _   _ ___ 
-- |_   _| | | |_ _|
--   | | | | | || | 
--   | | | |_| || | 
--   |_|  \___/|___|
--                  
-- terminal applications
--
    , ((modMask .|. shiftMask .|. controlMask, xK_Return  ), spawn "alacritty -t ncspot -e ncspot")
    , ((modMask, xK_F4     ), spawn "alacritty -t PulseMixer -e pulsemixer")
    , ((modMask, xK_F6     ), spawn "torwrap")
    , ((modMask .|. shiftMask, xK_c  ), spawn "alacritty -t calcurse -e calcurse")
    , ((modMask .|. shiftMask, xK_comma  ), spawn "alacritty -t Vifm -e vifmrun")
    , ((modMask, xK_n     ), spawn "alacritty -t TODO --working-directory ~/Dropbox/NOTES/ -e nvim TODO.md")
    , ((modMask .|. shiftMask, xK_n  ), spawn "alacritty -t VimWiki --working-directory ~/Dropbox/NOTES/ -e nvim -c VimwikiIndex")
    , ((0                    , xK_grave ), spawn "alacritty -t stack --working-directory ~/.local/src/stack -e nvim ~/.local/src/stack/stack")
    , ((modMask .|. shiftMask, xK_t  ), spawn "alacritty -t typingtest -e tt -theme dracula")
    , ((modMask              , xK_e     ), spawn "alacritty -t NeoMutt -e neomutt")
    , ((modMask              , xK_r     ), spawn "alacritty -t Newsboat -e newsboat")
    , ((modMask              , xK_s     ), spawn "supercollider")
    , ((controlMask .|. shiftMask, xK_Return ), spawn "alacritty -t ncmpcpp -e ncmpcpp")
    -- , ((modMask              , xK_t     ), spawn "alacritty -t Htop -e htop")

-- 	  ____ _   _ ___ 
--  / ___| | | |_ _|
-- | |  _| | | || | 
-- | |_| | |_| || | 
--  \____|\___/|___|
-- 
-- gui applications

    , ((modMask, xK_q  ), spawn "qpwgraph")
    , ((modMask .|. shiftMask, xK_period  ), spawn "qutebrowser")
    , ((modMask .|. shiftMask .|. controlMask, xK_period  ), spawn "bravestart")
    , ((modMask .|. shiftMask, xK_F4  ), spawn "pavucontrol")
    , ((modMask .|. controlMask, xK_Return  ), spawn "audacious")

----BSP Layout
--    , ((modMask .|. mod4Mask,               xK_l     ), sendMessage $ ExpandTowards R)
--    , ((modMask .|. mod4Mask,               xK_h     ), sendMessage $ ExpandTowards L)
--    , ((modMask .|. mod4Mask,               xK_j     ), sendMessage $ ExpandTowards D)
--    , ((modMask .|. mod4Mask,               xK_k     ), sendMessage $ ExpandTowards U)
----    , ((modMask .|. mod4Mask .|. ctrlMask , xK_l     ), sendMessage $ ShrinkFrom R)
----    , ((modMask .|. mod4Mask .|. ctrlMask , xK_h     ), sendMessage $ ShrinkFrom L)
----    , ((modMask .|. mod4Mask .|. ctrlMask , xK_j     ), sendMessage $ ShrinkFrom D)
----    , ((modMask .|. mod4Mask .|. ctrlMask , xK_k     ), sendMessage $ ShrinkFrom U)
--    , ((modMask,                           xK_r     ), sendMessage Rotate)
--    , ((modMask,                           xK_s     ), sendMessage Swap)
--    , ((modMask,                           xK_n     ), sendMessage FocusParent)
--   -- , ((modMask .|. ctrlMask,              xK_n     ), sendMessage SelectNode)
--    , ((modMask .|. shiftMask,             xK_n     ), sendMessage MoveNode)

    ]
     ++

    --
    -- mod-[1..9], Switch to workspace N
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    -- [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        -- | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        -- , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
---spawn
--
myStartupHook = do
 -- spawn "/usr/bin/stalonetray"
  spawn "/home/flex/.config/polybar/launch.sh"
  -- spawnOnce "nm-applet"
  -- spawnOnce "volumeicon"
  -- setWMName "LG3D"
  -- spawnOnce "dropbox"
  -- spawn "compton -b"
  -- spawnOnce "redshift-gtk"

myScratchPads = [ NS "terminal" spawnTerm  findTerm manageTerm
                , NS "music" spawnPav findPav  managePav
                ]
        where

    spawnTerm = myTerminal ++  " -name scratchpad -e cmus"
    findTerm = resource =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h -- and I'd like it fixed using the geometry below

       where

        -- reusing these variables is ok since they're confined to their own 
        -- where clauses 
        h = 1       -- height, 10% 
        w = 1         -- width, 100%
        t = 1 - h     -- bottom edge
        l = 1 -w -- centered left/right
    spawnPav = "spotify"
    findPav = className =? "Spotify"
    managePav = customFloating $ W.RationalRect l t w h -- and I'd like it fixed using the geometry below

        where

        -- reusing these variables is ok since they're confined to their own 
        -- where clauses 
        h = 1      -- height, 10% 
        w = 1         -- width, 100%
        t = 1 -h      -- bottom edge
        l = 1 -w -- centered left/right

myManageHook = composeAll
    [ className =? "stalonetray"    --> doIgnore
    --  , className =? "Steam"        --> doFullFloat
      , className =? "Firefox"      --> doFullFloat
      , title =? "FEZ"              --> doFullFloat
      , title =? "Don't Starve"     --> doFullFloat
--      , className =? "mpv"          --> doFullFloat
      , manageDocks
      , isFullscreen                --> (doF W.focusDown <+> doFullFloat)
    ] <+> namedScratchpadManageHook myScratchPads

-- Mouse bindings

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

myLayoutHook = smartBorders $ avoidStruts (
    spiral (6/7) ||| toggleLayouts Full (Grid) ||| toggleLayouts Full (ThreeColMid 1 (1/20) (1/2)) ||| simpleTabbed ||| toggleLayouts Full (tiled) ||| Mirror tiled)
        where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio
    -- The default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio   = 1/2
    -- Percent of screen to increment by when resizing panes
delta = 3/100 

----Main Function
main :: IO ()
main = do
    dbus <- D.connectSession
    -- Request access to the DBus name
    D.requestName dbus (D.busName_ "org.xmonad.Log")
        [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

    xmonad $ewmh $ docks $ defaults { logHook = dynamicLogWithPP (myLogHook dbus) }

-- Override the PP values as you would otherwise, adding colors etc depending
-- on  the statusbar used
myLogHook :: D.Client -> PP
myLogHook dbus = def
    { ppOutput = dbusOutput dbus
    , ppCurrent = wrap ("%{F" ++ blue ++ "} ") " %{F-}"
    , ppVisible = wrap ("%{F" ++ gray ++ "} ") " %{F-}"
    , ppUrgent = wrap ("%{F" ++ red ++ "} ") " %{F-}"
    , ppHidden = wrap ("%{F" ++ gray ++ "} ") " %{F-}"
    , ppTitle = wrap ("%{F" ++ gray2 ++ "} ") " %{F-}"
    }
-- Emit a DBus signal on log updates
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal objectPath interfaceName memberName) {
            D.signalBody = [D.toVariant $ UTF8.decodeString str]
        }
    D.emit dbus signal
  where
    objectPath = D.objectPath_ "/org/xmonad/Log"
    interfaceName = D.interfaceName_ "org.xmonad.Log"
    memberName = D.memberName_ "Update"

defaults = def{
    modMask= mod1Mask
    , terminal = myTerminal
    , workspaces = myWorkspaces
    , keys = myKeys
-- smartBorder :: Bool	
-- screenBorder :: Border	
-- screenBorderEnabled :: Bool	
-- windowBorder :: Border	
-- The window borders.
-- windowBorderEnabled :: Bool
--
    , layoutHook = myLayoutHook
    , focusedBorderColor = "#2E9AFE"
    , normalBorderColor = "#000000"
    , mouseBindings = myMouseBindings                           
    , manageHook = myManageHook <+> manageHook def
    , borderWidth         = 2
    , startupHook = myStartupHook
    }
