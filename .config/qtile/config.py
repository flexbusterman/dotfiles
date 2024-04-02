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

mod = "mod1"
terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
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
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    # Key([mod], "a", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "a", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "a", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "a", lazy.spawncmd(), desc=""),
    # Key([mod], "b", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "b", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "b", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "b", lazy.spawncmd(), desc=""),
    # Key([mod], "c", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "c", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "c", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "c", lazy.spawncmd(), desc=""),
    # Key([mod], "d", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "d", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "d", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "d", lazy.spawncmd(), desc=""),
    # Key([mod], "e", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "e", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "e", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "e", lazy.spawncmd(), desc=""),
    # Key([mod], "f", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "f", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "f", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "f", lazy.spawncmd(), desc=""),
    # Key([mod], "g", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "g", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "g", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "g", lazy.spawncmd(), desc=""),
    # Key([mod], "h", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "h", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "h", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "h", lazy.spawncmd(), desc=""),
    # Key([mod], "i", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "i", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "i", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "i", lazy.spawncmd(), desc=""),
    # Key([mod], "j", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "j", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "j", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "j", lazy.spawncmd(), desc=""),
    # Key([mod], "k", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "k", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "k", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "k", lazy.spawncmd(), desc=""),
    # Key([mod], "l", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "l", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "l", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "l", lazy.spawncmd(), desc=""),
    # Key([mod], "m", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "m", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "m", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "m", lazy.spawncmd(), desc=""),
    # Key([mod], "n", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "n", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "n", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "n", lazy.spawncmd(), desc=""),
    # Key([mod], "o", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "o", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "o", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "o", lazy.spawncmd(), desc=""),
    # Key([mod], "p", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "p", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "p", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "p", lazy.spawncmd(), desc=""),
    # Key([mod], "q", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "q", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "q", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "q", lazy.spawncmd(), desc=""),
    # Key([mod], "r", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "r", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "r", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "r", lazy.spawncmd(), desc=""),
    # Key([mod], "s", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "s", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "s", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "s", lazy.spawncmd(), desc=""),
    # Key([mod], "t", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "t", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "t", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "t", lazy.spawncmd(), desc=""),
    # Key([mod], "u", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "u", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "u", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "u", lazy.spawncmd(), desc=""),
    # Key([mod], "v", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "v", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "v", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "v", lazy.spawncmd(), desc=""),
    # taken Key([mod], "w", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "w", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "w", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "w", lazy.spawncmd(), desc=""),
    # Key([mod], "x", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "x", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "x", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "x", lazy.spawncmd(), desc=""),
    # Key([mod], "y", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "y", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "y", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "y", lazy.spawncmd(), desc=""),
    # Key([mod], "z", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "z", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "z", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "z", lazy.spawncmd(), desc=""),
    # Key([mod], "F1", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "F1", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "F1", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "F1", lazy.spawncmd(), desc=""),
    # Key([mod], "F2", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "F2", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "F2", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "F2", lazy.spawncmd(), desc=""),
    # Key([mod], "F3", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "F3", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "F3", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "F3", lazy.spawncmd(), desc=""),
    # Key([mod], "F4", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "F4", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "F4", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "F4", lazy.spawncmd(), desc=""),
    # Key([mod], "F5", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "F5", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "F5", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "F5", lazy.spawncmd(), desc=""),
    # Key([mod], "F6", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "F6", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "F6", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "F6", lazy.spawncmd(), desc=""),
    # Key([mod], "F7", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "F7", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "F7", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "F7", lazy.spawncmd(), desc=""),
    # Key([mod], "F8", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "F8", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "F8", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "F8", lazy.spawncmd(), desc=""),
    # Key([mod], "F9", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "F9", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "F9", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "F9", lazy.spawncmd(), desc=""),
    # Key([mod], "F10", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "F10", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "F10", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "F10", lazy.spawncmd(), desc=""),
    # Key([mod], "F11", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "F11", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "F11", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "F11", lazy.spawncmd(), desc=""),
    # Key([mod], "F12", lazy.spawncmd(), desc=""),
    # Key([mod, "shift"], "F12", lazy.spawncmd(), desc=""),
    # Key([mod, "control"], "F12", lazy.spawncmd(), desc=""),
    # Key([mod, "shift, control"], "F12", lazy.spawncmd(), desc=""),

    Key([mod], "period", lazy.spawn("qutebrowser"), desc="Qutebrowser Web Browser"),

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
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
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
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox("default config", name="default"),
                widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.QuickExit(),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
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
