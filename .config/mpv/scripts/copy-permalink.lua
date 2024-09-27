-- Original Author: Ole Jørgen Brønner (olejorgenb@yahoo.no)
-- Requirement: xclip or wl-copy
-- Installation:
-- 'mkdir -p ~/.config/mpv/scripts && cp -i copy-permalink.lua ~/.config/mpv/scripts'

-- Function to detect if we're on Wayland
function is_wayland()
	return os.getenv("WAYLAND_DISPLAY") ~= nil
end

-- Function to copy the permalink
function copyPermalink()
	local pos = mp.get_property_number("time-pos")
	local uri = mp.get_property("path")
	-- %q might not be fully robust
	local bookmark = string.format("mpv --start=%s %q", pos, uri)
	local clipboard_cmd = is_wayland() and "wl-copy" or "xclip -silent -in -selection clipboard"

	local pipe = io.popen(clipboard_cmd, "w")
	pipe:write(bookmark)
	pipe:close()
	mp.osd_message("MPV link copied to clipboard")
end

-- Function to share the permalink
function sharePermalink()
	local pos = mp.get_property_number("time-pos")
	local uri = mp.get_property("path")
	-- %q might not be fully robust
	local bookmark = string.format("%s&t=%i", uri, pos)
	local clipboard_cmd = is_wayland() and "wl-copy" or "xclip -silent -in -selection clipboard"

	local pipe = io.popen(clipboard_cmd, "w")
	pipe:write(bookmark)
	pipe:close()
	mp.osd_message("Link copied to clipboard")
end

-- Bind the copy and share functions to keys
mp.add_key_binding("shift+y", "copy-permalink", copyPermalink)
mp.add_key_binding("y", "share-permalink", sharePermalink)

-- -- Original Author: Ole Jørgen Brønner (olejorgenb@yahoo.no)
-- -- Requirement: xclip
-- -- Installation:
-- -- 'mkdir -p ~/.config/mpv/scripts && cp -i copy-permalink.lua ~/.config/mpv/scripts'
--
-- function copyPermalink()
--   local pos = mp.get_property_number("time-pos")
--   local uri = mp.get_property("path")
--   -- %q might not be fully robust
--   local bookmark = string.format("mpv --start=%s %q", pos, uri)
--   local pipe = io.popen("xclip -silent -in -selection clipboard", "w")
--   pipe:write(bookmark)
--   pipe:close()
--   mp.osd_message("MPV link copied to clipboard")
-- end
--
-- function sharePermalink()
--   local pos = mp.get_property_number("time-pos")
--   local uri = mp.get_property("path")
--   -- %q might not be fully robust
--   -- local bookmark = string.format("mpv --start=%s %q", pos, uri)
--   local bookmark = string.format("%s&t=%i", uri, pos)
--   local pipe = io.popen("xclip -silent -in -selection clipboard", "w")
--   pipe:write(bookmark)
--   pipe:close()
--   mp.osd_message("Link copied to clipboard")
-- end
--
-- -- mp.register_script_message("copy-permalink", copyPermalink)
-- mp.add_key_binding("shift+y", "copy-permalink", copyPermalink)
-- mp.add_key_binding("y", "share-permalink", sharePermalink)
