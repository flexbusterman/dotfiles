-----------------------------------------------------------------------------
--                  __  ____  __                       _                     --
--                  \ \/ /  \/  | ___  _ __   __ _  __| |                    --
--                   \  /| |\/| |/ _ \| '_ \ / _` |/ _` |                    --
--                   /  \| |  | | (_) | | | | (_| | (_| |                    --
--                  /_/\_\_|  |_|\___/|_| |_|\__,_|\__,_|                    --
--                                                                           --
-------------------------------------------------------------------------------
--          written by Shotaro Fujimoto (https://github.com/ssh0)            --
-------------------------------------------------------------------------------
-- Import modules                                                           {{{
-------------------------------------------------------------------------------
import qualified Data.Map as M

import XMonad
import qualified XMonad.StackSet as W  -- myManageHookShift

import Control.Monad (liftM2)          -- myManageHookShift
import System.IO                       -- for xmobar

import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import qualified XMonad.Actions.FlexibleResize as Flex -- flexible resize
import XMonad.Actions.FloatKeys
import XMonad.Actions.UpdatePointer
import XMonad.Actions.WindowGo
import XMonad.Hooks.DynamicLog         -- for xmobar
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeWindows
import XMonad.Hooks.ManageDocks        -- avoid xmobar area
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Place
import XMonad.Layout
import XMonad.Layout.DragPane          -- see only two window
import XMonad.Layout.Gaps
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders         -- In Full mode, border is no use
import XMonad.Layout.PerWorkspace      -- Configure layouts on a per-workspace
import XMonad.Layout.ResizableTile     -- Resizable Horizontal border
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing           -- this makes smart space around windows
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns      -- for many windows
import XMonad.Layout.ToggleLayouts     -- Full window at any time
import XMonad.Layout.TwoPane
import XMonad.Prompt
import XMonad.Prompt.Window            -- pops up a prompt with window names
import XMonad.Util.EZConfig            -- removeKeys, additionalKeys
import XMonad.Util.Run
import XMonad.Util.Run(spawnPipe)      -- spawnPipe, hPutStrLn
import XMonad.Hooks.SetWMName

import Graphics.X11.ExtraTypes.XF86

--------------------------------------------------------------------------- }}}
-- local variables                                                          {{{
-------------------------------------------------------------------------------

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
modm = mod1Mask

-- Color Setting
colorBlue      = "#9fc7e8"
colorGreen     = "#a5d6a7"
colorRed       = "#ef9a9a"
colorGray      = "#9e9e9e"
colorWhite     = "#ffffff"
colorGrayAlt   = "#eceff1"
colorNormalbg  = "#1c1c1c"
colorfg        = "#9fa8b1"

-- Border width
borderwidth = 2

-- Border color
mynormalBorderColor  = colorNormalbg
myfocusedBorderColor = colorBlue

-- gapwidth
gapwidth  = 0
gapwidthU = 7
gapwidthD = 8
gapwidthL = 33
gapwidthR = 34

--------------------------------------------------------------------------- }}}
-- Define keys to remove                                                    {{{
-------------------------------------------------------------------------------

keysToRemove x =
    [
        -- Unused gmrun binding
          (modm .|. shiftMask, xK_p)
        -- Unused close window binding
        , (modm .|. shiftMask, xK_c)
        , (modm .|. shiftMask, xK_Return)
    ]

-- Delete the keys combinations we want to remove.
strippedKeys x = foldr M.delete (keys defaultConfig x) (keysToRemove x)

--------------------------------------------------------------------------- }}}
-- main                                                                     {{{
-------------------------------------------------------------------------------

main :: IO ()

main = do
    wsbar <- spawnPipe myWsBar
    xmonad $ ewmh defaultConfig
       { borderWidth        = borderwidth
       , terminal           = "alacritty"
       , focusFollowsMouse  = True
       , normalBorderColor  = mynormalBorderColor
       , focusedBorderColor = myfocusedBorderColor
       , startupHook        = myStartupHook
       , manageHook         = myManageHookShift <+>
                              myManageHookFloat <+>
                              manageDocks
       -- any time Full mode, avoid xmobar area
       , layoutHook         = avoidStruts $ ( toggleLayouts (noBorders Full)
                                            -- $ onWorkspace "3" simplestFloat
                                            $ myLayout
                                            )
       --, layoutHook         = lessBorders OnlyFloat $
       --                       toggleLayouts (avoidStruts $ noBorders Full) $
       --                       -- onWorkspace "3" simplestFloat $
       --                       avoidStruts $ myLayout
       -- xmobar setting
       , logHook            = myLogHook wsbar
       , handleEventHook    = fadeWindowsEventHook
       --, handleEventHook    = fullscreenEventHook
       , workspaces         = myWorkspaces
       , modMask            = modm
       , mouseBindings      = newMouse
       }

       -------------------------------------------------------------------- }}}
       -- Keymap: window operations                                         {{{
       ------------------------------------------------------------------------

       `additionalKeys`
       [
       -- Shrink / Expand the focused window
         ((modm                , xK_comma  ), sendMessage Shrink)
       , ((modm                , xK_period ), sendMessage Expand)
       , ((modm                , xK_z      ), sendMessage MirrorShrink)
       , ((modm                , xK_a      ), sendMessage MirrorExpand)
       -- Close the focused window
       , ((modm                , xK_w      ), kill1)
       -- Toggle layout (Fullscreen mode)
       , ((modm                , xK_f      ), sendMessage NextLayout)
       -- Push floating window back into tilling
	, ((modm		       , xK_t	   ), withFocused $ windows . W.sink)
       -- Move the focused window
       , ((modm .|. controlMask, xK_Right  ), withFocused (keysMoveWindow (6,0)))
       , ((modm .|. controlMask, xK_Left   ), withFocused (keysMoveWindow (-6,0)))
       , ((modm .|. controlMask, xK_Up     ), withFocused (keysMoveWindow (0,-6)))
       , ((modm .|. controlMask, xK_Down   ), withFocused (keysMoveWindow (0,6)))
       -- Resize the focused window
       , ((modm                , xK_s      ), withFocused (keysResizeWindow (-12,-12) (0.5,0.5)))
       , ((modm                , xK_i      ), withFocused (keysResizeWindow (12,12) (0.5,0.5)))
       , ((modm .|. controlMask, xK_period ), withFocused (keysResizeWindow (6,0) (0,0)))
       , ((modm .|. controlMask, xK_comma  ), withFocused (keysResizeWindow (-6,0) (0,0)))
       , ((modm .|. controlMask, xK_a      ), withFocused (keysResizeWindow (0,-6) (0,0)))
       , ((modm .|. controlMask, xK_z      ), withFocused (keysResizeWindow (0,6) (0,0)))
       -- Increase / Decrese the number of master pane
       -- , ((modm .|. shiftMask  , xK_minus  ), sendMessage $ IncMasterN 1)
       , ((modm                , xK_plus  ), sendMessage $ IncMasterN 1)
       , ((modm                , xK_minus  ), sendMessage $ IncMasterN (-1))
       -- Go to the next / previous workspace
       , ((modm                , xK_Right  ), nextWS )
       , ((modm                , xK_Left   ), prevWS )
       , ((modm                , xK_l      ), nextWS )
       , ((modm                , xK_h      ), prevWS )
       -- Shift the focused window to the next / previous workspace
       , ((modm .|. shiftMask  , xK_Right  ), shiftToNext)
       , ((modm .|. shiftMask  , xK_Left   ), shiftToPrev)
       , ((modm .|. shiftMask  , xK_l      ), shiftToNext)
       , ((modm .|. shiftMask  , xK_h      ), shiftToPrev)
       -- Move the focus down / up
       , ((modm                , xK_j      ), windows W.focusDown)
       , ((modm                , xK_k      ), windows W.focusUp)
       -- Swap the focused window down / up
       , ((modm .|. shiftMask  , xK_j      ), windows W.swapDown)
       , ((modm .|. shiftMask  , xK_k      ), windows W.swapUp)
       -- Shift the focused window to the master window
       , ((modm .|. shiftMask  , xK_m      ), windows W.shiftMaster)
       -- Search a window and focus into the window
       -- , ((modm                , xK_g      ), windowPromptGoto myXPConfig)
       -- Search a window and bring to the current workspace
       -- , ((modm                , xK_b      ), windowPromptBring myXPConfig)
       -- Move the focus to next screen (multi screen)
       -- , ((modm                , xK_w      ), nextScreen)
       -- Toggle Xmobar
       ,((modm                 , xK_x      ), sendMessage ToggleStruts)
       ]

       -------------------------------------------------------------------- }}}
       -- Keymap: moving workspace by number                                {{{
       ------------------------------------------------------------------------

       `additionalKeys`
       [ ((modm .|. m, k), windows $ f i)
         | (i, k) <- zip myWorkspaces
                     [ xK_exclam, xK_at, xK_numbersign
                     , xK_dollar, xK_percent, xK_asciicircum
                     , xK_ampersand, xK_asterisk, xK_parenleft
                     , xK_parenright
                     ]
         , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
       ]

       -------------------------------------------------------------------- }}}
       -- Keymap: custom commands                                           {{{
       ------------------------------------------------------------------------

       `additionalKeys`
       [
       -- Lock screen
         ((modm     .|. controlMask, xK_l      ), spawn "sh $HOME/.dotfiles/script/shutdown.sh")
       -- Launch terminal
       , ((modm                   .|. shiftMask  , xK_Return ), spawn "alacritty")
       -- Launch file manager
       , ((modm                    , xK_e      ), spawn "pcmanfm")
       -- Launch web browser
       , ((modm                    , xK_q      ), spawn "firefox")
       -- Launch dmenu for launching applicatiton
       , ((modm                    , xK_Return      ), spawn "dmenu_run")--"exe=`dmenu_run -l 10 -fn 'Migu1M:size=20'` && exec $exe")
       -- , ((modm                    , xK_d      ), spawn "rofi -show drun -color-window '#000000, #000000,#000000' -color-normal '#000000, #aaaaaa, #000000, #145f9d, #aaaaaa' -color-active '#000000, #aaaaaa, #000000, #145f9d, #eeeeee' -color-urgent '#000000, #aaaaaa, #000000, #145f9d, #aaaaaa' -hide-scrollbar -location 2")
       -- Play / Pause media keys
       , ((0                       , 0x1008ff18), spawn "sh $HOME/bin/cplay.sh")
       , ((0                       , 0x1008ff14), spawn "sh $HOME/bin/cplay.sh")
       , ((shiftMask               , 0x1008ff18), spawn "streamradio-remote pause")
       , ((shiftMask               , 0x1008ff14), spawn "streamradio-remote pause")
       -- Volume setting media keys
       , ((0 , xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume 0 +2%")
       , ((0 , xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume 0 -2%")
       , ((0 , xF86XK_AudioMute), spawn "pactl set-sink-mute 0 toggle")
       -- Brightness Keys
       --, ((0                       , 0x1008FF03), spawn "xbrightness -5000")
       --, ((0                       , 0x1008FF02), spawn "xbrightness +5000")
       , ((0                       , 0x1008FF02), spawn "light -A 5")
       , ((0                       , 0x1008FF03), spawn "light -U 5")
       -- Take a screenshot (whole window)
       , ((0                       , 0xff61    ), spawn "sh $HOME/bin/screenshot.sh")
       -- Take a screenshot (selected area)
       , ((shiftMask               , 0xff61    ), spawn "sh $HOME/bin/screenshot_select.sh")
       -- Toggle touchpad
       , ((modm                    , xK_p), spawn "/bin/sh $HOME/.dotfiles/script/touchpad_toggle.sh")
       ]

--------------------------------------------------------------------------- }}}
-- myLayout:          Handle Window behaveior                               {{{
-------------------------------------------------------------------------------

myLayout = tile ||| full
  where
    rt = ResizableTall 1 (2/100) (1/2) []
    tile =  smartBorders rt
    full =  noBorders Full
--------------------------------------------------------------------------- }}}
-- myStartupHook:     Start up applications                                 {{{
-------------------------------------------------------------------------------

myStartupHook = do
	spawn "/bin/sh $HOME/.dotfiles/script/startup.sh"
	spawn "nm-applet"
	spawn "seafile-applet"
	spawn "pasystray"
	spawn "xrandr --output HDMI2 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --off --output eDP1 --mode 1366x768 --pos 1920x312 --rotate normal --output VIRTUAL1 --off"
	setWMName "LG3D"
--------------------------------------------------------------------------- }}}
-- myManageHookShift: some window must created there                        {{{
-------------------------------------------------------------------------------

myManageHookShift = composeAll
            -- if you want to know className, type "$ xprop|grep CLASS" on shell
            [ className =? "Firefox"       --> mydoShift "2"
            ]
             where mydoShift = doF . liftM2 (.) W.greedyView W.shift

--------------------------------------------------------------------------- }}}
-- myManageHookFloat: new window will created in Float mode                 {{{
-------------------------------------------------------------------------------

myManageHookFloat = composeAll
    [ className =? "Gimp"             --> doFloat
    , title     =? "urxvt_float"      --> doCenterFloat
    ]

--------------------------------------------------------------------------- }}}
-- myLogHook:         loghock settings                                      {{{
-------------------------------------------------------------------------------

myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }

--------------------------------------------------------------------------- }}}
-- myWsBar:           xmobar setting                                        {{{
-------------------------------------------------------------------------------

myWsBar = "xmobar ~/.config/xmonad/xmobarrc"

wsPP = xmobarPP { ppOrder           = \(ws:l:t:_)  -> [ws,t]
                , ppCurrent         = xmobarColor colorWhite colorNormalbg . \s -> "*"
                , ppUrgent          = xmobarColor colorfg    colorNormalbg . \s -> "*"
                , ppVisible         = xmobarColor colorfg    colorNormalbg . \s -> "*"
                , ppHidden          = xmobarColor colorfg    colorNormalbg . \s -> "*"
                , ppHiddenNoWindows = xmobarColor colorfg    colorNormalbg . \s -> "-"
                , ppTitle           = xmobarColor colorGreen colorNormalbg
                , ppOutput          = putStrLn
                , ppWsSep           = " "
                , ppSep             = " : "
                }

--------------------------------------------------------------------------- }}}
-- myXPConfig:        XPConfig                                            {{{

-- myXPConfig = defaultXPConfig
--                 { font              = "xft:Migu 1M:size=12:antialias=true"
--                 , fgColor           = colorfg
--                 , bgColor           = colorNormalbg
--                 , borderColor       = colorNormalbg
--                 , height            = 20
--                 , promptBorderWidth = 1
--                 , autoComplete      = Just 100000
--                 , bgHLight          = colorWhite
--                 , fgHLight          = colorNormalbg
--                 , position          = Bottom
--                 }

--------------------------------------------------------------------------- }}}
-- newMouse:          Right click is used for resizing window               {{{
-------------------------------------------------------------------------------

myMouse x = [ ((modm, button3), (\w -> focus w >> Flex.mouseResizeWindow w)) ]
newMouse x = M.union (mouseBindings defaultConfig x) (M.fromList (myMouse x))

--------------------------------------------------------------------------- }}}
