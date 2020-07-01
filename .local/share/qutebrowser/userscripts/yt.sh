#!/bin/bash
mpv --ytdl-format=22 "$(xclip -o)" || mpv "$(xclip -o)"
