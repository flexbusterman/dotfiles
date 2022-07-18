-- ----------------------------------------------------------------------
--  This is the DoomRL initialization file. Modify at your own risk :). 
--  If you mess up something overwrite with a new config.lua.
-- ----------------------------------------------------------------------

dofile "colors.lua"

-- pick here what music set to use (see music.lua and musicmp3.lua)
dofile "musichq.lua" 
dofile "soundhq.lua"

dofile "keybindings.lua"

-- Graphics mode. Can be CONSOLE for raw console, or TILES for graphical 
-- tiles. Overriden by -graphics and -console command line parameters.
-- Graphics = "TILES"
Graphics = "CONSOLE"

-- Sound engine, by default is FMOD on Windows, SDL on *nix. To use SDL on 
-- Windows you'll need SDL_mixer.dll and smpeg.dll from SDL_mixer website.
-- For using FMOD on *nix systems you'll need the proper packages.
-- Possible values are FMOD, SDL, NONE, DEFAULT
-- SoundEngine = "DEFAULT"
SoundEngine = "NONE"

-- SDL sound only options. See SDL_mixer manual on what to put here if
-- defaults don't get you working audio. Format needs to be decoded because
-- Lua doesn't support hex notation.
SDLMixerFreq      = 44100
SDLMixerFormat    = 32784
SDLMixerChunkSize = 1024

-- Windows and GFX mode only:
-- Set to false to turn off the Fullscreen query at run time. If false you
-- can use StartFullscreen to control fullscreen at startup.
FullscreenQuery  = true

-- whether to start in fullscreen mode, use ALT-Enter to toggle, only
-- used when FullscreenQuery is set to false
StartFullscreen  = false

-- Windowed sizes
WindowedWidth       = 800
WindowedHeight      = 600
-- Multiplication values of font and tile display - use at most 2
WindowedFontMult    = 1
WindowedTileMult    = 1
-- minimap size multiplication, set to 0 to remove minimap, -1 is auto
-- choice based on resolution
WindowedMiniMapSize = -1

-- Fullscreen resolution sizes
-- -1 means auto-detection of screen size, and fontmult and tilemult and 
-- minimap based on it
FullscreenWidth       = -1
FullscreenHeight      = -1
FullscreenFontMult    = -1
FullscreenTileMult    = -1
FullscreenMiniMapSize = -1

-- Whether to allow high-ASCII signs. Set to false if you see weird signs 
-- on the screen. Not setting it at all will use the default which
-- is true on Windows and false on OS X and Linux
-- AllowHighAscii   = true

-- Setting to true will skip name entry procedure and choose a random name
-- instead
AlwaysRandomName = false

-- Specifies wether items in inventory and equipment should be colored
ColoredInventory = true

-- Menu styles can be LETTER for letter choince only menus, CHOICE for only arrow 
-- selection or HYBRID for both. Note that additional commands (like BACKSPACE for 
-- in-menu drop and TAB for swap) wont work in the LETTER mode.
InvMenuStyle     = "HYBRID"
EqMenuStyle      = "HYBRID"
HelpMenuStyle    = "HYBRID"

-- Setting this to anything except "" will always use that as the name.
-- Warning - no error checking, so don't use too long names, or especially
-- the "@" sign (it's a control char). This setting overrides the one above!
AlwaysName       = ""

-- Setting to true will skip the intro
SkipIntro        = false

-- Setting to true will remove the bloodslide effect
NoBloodSlides    = false

-- Setting to true will remove the flashing effect
NoFlashing       = false

-- Setting to true will make the run command not stop on items
RunOverItems     = false

-- Setting to false will turn off music during gameplay
GameMusic        = true

-- Setting to false will turn off sounds during gameplay
GameSound        = true

-- Setting to false will turn off Menu change/select sound
MenuSound        = true

-- Setting to true will turn on enhancements for blind people playing
-- DoomRL using a screen reader. Yes, some do.
BlindMode        = false

-- Setting to true will turn on enhancements for colorblind people.
ColorBlindMode   = false

-- Setting to true will make old messages disappear from the screen 
-- (useful in BlindMode)
ClearMessages    = false

-- Setting to false will prevent DoomRL from waiting for confirmation
-- when too many messages are printed in a turn. Usefull for Speedrunning.
MorePrompt       = true

-- Setting to true will make the game wait for an enter/space key if
-- trying to fire an empty weapon.
EmptyConfirm     = false

-- If set to true, pickup sound will be used for quickkeys and weapon
-- swapping.
SoundEquipPickup = false

-- Controls whether gameplay hints appear on the intro level. Once you learn
-- to use the game, you can safely turn it off!
Hints            = true

-- Sets the delay value when running. Value is in milliseconds. Set to 0 for no delay.
RunDelay         = 20

-- Music volume in the range of 0..25
MusicVolume      = 12

-- Sound volume in the range of 0..25
SoundVolume      = 20

-- Handles what should be done in case of trying to unwield an item when inventory
-- is full : if set to false will ask the player if he wants to drop it. If set
-- to true will drop it without questions.
InvFullDrop      = false

-- Messages held in the message buffer.
MessageBuffer    = 100

-- Sets wether message coloring will be enabled. Needs [messages] section.
MessageColoring  = true

-- If set to true will archive EVERY mortem.txt produced in the mortem subfolder.
-- The amount of files can get big after a while :)
MortemArchive    = true

