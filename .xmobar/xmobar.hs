Config {
    -- Position xmobar along the top, with a stalonetray in the top right.
    -- Add right padding to xmobar to ensure stalonetray and xmobar don't
    -- overlap. stalonetrayrc-single is configured for 12 icons, each 23px
    -- wide. 
    -- right_padding = num_icons * icon_size
    -- right_padding = 12 * 23 = 276
    -- Example: position = TopP 0 276
    font = "xft:Px437 IBM 3270pc:size=11:antialias=true:autohint=true",
    bgColor = "#000000",
    fgColor = "#ffffff",
    lowerOnStart = False,
    overrideRedirect = False,
    allDesktops = True,
    persistent = True,
    commands = [

        Run DynNetwork     [ "--template" , "<dev>: <tx> <rx>"
														 , "--Low"      , "10000"       -- units: B/s
														 , "--High"     , "50000"       -- units: B/s
														 , "--low"      , "green"
														 , "--normal"   , "green"
														 , "--high"     , "red"
														 ] 10,


	Run Battery [
	"-t", "<acstatus>: <left>% <timeleft>",
	"--",
	--"-c", "charge_full",
	"-O", "AC",
	"-o", "Bat",
	"-h", "green",
	"-l", "red"
	] 10,
        Run Weather "KPAO" ["-t","<tempF>F <skyCondition>","-L","64","-H","77","-n","#CEFFAC","-h","#FFB6B0","-l","#96CBFE"] 36000,
				Run MultiCpu ["-t","CPU <total0> <total1> <total2> <total3> <total4> <total5> <total6> <total7>","-L","30","-H","60","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-w","3"] 10,
				-- Run Cpu [
	-- "-L", "3",
	-- "-H", "50",
	-- "--normal", "green",
	-- "--high","red"
	-- ]
	-- 10,
        Run Memory ["-t","MEM <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        -- Run Swap ["-t","Swap: <usedratio>%","-H","1024","-L","512","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        -- Run Network "eth0" ["-t","Net: <rx>, <tx>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        -- Run Network "eth0" ["-t","Net: <rx>, <tx>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
				    -- time and date indicator 
        --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
        Run Date           "<fc=#8be9fd>%F</fc> <fc=#666666>│</fc> %H:%M" "date" 10,
        -- Run Date "%a %b %_d %l:%M" "date" 10,
        -- Run Com "getMasterVolume" [] "volumelevel" 10,
	-- Run Com "/bin/bash" ["-c", "echo `xbacklight -get | grep -oE '^.[0-9]{0,3}'`%"]  "mybright" 1,
	-- Run Com "/bin/bash" ["-c", "~/.local/bin/get-volume.sh"]  "myvolume" 100,
        Run StdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% <fc=#666666>│</fc> %battery% }{ %multicpu% <fc=#666666>│</fc> %memory% <fc=#666666>│</fc> %dynnetwork% <fc=#666666>│</fc> %date%"
}

-- Config { 

   -- -- appearance
     -- font =         "xft:Bitstream Vera Sans Mono:size=9:bold:antialias=true"
   -- , bgColor =      "black"
   -- , fgColor =      "#646464"
   -- , position =     Top
   -- , border =       BottomB
   -- , borderColor =  "#646464"

   -- -- layout
   -- , sepChar =  "%"   -- delineator between plugin names and straight text
   -- , alignSep = "}{"  -- separator between left-right alignment
   -- , template = "%battery% | %multicpu% | %coretemp% | %memory% | %dynnetwork% }{ %RJTT% | %date% || %kbd% "

   -- -- general behavior
   -- , lowerOnStart =     True    -- send to bottom of window stack on start
   -- , hideOnStart =      False   -- start with window unmapped (hidden)
   -- , allDesktops =      True    -- show on all desktops
   -- , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
   -- , pickBroadest =     False   -- choose widest display (multi-monitor)
   -- , persistent =       True    -- enable/disable hiding (True = disabled)

   -- -- plugins
   -- --   Numbers can be automatically colored according to their value. xmobar
   -- --   decides color based on a three-tier/two-cutoff system, controlled by
   -- --   command options:
   -- --     --Low sets the low cutoff
   -- --     --High sets the high cutoff
   -- --
   -- --     --low sets the color below --Low cutoff
   -- --     --normal sets the color between --Low and --High cutoffs
   -- --     --High sets the color above --High cutoff
   -- --
   -- --   The --template option controls how the plugin is displayed. Text
   -- --   color can be set by enclosing in <fc></fc> tags. For more details
   -- --   see http://projects.haskell.org/xmobar/#system-monitor-plugins.
   -- , commands = 

        -- -- weather monitor
        -- [ Run Weather "RJTT" [ "--template", "<skyCondition> | <fc=#4682B4><tempC></fc>°C | <fc=#4682B4><rh></fc>% | <fc=#4682B4><pressure></fc>hPa"
                             -- ] 36000

        -- -- network activity monitor (dynamic interface resolution)
        -- , Run DynNetwork     [ "--template" , "<dev>: <tx>kB/s|<rx>kB/s"
                             -- , "--Low"      , "1000"       -- units: B/s
                             -- , "--High"     , "5000"       -- units: B/s
                             -- , "--low"      , "darkgreen"
                             -- , "--normal"   , "darkorange"
                             -- , "--high"     , "darkred"
                             -- ] 10

        -- -- cpu activity monitor
        -- , Run MultiCpu       [ "--template" , "Cpu: <total0>%|<total1>%"
                             -- , "--Low"      , "50"         -- units: %
                             -- , "--High"     , "85"         -- units: %
                             -- , "--low"      , "darkgreen"
                             -- , "--normal"   , "darkorange"
                             -- , "--high"     , "darkred"
                             -- ] 10

        -- -- cpu core temperature monitor
        -- , Run CoreTemp       [ "--template" , "Temp: <core0>°C|<core1>°C"
                             -- , "--Low"      , "70"        -- units: °C
                             -- , "--High"     , "80"        -- units: °C
                             -- , "--low"      , "darkgreen"
                             -- , "--normal"   , "darkorange"
                             -- , "--high"     , "darkred"
                             -- ] 50
                          
        -- -- memory usage monitor
        -- , Run Memory         [ "--template" ,"Mem: <usedratio>%"
                             -- , "--Low"      , "20"        -- units: %
                             -- , "--High"     , "90"        -- units: %
                             -- , "--low"      , "darkgreen"
                             -- , "--normal"   , "darkorange"
                             -- , "--high"     , "darkred"
                             -- ] 10

        -- -- battery monitor
        -- , Run Battery        [ "--template" , "Batt: <acstatus>"
                             -- , "--Low"      , "10"        -- units: %
                             -- , "--High"     , "80"        -- units: %
                             -- , "--low"      , "darkred"
                             -- , "--normal"   , "darkorange"
                             -- , "--high"     , "darkgreen"

                             -- , "--" -- battery specific options
                                       -- -- discharging status
                                       -- , "-o"	, "<left>% (<timeleft>)"
                                       -- -- AC "on" status
                                       -- , "-O"	, "<fc=#dAA520>Charging</fc>"
                                       -- -- charged status
                                       -- , "-i"	, "<fc=#006000>Charged</fc>"
                             -- ] 50

        -- -- time and date indicator 
        -- --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
        -- , Run Date           "<fc=#ABABAB>%F (%a) %T</fc>" "date" 10

        -- -- keyboard layout indicator
        -- , Run Kbd            [ ("us(dvorak)" , "<fc=#00008B>DV</fc>")
                             -- , ("us"         , "<fc=#8B0000>US</fc>")
                             -- ]
        -- ]
   -- }
