# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.log_utils import logger

@lazy.function
def my_function(qtile):
    lazy.spawn("notify-send hello")

mod = "mod1"
terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    # Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    # Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Key([mod], "space", lazy.layout.swap_main(), desc="Move window focus to other window"),
    # Key([mod], "space", lazy.function(custom_master_swap), desc="Custom DWM-like master swap"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    # Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    # Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    # Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    # Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod,], "h", lazy.layout.shrink_main(), desc="Grow window to the left"),
    Key([mod,], "l", lazy.layout.grow_main(), desc="Grow window to the right"),
    # Key([mod, "shift"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    # Key([mod, "shift"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    # Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    # Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    # Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Key(
    #     [mod, "shift"],
    #     "Return",
    #     lazy.layout.toggle_split(),
    #     desc="Toggle between split and unsplit sides of stack",
    # ),
    Key([mod, "shift"], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod, "shift"], "space", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    # Key([mod], "a", lazy.spawn(), desc=""),
    # Key([mod, "shift"], "a", lazy.spawn(), desc=""),
    # Key([mod, "control"], "a", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "a", lazy.spawn(), desc=""),
    Key([mod], "b", lazy.spawn("bluetoothconnect $HEADPHONES"), desc="Connect to bluetooth device $HEADPHONES"),
    Key([mod, "shift"], "b", lazy.spawn("bluetoothctl disconnect $HEADPHONES"), desc="Disconnect bluetooth device $HEADPHONES"),
    # Key([mod, "control"], "b", lazy.spawn(), desc=""),
    Key([mod, "shift", "control"], "b", lazy.spawn("blueman-manager"), desc="Blueman bluetooth manager"),
    Key([mod], "c", lazy.spawn("reaperconnect"), desc="Connect Reaper outputs to bluetooth headphones outputs"),
    Key([mod, "shift"], "c", lazy.spawn("qutebrowser https://calendar.google.com/calendar/r/month"), desc="Open Google calendar in Qutebrowser"),
    # Key([mod, "control"], "c", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "c", lazy.spawn(), desc=""),
    # Key([mod], "d", lazy.spawn("xdotool keyup Alt_L Alt_R Control_L Control_R Shift_L Shift_R; xdotool type $(date \+\%F)"), desc="Insert current date using xdotool"),
    Key([mod], "d", lazy.spawn("bash -c 'xdotool keyup Alt_L Alt_R Control_L Control_R Shift_L Shift_R; xdotool type \"$(date +%F) \"'"), desc="Insert current date using xdotool"),
    # Key([mod, "shift"], "d", lazy.spawn(), desc=""),
    # Key([mod, "control"], "d", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "d", lazy.spawn(), desc=""),
    # Key([mod], "e", lazy.spawn(), desc=""),
    # Key([mod, "shift"], "e", lazy.spawn(), desc=""),
    # Key([mod, "control"], "e", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "e", lazy.spawn(), desc=""),
    # taken Key([mod], "f", lazy.spawn(), desc=""),
    # Key([mod, "shift"], "f", lazy.spawn(), desc=""),
    # Key([mod, "control"], "f", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "f", lazy.spawn(), desc=""),
    # Key([mod], "g", lazy.spawn(), desc=""),
    # Key([mod, "shift"], "g", lazy.spawn(), desc=""),
    # Key([mod, "control"], "g", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "g", lazy.spawn(), desc=""),
    # Key([mod], "h", lazy.spawn(), desc=""),
    # Key([mod, "shift"], "h", lazy.spawn(), desc=""),
    # Key([mod, "control"], "h", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "h", lazy.spawn(), desc=""),
    # Key([mod], "i", lazy.spawn(), desc=""),
    Key([mod, "shift"], "i", lazy.spawn("xcalib -i -a"), desc="Invert screen colors (invert dark mode)"),
    # Key([mod, "control"], "i", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "i", lazy.spawn(), desc=""),
    # Key([mod], "j", lazy.spawn(), desc=""),
    # Key([mod, "shift"], "j", lazy.spawn(), desc=""),
    # Key([mod, "control"], "j", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "j", lazy.spawn(), desc=""),
    # Key([mod], "k", lazy.spawn(), desc=""),
    # Key([mod, "shift"], "k", lazy.spawn(), desc=""),
    # Key([mod, "control"], "k", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "k", lazy.spawn(), desc=""),
    # Key([mod], "l", lazy.spawn(), desc=""),
    # Key([mod, "shift"], "l", lazy.spawn(), desc=""),
    # Key([mod, "control"], "l", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "l", lazy.spawn(), desc=""),
    Key([mod], "m", lazy.spawn("mullvadconnect"), desc="Connect Mullvad VPN"),
    Key([mod, "shift"], "m", lazy.spawn("mullvaddisconnect"), desc="Disconnect Mullvad VPN"),
    Key([mod, "control"], "m", lazy.spawn("kruler"), desc="Screen ruler"),
    # Key([mod, "shift", "control"], "m", lazy.spawn(), desc=""),
    Key([mod], "n", lazy.spawn("alacritty -e zsh -c 'cd ~/Dropbox/NOTES/; nvim ~/Dropbox/NOTES/TODO.md'"), desc="Nvim edit TODO.md"),
    Key([mod, "shift"], "n", lazy.spawn("alacritty -e fzfnotes"), desc="Fuzzy find note file and open in nvim"),
    # Key([mod, "control"], "n", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "n", lazy.spawn(), desc=""),
    # TODO: add video folder as variable
    Key([mod], "o", lazy.spawn("fzfvideo"), desc="Fuzzy finds and plays file in video folder"),
    # Key([mod, "shift"], "o", lazy.spawn(), desc=""),
    # Key([mod, "control"], "o", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "o", lazy.spawn(), desc=""),
    # Key([mod], "p", lazy.spawn(), desc=""),
    # Key([mod, "shift"], "p", lazy.spawn(), desc=""),
    # Key([mod, "control"], "p", lazy.spawn(), desc=""),
    Key([mod, "shift", "control"], "p", lazy.spawn("poweroff"), desc="Poweroff"),
    Key([mod], "q", lazy.spawn("qpwgraph"), desc="Manage PipeWire connections"),
    # Key([mod, "shift"], "q", lazy.spawn(), desc=""),
    # Key([mod, "control"], "q", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "q", lazy.spawn(), desc=""),
    Key([mod], "r", lazy.spawn("reaper"), desc="Reaper DAW"),
    # Key([mod, "shift"], "r", lazy.spawn(), desc=""),
    # Key([mod, "control"], "r", lazy.spawn(), desc=""),
    Key([mod, "shift", "control"], "r", lazy.spawn("reboot"), desc="Reboot"),
    Key([mod], "s", lazy.spawn("alacritty -e tmuxsession SuperCollider 'supercollider'"), desc="Start nvim SuperCollider session with scnvim and tmux"),
    Key([mod, "shift"], "s", lazy.spawn("tmux kill-session -t SuperCollider"), desc="Kill nvim SuperCollider tmux session"),
    # Key([mod, "control"], "s", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "s", lazy.spawn(), desc=""),
    Key([mod], "t", lazy.spawn("alacritty -e btop"), desc="Btop system monitor"),
    Key([mod, "shift"], "t", lazy.spawn("alacritty -e htop"), desc="Htop system monitor (htop-vim)"),
    # Key([mod, "control"], "t", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "t", lazy.spawn(), desc=""),
    # Key([mod], "u", lazy.spawn(), desc=""),
    # Key([mod, "shift"], "u", lazy.spawn(), desc=""),
    # Key([mod, "control"], "u", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "u", lazy.spawn(), desc=""),
    # Key([mod], "v", lazy.spawn(), desc=""),
    # Key([mod, "shift"], "v", lazy.spawn(), desc=""),
    # Key([mod, "control"], "v", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "v", lazy.spawn(), desc=""),
    # taken Key([mod], "w", lazy.spawn(), desc=""),
    # Key([mod, "shift"], "w", lazy.spawn(), desc=""),
    # Key([mod, "control"], "w", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "w", lazy.spawn(), desc=""),
    Key([mod], "x", lazy.spawn("xkill"), desc="Click to kill window"),
    # Key([mod, "shift"], "x", lazy.spawn(), desc=""),
    # Key([mod, "control"], "x", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "x", lazy.spawn(), desc=""),
    # Key([mod], "y", lazy.spawn(), desc=""),
    # Key([mod, "shift"], "y", lazy.spawn(), desc=""),
    # Key([mod, "control"], "y", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "y", lazy.spawn(), desc=""),
    # Key([mod], "z", lazy.spawn(), desc=""),
    # Key([mod, "shift"], "z", lazy.spawn(), desc=""),
    # Key([mod, "control"], "z", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "z", lazy.spawn(), desc=""),
    Key([mod], "F1", lazy.spawn("bindings"), desc="Show keyboard bindings"),
    # Key([mod, "shift"], "F1", lazy.spawn(), desc=""),
    # Key([mod, "control"], "F1", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "F1", lazy.spawn(), desc=""),
    Key([mod], "F2", lazy.spawn("resolution"), desc="Select display resolution"),
    # Key([mod, "shift"], "F2", lazy.spawn(), desc=""),
    # Key([mod, "control"], "F2", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "F2", lazy.spawn(), desc=""),
    Key([mod], "F3", lazy.spawn("displaydefault"), desc="Set default screen resolution"),
    Key([mod, "shift"], "F3", lazy.spawn("displayselect"), desc="Luke Smith LARBS display select script"),
    # Key([mod, "control"], "F3", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "F3", lazy.spawn(), desc=""),
    Key([mod], "F4", lazy.spawn("alacritty -e pulsemixer"), desc="Pulsemixer TUI audio device management"),
    Key([mod, "shift"], "F4", lazy.spawn("pavucontrol"), desc="Pavucontrol GUI audio device management"),
    # Key([mod, "control"], "F4", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "F4", lazy.spawn(), desc=""),
    # Key([mod], "F5", lazy.spawn(), desc=""),
    # Key([mod, "shift"], "F5", lazy.spawn(), desc=""),
    # Key([mod, "control"], "F5", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "F5", lazy.spawn(), desc=""),
    # Key([mod], "F6", lazy.spawn(), desc=""),
    # Key([mod, "shift"], "F6", lazy.spawn(), desc=""),
    # Key([mod, "control"], "F6", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "F6", lazy.spawn(), desc=""),
    Key([mod], "F7", lazy.spawn("td-toggle"), desc="Luke Smith LARBS Transmission daemon toggle script"),
    # Key([mod, "shift"], "F7", lazy.spawn(), desc=""),
    # Key([mod, "control"], "F7", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "F7", lazy.spawn(), desc=""),
    Key([mod], "F8", lazy.spawn("mounter"), desc=""),
    # Key([mod, "shift"], "F8", lazy.spawn(), desc=""),
    # Key([mod, "control"], "F8", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "F8", lazy.spawn(), desc=""),
    Key([mod], "F9", lazy.spawn("unmounter"), desc=""),
    # Key([mod, "shift"], "F9", lazy.spawn(), desc=""),
    # Key([mod, "control"], "F9", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "F9", lazy.spawn(), desc=""),
    Key([mod], "F10", lazy.spawn("campreview"), desc=""),
    # Key([mod, "shift"], "F10", lazy.spawn(), desc=""),
    # Key([mod, "control"], "F10", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "F10", lazy.spawn(), desc=""),
    Key([mod], "F11", lazy.spawn("dmenurecord"), desc="LARBS screencast record script"),
    # Key([mod, "shift"], "F11", lazy.spawn(), desc=""),
    # Key([mod, "control"], "F11", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "F11", lazy.spawn(), desc=""),
    Key([mod], "F12", lazy.spawn("killrecording"), desc="Stop recording started with dmenurecord"),
    # Key([mod, "shift"], "F12", lazy.spawn(), desc=""),
    # Key([mod, "control"], "F12", lazy.spawn(), desc=""),
    # Key([mod, "shift", "control"], "F12", lazy.spawn(), desc=""),

    Key([mod], "period", lazy.spawn("qutebrowser"), desc="Qutebrowser web browser"),
    Key([mod, "shift"], "period", lazy.spawn("bravestart"), desc="Brave web browser"),
    Key([mod, "shift", "control"], "period", lazy.spawn("firefox"), desc="Firefox web browser"),
    Key([mod], "equal", lazy.spawn("calculate"), desc="Dmenu calculator, result in clipboard"),
    Key([mod], "comma", lazy.spawn("alacritty -e rangerstart"), desc="Start Ranger file manager with image preview support"),
    Key([mod, "shift"], "grave", lazy.spawn("dmenuunicode"), desc="Choose emoji and put in clipboard"),
    Key([mod], "Return", lazy.spawn("dmenu_run"), desc="Launch program using dmenu"),
    Key([mod, "shift", "control"], "Return", lazy.spawn("tidal-hifi"), desc="Tidal music player"),
    Key([mod], "semicolon", lazy.spawn("clipstream"), desc="Stream clipboard link with yt-dlp and webtorrent"),
    Key([mod, "shift"], "semicolon", lazy.spawn("clipdownload"), desc="Download clipboard link as video using yt-dlp"),
    Key([mod, "shift", "control"], "semicolon", lazy.spawn("clipdownload -a"), desc="Download clipboard link as audio using yt-dlp"),
    Key([mod], "slash", lazy.spawn("alacritty -e shortcuts"), desc="Fuzzy finds in, or adds to, Shortcuts.md"),
    Key([mod, "shift"], "slash", lazy.spawn("alacritty -e fzfvim"), desc="Fuzzy find file in home folder and open in nvim"),
    Key([mod, "control"], "slash", lazy.spawn("alacritty -e fzfmusic"), desc="Fuzzy find music and play with mpd"),

    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset Master 5%-"), desc="Lower Volume by 5%"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer sset Master 5%+"), desc="Raise Volume by 5%"),
    Key([], "XF86AudioMute", lazy.spawn("amixer sset Master 1+ toggle"), desc="Mute/Unmute Volume"),
    Key([], "XF86AudioMicMute", lazy.spawn("amixer set Capture toggle"), desc="Mute / unmute mic"),
    Key([], "XF86AudioPlay", lazy.spawn("musicplaypause"), desc="Play / pause music player. Priority is audacious, tidal-hifi, mpc"),
    Key([], "XF86AudioNext", lazy.spawn("musicnext"), desc="Audio player next track. Priority is audacious, tidal-hifi, mpc"),
    Key([], "XF86AudioPrev", lazy.spawn("musicprev"), desc="Audio player previous track. Priority is audacious, tidal-hifi, mpc"),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessup"), desc="Increase display brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessdown"), desc="Decrease display brightness"),

    # Key([mod], "space", lazy.function(dwm_master_swap)),
    # Key([mod], "space", lazy.spawn("notify-send hello")),

    Key( [mod], "space", my_function),

    # TODO:
    # Key([], "Print", lazy.spawn("notify-send 'hello'"), desc=""),
    # Lockscreen binding
  # { 0,															XK_Print,			spawn,					SHCMD("maim -f jpg -m 9 \"/home/flex/Pictures/SCREENSHOTS/$(date +\"%F %H_%M_%S.jpg\")\"")},
  # { ShiftMask,											XK_Print,			spawn,					SHCMD("maim -f jpg -m 9 -s \"/home/flex/Pictures/SCREENSHOTS/$(date +\"%F %H_%M_%S.jpg\")\"")},
    # Mail
	# { MODKEY,													XK_F10,				spawn,					SHCMD("campreview") },
	# { MODKEY,													XK_p,					spawn,					SHCMD("stack -p")},
	# { MODKEY,													XK_y,					spawn,					SHCMD("stack -y")},
	# { MODKEY|ShiftMask,								XK_p,					spawn,					SHCMD("passmenu")},
	# { MODKEY|ShiftMask,								XK_o,					spawn,					SHCMD("ytfzf -m --mpv-opts='--ytdl-format=bestvideo[height<=480]+bestaudio/best[height<=480]' -D")},
	# // { MODKEY|ShiftMask,								XK_o,					spawn,					SHCMD("ytfzf -dD -P ~/Downloads/VIDEO/")},
	# { MODKEY|ControlMask,							XK_d,					spawn,          SHCMD("mpc --host ~/.mpd/socket clear" ) },
	# { MODKEY|ControlMask|ShiftMask,		XK_t,					spawn,					SHCMD("st -T typingtest -e tt -notheme") },
    # transmission-cli
	# { MODKEY|ControlMask,						 	XK_Return,		spawn,					SHCMD("st -T ncmpcpp -e ncmpcpp")},
	# { MODKEY,													XK_s,					spawn,					SHCMD("st -T SuperCollider -e tmuxsession SuperCollider 'supercollider'")},
	# { MODKEY,													XK_t,					spawn,					SHCMD("st -T FoxDot -e foxdot")},
	# // { MODKEY,													XK_t,					spawn,					SHCMD("st -T TidalCycles -e tidalcycles")},
	# { MODKEY|ShiftMask,								XK_t,					spawn,					SHCMD("foxdotkill")},
	# // { MODKEY|ShiftMask,								XK_t,					spawn,					SHCMD("tidalkill")},

]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Spiral(border_focus='#6272a4', border_width=3),
    layout.Max(),
    layout.Stack(num_stacks=2),
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="PxPlus IBM VGA 8x16",
    fontsize=16,
    padding=4,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        # top=bar.Bar(
        #     [
        #         widget.CurrentLayout(),
        #         widget.GroupBox(),
        #         widget.Prompt(),
        #         widget.WindowName(),
        #         widget.Chord(
        #             chords_colors={
        #                 "launch": ("#ff0000", "#DDDDDD"),
        #             },
        #             name_transform=lambda name: name.upper(),
        #         ),
        #         widget.TextBox("default config", name="default"),
        #         widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
        #         # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
        #         # widget.StatusNotifier(),
        #         widget.Systray(),
        #         widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
        #         widget.QuickExit(),
        #     ],
        #     24,
        #     # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
        #     # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        # ),
        top=bar.Bar(
            [
                widget.GroupBox(this_current_screen_border='#6272a4', highlight_method="block", rounded=False, active='#DDDDDD', margin_x=0, margin_y=4),
                widget.Sep(foreground='#404040'),
                widget.CurrentLayout(foreground='#DDDDDD'),
                widget.Sep(foreground='#404040'),
                widget.WindowName(foreground='#DDDDDD'),
                widget.Sep(foreground='#404040'),
                widget.Net(foreground='#DDDDDD', interface='wlp4s0', format='↓ {down:.1f}{down_suffix} ↑ {up:.1f}{up_suffix}',prefix='M'),
                # widget.Net(interface='wlp4s0', format='↓ {down}{down_suffix} ↑ {up}{up_suffix}',prefix='M'),
                widget.Sep(foreground='#404040'),
                widget.CPU(foreground='#DDDDDD'),
                widget.Sep(foreground='#404040'),
                widget.Volume(fmt='VOL {}', foreground='#DDDDDD'),
                widget.Sep(foreground='#404040'),
                widget.Battery(fmt='BAT {}',foreground='#DDDDDD'),
                widget.Sep(foreground='#404040'),
                widget.Clock(foreground='#DDDDDD', format="%Y-%m-%d %H:%M"),
                widget.Sep(foreground='#404040'),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                widget.Systray(),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to DD to indicate that you limit it to DD events per second
        # x11_drag_polling_rate = DD,
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