-- Sets the amount of player.wad backups. Set 0 to turn off. At most one backup
-- is held for a given day.
PlayerBackups    = 7

-- Sets the amount of score.wad backups. Set 0 to turn off.  At most one backup
-- is held for a given day.
ScoreBackups     = 7

-- If set to false DoomRL will quit on death and quitting. Normally it will go back
-- to the main menu.
MenuReturn       = true

-- Defines the maximum repeat for the run command. Setting it to larger than 80
-- basically means no limit.
MaxRun           = 100

-- Defines the maximum repeat for the run command when waiting.
MaxWait          = 20

-- Windows only - disables Ctrl-C/Ctrl-Break closing of program. 
-- true by default.
LockBreak        = true

-- Windows only - Disables closing of DoomRL by console close button. 
-- true by default.
LockClose        = true

-- Sets the color of intuition effect for beings
IntuitionColor   = LIGHTMAGENTA

-- Sets the char of intuition effect for beings
IntuitionChar    = "*"

-- Mortem and screenshot timestamp format
-- Format : http://www.freepascal.org/docs-html/rtl/sysutils/formatchars.html
-- note that / and : will be converted to "-" due to filesystem issues
TimeStamp        = "yyyy/mm/dd hh:nn:ss"

-- Controls whether the game will attempt to save the game on crash, set to false
-- to turn this off
SaveOnCrash      = true

-- This is the global internet connection switch, allowing DoomRL
-- to use internet connection features. Think twice before disabling
-- it, or you'll loose the features listed below and MOTD and ModServer
-- support!
NetworkConnection = true

-- Should DoomRL check if there's a new version at runtime. If 
-- NetworkConnection is set to true this check is made regardless,
-- but there will be no alert if set to false.
VersionCheck = true

-- Should DoomRL check if there's a new BETA version at runtime. If 
-- NetworkConnection is set to true this check is made regardless,
-- but there will be no alert if set to false. BETA versions are only
-- available to Supporters, but why not hop in and join the fun?
-- By default it's set to VERSION_BETA which is true for beta releases
-- and false for stable releases. Set to true, to get notified of the
-- next BETA batch!
BetaCheck = VERSION_BETA

-- Should DoomRL check for other alerts. Sometimes we will want to
-- point you out to a major ChaosForge release or news flash. This feature
-- will not be abused, and each alert will be displayed only once, so 
-- please consider leaving this set to true! :)
AlertCheck = true

-- DoomRL by default uses it's own mod server, where we host only screened
-- mods from the DoomRL community. A day may come when there will be an
-- unofficial server, for example for mods in testing. You can specify it 
-- here. Note that this overrides the default server.
CustomModServer = ''

-- Message coloring system. Works only if MessageColoring
-- variable is set to true. Use basic color names available in 
-- colors.lua.
-- As for the string, it's case sensitive, but you may use
-- the wildcard characters * and ?.

-- Unsure how these work and want to fiddle with them?
-- Head over to http://forum.chaosforge.org/ for more info.
Messages = {
	["Warning!*"] 		              = RED,
	["Your * destroyed!"]             = RED,
	["You die*"]                      = RED,
	["Your * damaged!"]               = BROWN,
	["You feel relatively safe now."] = BLUE
}

