-- Original Author: Ole Jørgen Brønner (olejorgenb@yahoo.no)
-- Requirement: xclip
-- Installation: 
-- 'mkdir -p ~/.config/mpv/scripts && cp -i copy-permalink.lua ~/.config/mpv/scripts'

function copyPermalink()
  local pos = mp.get_property_number("time-pos")
  local uri = mp.get_property("path")
  -- %q might not be fully robust
  local bookmark = string.format("mpv --start=%s %q", pos, uri)
  local pipe = io.popen("xclip -silent -in -selection clipboard", "w")
  pipe:write(bookmark)
  pipe:close()
  mp.osd_message("MPV link copied to clipboard")
end

function sharePermalink()
  local pos = mp.get_property_number("time-pos")
  local uri = mp.get_property("path")
  -- %q might not be fully robust
  -- local bookmark = string.format("mpv --start=%s %q", pos, uri)
  local bookmark = string.format("%s&t=%i", uri, pos)
  local pipe = io.popen("xclip -silent -in -selection clipboard", "w")
  pipe:write(bookmark)
  pipe:close()
  mp.osd_message("Link copied to clipboard")
end

-- mp.register_script_message("copy-permalink", copyPermalink)
mp.add_key_binding("shift+y", "copy-permalink", copyPermalink)
mp.add_key_binding("y", "share-permalink", sharePermalink)
