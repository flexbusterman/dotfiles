/* See LICENSE file for copyright and license details! */

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int gappih    = 30;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 30;       /* vert inner gap between windows */
static const unsigned int gappoh    = 30;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 30;       /* vert outer gap between windows and screen edge */
static const int smartgaps          = 1;        /* 1 means no outer gap when there is only one window */
static const int swallowfloating    = 1;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
// static const char *fonts[]          = { "Px437 IBM 3270pc:size=11:antialias=true:autohint=true"};
static const char *fonts[]          = { "Px437 IBM BIOS:size=7:antialias=true:autohint=true"};
static char dmenufont[]             = "Px437 IBM BIOS:size=7:antialias=true:autohint=true";
static char normbgcolor[]           = "#000000";
static char normbordercolor[]       = "#111111";
static char normfgcolor[]           = "#cccccc";
static char selfgcolor[]            = "#ffffff";
static char selbordercolor[]        = "#52a7DD";
static char selbgcolor[]            = "#222222";
static char *colors[][3] = {
  /*               fg           bg           border   */
  [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
  [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};

typedef struct {
  const char *name;
  const void *cmd;
} Sp;
const char *spcmd1[] = {"st", "-n", "spterm", "-g", "120x34", NULL };
const char *spcmd2[] = {"st", "-n", "spcalc", "-f", "monospace:size=16", "-g", "50x20", "-e", "bc", "-lq", NULL };
static Sp scratchpads[] = {
  /* name          cmd  */
  {"spterm",      spcmd1},
  {"spranger",    spcmd2},
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
  /* class						instance    title      		    tags mask  	isfloating  isterminal  noswallow  monitor */
  { "mpv",						NULL,       NULL,							-1,      		0,         	0,        	0,      	-1 },
  { "Barrier",				NULL,				NULL,							1<<7,				0,					0,					0,				-1 },
  { "St",							NULL,				NULL,							0,					0,					1,					0,				-1 },
  { NULL,							NULL,				"EventTester",		0,					0,					0,					1,				-1 },
  { NULL,							"spterm",		NULL,							SPTAG(0),		1,					1,					0,				-1 },
  { NULL,							"spcalc",		NULL,							SPTAG(1),		1,					1,					0,				-1 },
  { NULL,							NULL,				"aug",						1<<8,				0,					1,					1,				-1 },
  { NULL,							NULL,				"PulseEffects",		1<<8,				0,					1,					1,				-1 },
  { NULL,							NULL,				"KeePassXC",			1<<8,				0,					1,					1,				-1 },
  { NULL,							NULL,				"wiki",						1<<7,				0,					1,					1,				-1 },
  { NULL,							NULL,				"terminal",				1<<8,				0,					1,					1,				-1 },
  { NULL,							NULL,				"main",						1<<0,				0,					1,					1,				-1 },
  { "firefox",				NULL,				NULL,							1<<1,				0,					1,					1,				-1 },
  { "Patchage",				NULL,				NULL,							1<<1,				0,					1,					1,				-1 },
  { "Spotify",				NULL,				NULL,							1<<2,				0,					0,					0,				-1 },
  { "deadbeef",				NULL,				NULL,							1<<2,				0,					0,					0,				-1 },
  { "Zathura",				NULL,				NULL,							0,					0,					0,					1,				-1 },
};

/* layout(s) */
static const float mfact     = 0.60; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"
static const Layout layouts[] = {
  /* symbol     arrange function */
  { "[@]",  spiral },   /* Fibonacci spiral */
  { "TTT",  bstack },   /* Master on top, slaves on bottom */
  { "|M|",  centeredmaster },   /* Master in middle, slaves on sides */
  { ">M>",  centeredfloatingmaster }, /* Same but master floats */
  { "[]=",  tile },     /* Default: Master on left, slaves on right */
  { "[\\]", dwindle },    /* Decreasing in size right and leftward */
  { "H[]",  deck },     /* Master on left, slaves in monocle-like mode on right */
  { "[M]",  monocle },    /* All windows on top of eachother */
  { "><>",  NULL },     /* no layout function means floating behavior */
  { NULL,   NULL },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define STACKKEYS(MOD,ACTION) \
{ MOD,  XK_j, ACTION##stack,  {.i = INC(+1) } }, \
{ MOD,  XK_k, ACTION##stack,  {.i = INC(-1) } }, \
{ MODKEY|ShiftMask,  XK_space,   ACTION##stack,  {.i = 0 } }, \

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *reboot[] = { "reboot", NULL };
static const char *poweroff[] = { "poweroff", NULL };
// static const char *vifm[] = { "st env SHELL=/bin/bash vifm", NULL };

#include <X11/XF86keysym.h>
#include "shiftview.c"
static Key keys[] = {
	{ MODKEY|ShiftMask,                       XK_l, spawn,  SHCMD("slock" ) },
	{ MODKEY|ShiftMask,                       XK_s, spawn,  SHCMD("st -e zsh -c yt" ) },
	{ MODKEY,                       XK_d, spawn,  SHCMD("sleep 0.2 && xdotool type --clearmodifiers \"$(date +\"%F \")\"")},
  { MODKEY|ShiftMask,                       XK_b, spawn,  SHCMD("bluetoothctl show | grep -i powered | grep -i yes && notify-send 'Bluetooth is on' && pactl set-card-profile bluez_card.74_5C_4B_D2_86_F7 a2dp_sink || notify-send 'Starting bluetooth' && bluetoothctl power on && bluetoothctl -- connect 74:5C:4B:D2:86:F7 && pactl set-card-profile bluez_card.74_5C_4B_D2_86_F7 a2dp_sink")},
  { MODKEY|ControlMask|ShiftMask,                       XK_s, spawn,  SHCMD("setxkbmap se; setxkbmap -option \"caps:swapescape\"; xset r rate 300 50")},
  { MODKEY|ControlMask|ShiftMask,                       XK_u, spawn,  SHCMD("setxkbmap us; setxkbmap -option \"caps:swapescape\"; xset r rate 300 50")},
  { MODKEY,     XK_w,   killclient, {0} },
  { MODKEY,                       XK_Return, spawn,          {.v = dmenucmd } },
  { MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
  { MODKEY|ControlMask|ShiftMask,             XK_r, spawn,          {.v = reboot } },
  { MODKEY|ControlMask|ShiftMask,             XK_p, spawn,          {.v = poweroff } },
  { MODKEY,     XK_q,    spawn,    SHCMD("qutebrowser") },
  { MODKEY|ControlMask|ShiftMask,     XK_period,    spawn,    SHCMD("brave https://mail.google.com/mail/u/0/#inbox https://mail.google.com/mail/u/1/#inbox https://mail.google.com/mail/u/3/#inbox https://calendar.google.com") },
  { MODKEY|ShiftMask,     XK_period,    spawn,    SHCMD("brave") },
	{ MODKEY|ShiftMask,                       XK_comma, spawn,  SHCMD("st env SHELL=/bin/zsh vifmrun")},
  { 0,        XK_Print, spawn,    SHCMD("maim -f jpg -m 9 \"/home/flex/Pictures/SCREENSHOTS/$(date +\"%F %H_%M_%S.jpg\")\"")},
  { ShiftMask,        XK_Print, spawn,    SHCMD("maim -f jpg -m 9 -s \"/home/flex/Pictures/SCREENSHOTS/$(date +\"%F %H_%M_%S.jpg\")\"")},
  STACKKEYS(MODKEY,                          focus)
	STACKKEYS(MODKEY|ShiftMask,                push)
	{ MODKEY,     XK_grave, spawn,  SHCMD("dmenuunicode") },
  TAGKEYS(      XK_1,   0)
	TAGKEYS(      XK_2,   1)
	TAGKEYS(      XK_3,   2)
	TAGKEYS(      XK_4,   3)
	TAGKEYS(      XK_5,   4)
	TAGKEYS(      XK_6,   5)
	TAGKEYS(      XK_7,   6)
	TAGKEYS(      XK_8,   7)
	TAGKEYS(      XK_9,   8)
	{ MODKEY,     XK_0,   view,   {.ui = ~0 } },
	{ MODKEY|ShiftMask,   XK_0,   tag,    {.ui = ~0 } },
	{ MODKEY,     XK_BackSpace, spawn,    SHCMD("sysact") },
	{ MODKEY|ShiftMask,   XK_BackSpace, spawn,    SHCMD("sysact") },
	{ MODKEY,     XK_Tab,   view,   {0} },
	{ MODKEY|ShiftMask,   XK_q,   spawn,    SHCMD("sysact") },
	{ MODKEY|ShiftMask,   XK_w,   spawn,    SHCMD("st -e sudo nmtui") },
	{ MODKEY,     XK_e,   spawn,    SHCMD("st -e neomutt") },
	{ MODKEY|ShiftMask,   XK_e,   spawn,    SHCMD("st -e abook -C ~/.config/abook/abookrc --datafile ~/.config/abook/addressbook") },
	{ MODKEY|ShiftMask,   XK_h,   spawn,    SHCMD("st -e htop") },
	{ MODKEY,   XK_p,   spawn,    SHCMD("keepassxc") },
	{ MODKEY,     XK_t,   setlayout,  {.v = &layouts[2]} }, /* tile */
	{ MODKEY|ShiftMask,   XK_t,   setlayout,  {.v = &layouts[1]} }, /* bstack */
	{ MODKEY,     XK_y,   setlayout,  {.v = &layouts[0]} }, /* spiral */
	{ MODKEY|ShiftMask,   XK_y,   setlayout,  {.v = &layouts[3]} }, /* dwindle */
	{ MODKEY,     XK_u,   setlayout,  {.v = &layouts[4]} }, /* deck */
	{ MODKEY|ShiftMask,   XK_u,   setlayout,  {.v = &layouts[5]} }, /* monocle */
	{ MODKEY,     XK_i,   setlayout,  {.v = &layouts[6]} }, /* centeredmaster */
	{ MODKEY|ShiftMask,   XK_i,   setlayout,  {.v = &layouts[7]} }, /* centeredfloatingmaster */
	{ MODKEY,     XK_equal,   incnmaster,     {.i = +1 } },
	{ MODKEY,   XK_minus,   incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,   XK_p,     spawn,    SHCMD("pulseeffects") },
	{ MODKEY,     XK_backslash,   view,   {0} },
	{ MODKEY,     XK_a,   togglegaps, {0} },
	{ MODKEY|ShiftMask,   XK_a,   defaultgaps,  {0} },
	{ MODKEY,     XK_s,   togglesticky, {0} },
	{ MODKEY,     XK_f,   togglefullscr,  {0} },
	{ MODKEY|ShiftMask,   XK_f,   setlayout,  {.v = &layouts[8]} },
	{ MODKEY,     XK_g,   shiftview,  { .i = -1 } },
	{ MODKEY|ShiftMask,   XK_g,   shifttag, { .i = -1 } },
	{ MODKEY,     XK_h,   setmfact, {.f = -0.05} },
	{ MODKEY,     XK_l,   setmfact,       {.f = +0.05} },
	{ MODKEY|ControlMask|ShiftMask,    XK_p,  togglescratch,  {.ui = 1} },
	{ MODKEY,     XK_z,   incrgaps, {.i = +3 } },
	{ MODKEY,     XK_x,   incrgaps, {.i = -3 } },
	{ MODKEY|ShiftMask,    XK_x,   spawn,    SHCMD("xkill") },
	{ MODKEY|ShiftMask,      XK_c,   spawn,    SHCMD("st -e calcurse") },
	{ MODKEY|ControlMask|ShiftMask,    XK_c,   spawn,    SHCMD("cadence") },
	{ MODKEY,     XK_s,   togglebar,  {0} },
	{ MODKEY,     XK_n,   spawn,    SHCMD("cd ~/Dropbox/NOTES/; st -e nvim -c VimwikiIndex") },
	{ MODKEY|ShiftMask,   XK_n,   spawn,    SHCMD("st -e newsboat") },
	{ MODKEY,     XK_m,   spawn,    SHCMD("st -e ncmpcpp") },
	{ MODKEY|ShiftMask,   XK_m,   spawn,    SHCMD("aconnect 127:7 16:0; aconnect 128:7 16:0; aconnect 129:7 16:0; aconnect 130:7 16:0") },
	{ MODKEY|ControlMask|ShiftMask,     XK_Left, spawn,    SHCMD("audtool playlist-reverse") },
	{ MODKEY|ControlMask|ShiftMask,     XK_period,  spawn,    SHCMD("audtool playlist-advance") },
	{ MODKEY|ControlMask|ShiftMask,     XK_j,  focusmon, {.i = -1 } },
	{ MODKEY|ControlMask|ShiftMask,     XK_h,  tagmon, {.i = -1 } }, /* { MODKEY,     XK_Right, focusmon, {.i = +1 } }, */
	{ MODKEY|ControlMask|ShiftMask,    XK_k, focusmon, {.i = +1 } },
	{ MODKEY|ControlMask|ShiftMask,    XK_l, tagmon, {.i = +1 } },
	{ MODKEY,     XK_Page_Up, shiftview,  { .i = -1 } },
	{ MODKEY|ShiftMask,   XK_Page_Up, shifttag, { .i = -1 } },
	{ MODKEY,     XK_Page_Down, shiftview,  { .i = +1 } },
	{ MODKEY|ShiftMask,   XK_Page_Down, shifttag, { .i = +1 } },
	{ MODKEY,     XK_F1,    spawn,    SHCMD("groff -mom /usr/local/share/dwm/larbs.mom -Tpdf | zathura -") },
	{ MODKEY,     XK_F2,    spawn,    SHCMD("tutorialvids") },
	{ MODKEY,     XK_F3,    spawn,    SHCMD("displayselect") },
	{ MODKEY,     XK_F4,    spawn,    SHCMD("st -e pulsemixer; kill -44 $(pidof dwmblocks)") },
	{ MODKEY,     XK_F5,    xrdb,   {.v = NULL } },
	{ MODKEY,     XK_F6,    spawn,    SHCMD("torwrap") },
	{ MODKEY,     XK_F7,    spawn,    SHCMD("td-toggle") },
	{ MODKEY,     XK_F8,    spawn,    SHCMD("mailsync") },
	{ MODKEY,     XK_F9,    spawn,    SHCMD("dmenumount") },
	{ MODKEY,     XK_F10,   spawn,    SHCMD("dmenuumount") },
	{ MODKEY,     XK_F11,   spawn,    SHCMD("mpv --no-cache --no-osc --no-input-default-bindings --input-conf=/dev/null --title=webcam $(ls /dev/video[0,2,4,6,8] | tail -n 1)") },
	{ MODKEY,     XK_F12,   xrdb,   {.v = NULL } },
	{ MODKEY,     XK_space, zoom,   {0} },
	{ MODKEY|ShiftMask,   XK_f, togglefloating, {0} },
	{ MODKEY,     XK_Print, spawn,    SHCMD("dmenurecord") },
	{ MODKEY|ShiftMask,   XK_Print, spawn,    SHCMD("dmenurecord kill") },
	{ MODKEY,     XK_Delete,  spawn,    SHCMD("dmenurecord kill") },
	{ MODKEY,     XK_Scroll_Lock, spawn,    SHCMD("killall screenkey || screenkey &") },
	{ ControlMask|ShiftMask, XK_k, spawn,    SHCMD("deadbeef --prev") },
	{ ControlMask|ShiftMask, XK_j, spawn,    SHCMD("deadbeef --next") },
	{ ControlMask|ShiftMask, XK_space, spawn,    SHCMD("deadbeef --play-pause") },
	{ ControlMask|ShiftMask, XK_q, spawn,    SHCMD("deadbeef --quit") },
	{ ControlMask|ShiftMask, XK_Return, spawn,    SHCMD("deadbeef") },
	{ MODKEY|ControlMask|ShiftMask, XK_t, spawn,    SHCMD("tetris") },
	{ 0, XF86XK_AudioMute,    spawn,    SHCMD("pamixer -t; kill -44 $(pidof dwmblocks)") },
	{ 0, XF86XK_AudioRaiseVolume, spawn,    SHCMD("pamixer --allow-boost -i 3; kill -44 $(pidof dwmblocks)") },
	{ 0, XF86XK_AudioLowerVolume, spawn,    SHCMD("pamixer --allow-boost -d 3; kill -44 $(pidof dwmblocks)") },
	{ 0, XF86XK_AudioPrev,    spawn,    SHCMD("mpc prev") },
	{ 0, XF86XK_AudioNext,    spawn,    SHCMD("mpc next") },
	{ 0, XF86XK_AudioPause,   spawn,    SHCMD("mpc pause") },
	{ 0, XF86XK_AudioPlay,    spawn,    SHCMD("mpc play") },
	{ 0, XF86XK_AudioStop,    spawn,    SHCMD("mpc stop") },
	{ 0, XF86XK_AudioRewind,  spawn,    SHCMD("mpc seek -10") },
	{ 0, XF86XK_AudioForward, spawn,    SHCMD("mpc seek +10") },
	{ 0, XF86XK_AudioMedia,   spawn,    SHCMD("st -e ncmpcpp") },
	{ 0, XF86XK_PowerOff,   spawn,    SHCMD("sysact") },
	{ 0, XF86XK_Sleep,    spawn,    SHCMD("sudo -A zzz") },
	{ 0, XF86XK_WWW,    spawn,    SHCMD("$BROWSER") },
	{ 0, XF86XK_DOS,    spawn,    SHCMD("st") },
	{ 0, XF86XK_ScreenSaver,  spawn,    SHCMD("slock & xset dpms force off; mpc pause; pauseallmpv") },
	{ 0, XF86XK_TaskPane,   spawn,    SHCMD("st -e htop") },
	{ 0, XF86XK_Mail,   spawn,    SHCMD("st -e neomutt") },
	{ 0, XF86XK_Launch1,    spawn,    SHCMD("xset dpms force off") },
	{ 0, XF86XK_TouchpadToggle, spawn,    SHCMD("(synclient | grep 'TouchpadOff.*1' && synclient TouchpadOff=0) || synclient TouchpadOff=1") },
	{ 0, XF86XK_TouchpadOff,  spawn,    SHCMD("synclient TouchpadOff=1") },
	{ 0, XF86XK_TouchpadOn,   spawn,    SHCMD("synclient TouchpadOff=0") },
	{ 0, XF86XK_MonBrightnessUp,  spawn,    SHCMD("xbacklight -inc $(bc <<< \"$(xbacklight) * 0.5 + 0.15\")") },
	{ 0, XF86XK_MonBrightnessDown,  spawn,    SHCMD("xbacklight -dec $(bc <<< \"$(xbacklight) * 0.5\")") },

};
/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
  /* click                event mask      button          function        argument */
  { ClkWinTitle,          0,              Button2,        zoom,           {0} },
  { ClkStatusText,        0,              Button1,        sigdwmblocks,   {.i = 1} },
  { ClkStatusText,        0,              Button2,        sigdwmblocks,   {.i = 2} },
  { ClkStatusText,        0,              Button3,        sigdwmblocks,   {.i = 3} },
  { ClkStatusText,        0,              Button4,        sigdwmblocks,   {.i = 4} },
  { ClkStatusText,        0,              Button5,        sigdwmblocks,   {.i = 5} },
  { ClkStatusText,        ShiftMask,      Button1,        sigdwmblocks,   {.i = 6} },
  { ClkStatusText,        ShiftMask,      Button3,        spawn,          SHCMD("st -e nvim ~/.local/src/dwmblocks/config.h") },
  { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
  { ClkClientWin,         MODKEY,         Button2,        defaultgaps,  {0} },
  { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
  { ClkClientWin,   MODKEY,   Button4,  incrgaps, {.i = +1} },
  { ClkClientWin,   MODKEY,   Button5,  incrgaps, {.i = -1} },
  { ClkTagBar,            0,              Button1,        view,           {0} },
  { ClkTagBar,            0,              Button3,        toggleview,     {0} },
  { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
  { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
  { ClkTagBar,    0,    Button4,  shiftview,  {.i = -1} },
  { ClkTagBar,    0,    Button5,  shiftview,  {.i = 1} },
  { ClkRootWin,   0,    Button2,  togglebar,  {0} },
};