Keybindings = {
    -- ["LEFT"]         = COMMAND_WALKWEST,
    -- ["RIGHT"]        = COMMAND_WALKEAST,
    -- ["UP"]           = COMMAND_WALKNORTH,
    -- ["DOWN"]         = COMMAND_WALKSOUTH,
    -- ["PGUP"]         = COMMAND_WALKNE,
    -- ["PGDOWN"]       = COMMAND_WALKSE,
    -- ["HOME"]         = COMMAND_WALKNW,
    -- ["END"]          = COMMAND_WALKSW,
    ["H"]            = COMMAND_WALKWEST,
    ["L"]            = COMMAND_WALKEAST,
    ["K"]            = COMMAND_WALKNORTH,
    ["J"]            = COMMAND_WALKSOUTH,
    ["U"]            = COMMAND_WALKNE,
    ["N"]            = COMMAND_WALKSE,
    ["Y"]            = COMMAND_WALKNW,
    ["B"]            = COMMAND_WALKSW,
    ["ESCAPE"]       = COMMAND_ESCAPE,
    ["CENTER"]       = COMMAND_WAIT,
    ["PERIOD"]       = COMMAND_WAIT,
    ["ENTER"]        = COMMAND_OK,
    ["M"]            = COMMAND_MORE,
    ["SHIFT+PERIOD"] = COMMAND_ENTER,
    ["SHIFT+U"]      = COMMAND_UNLOAD,
    -- ["G"]            = COMMAND_PICKUP,
    ["COMMA"]            = COMMAND_PICKUP,
    ["D"]            = COMMAND_DROP,
    ["I"]            = COMMAND_INVENTORY,
    ["E"]            = COMMAND_EQUIPMENT,
    ["O"]            = COMMAND_OPEN,
    ["C"]            = COMMAND_CLOSE,
    -- ["L"]            = COMMAND_LOOK,
    ["V"]            = COMMAND_LOOK,
    ["SPACE"]        = COMMAND_GRIDTOGGLE,
    ["F"]            = COMMAND_FIRE,    -- function() command.fire() end,
    ["SHIFT+F"]      = COMMAND_ALTFIRE, -- function() command.fire( true ) end,
    ["R"]            = function() command.reload() end,
    ["SHIFT+R"]      = function() command.reload( true ) end,
    -- ["U"]            = COMMAND_USE,
    ["SHIFT+U"]      = COMMAND_USE,
    ["SHIFT+Q"]      = function() command.quit() end,
    ["SHIFT+SLASH"]  = function() command.help() end,
    ["SHIFT+2"]      = COMMAND_PLAYERINFO,
    ["SHIFT+S"]      = COMMAND_SAVE,
    TAB              = COMMAND_TACTIC,
    ["A"]        = COMMAND_RUNMODE,
    ["Z"]            = COMMAND_SWAPWEAPON,
--	F10       = function() command.screenshot() end, -- currently hardcoded
--	F9        = function() command.screenshot( true ) end,-- currently hardcoded
    ["T"]            = COMMAND_TRAITS,
    ["SHIFT+9"]      = COMMAND_SOUNDTOGGLE,
    ["SHIFT+0"]      = COMMAND_MUSICTOGGLE,
    ["SHIFT+P"]      = function() command.messages() end,
    ["SHIFT+A"]      = function() command.assemblies() end,
    -- Commands for blind mode:
    ["X"]            = COMMAND_EXAMINENPC,
    ["SHIFT+X"]      = COMMAND_EXAMINEITEM,
    -- QuickKeys
    ["0"]     = function() command.quick_weapon('chainsaw') end,
    ["1"]     = function() command.quick_weapon('knife') end,
    ["2"]     = function() command.quick_weapon('pistol') end,
    ["3"]     = function() command.quick_weapon('shotgun') end,
    ["4"]     = function() command.quick_weapon('ashotgun') end,
    ["5"]     = function() command.quick_weapon('dshotgun') end,
    ["6"]     = function() command.quick_weapon('chaingun') end,
    ["7"]     = function() command.quick_weapon('bazooka') end,
    ["8"]     = function() command.quick_weapon('plasma') end,
    ["9"]     = function() command.quick_weapon('bfg9000') end,

    -- Example of complex quickkey's
    ["SHIFT+N"]    = function()
                    if not command.use_item("smed") then
                        ui.msg("No small medpacks left!")
                    end
                end,
    ["SHIFT+M"]    = function()
                    if not command.use_item("lmed") then
                        ui.msg("No large medpacks left!")
                    end
                end,
}
