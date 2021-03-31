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
    position = TopW L 99,
    commands = [
			Run DynNetwork     [ "--template" , "<dev>: <fc=#00ff00><rx></fc> <fc=#ff0000><tx></fc>" , "-w","5" ] 10
        , Run Battery        [ "--template" , "Batt: <acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "darkred"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkgreen"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"	, "<left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"	, "<fc=#dAA520>Charging</fc>"
                                       -- charged status
                                       , "-i"	, "<fc=#006000>Charged</fc>"
                             ] 50,
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
			Run StdinReader,
			Run  DiskU [("/", "<free>")] ["-L", "20", "-H", "50", "-m", "1", "-p", "3"] 100,
			Run Com "sh" ["-c", "find ~/.local/share/mail/*/*/new/* -type f | command wc -l"] "newmail" 300
			-- Run  Com "find ~/.local/share/mail/*/*/new/* -type f | command wc -l" ["-s", "-r"] 30
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% <fc=#666666>│</fc> %battery% }{ M %newmail% <fc=#666666>│</fc> %dynnetwork% <fc=#666666>│</fc> %multicpu% <fc=#666666>│</fc> %memory% <fc=#666666>│</fc> %disku% <fc=#666666>│</fc> %date%"
}
