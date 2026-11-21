-- You can configure your bookmarks by lua language
local bookmarks = {}

local path_sep = package.config:sub(1, 1)
local home_path = ya.target_family() == "windows" and os.getenv("USERPROFILE") or os.getenv("HOME")
if ya.target_family() == "windows" then
  table.insert(bookmarks, {
    tag = "Scoop Local",
    path = (os.getenv("SCOOP") or home_path .. "\\scoop") .. "\\",
    key = "p"
  })
  table.insert(bookmarks, {
    tag = "Scoop Global",
    path = (os.getenv("SCOOP_GLOBAL") or "C:\\ProgramData\\scoop") .. "\\",
    key = "P"
  })
end
table.insert(bookmarks, {
  tag = "Desktop",
  path = home_path .. path_sep .. "Desktop" .. path_sep,
  key = "d"
})

require("yamb"):setup {
  -- Optional, the path ending with path seperator represents folder.
  bookmarks = bookmarks,
  -- Optional, recieve notification everytime you jump.
  jump_notify = true,
  -- Optional, the cli of fzf.
  cli = "fzf",
  -- Optional, a string used for randomly generating keys, where the preceding characters have higher priority.
  keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
  -- Optional, the path of bookmarks
  path = (ya.target_family() == "windows" and os.getenv("APPDATA") .. "\\yazi\\config\\bookmark") or
        (os.getenv("HOME") .. "/.config/yazi/bookmark"),
}

-- 状态栏左下角显示光标所在文件的修改时间（mtime）。
-- order 2500 让它插在 length(2000) 与 name(3000) 之间；
-- 想挪到右下角改成 Status.RIGHT, 1500 之类的 order。
-- 注：h.cha.mtime 是 epoch 秒（number），所以用 os.date 格式化。
Status:children_add(function(self)
  local h = self._current.hovered
  if not h or not h.cha or not h.cha.mtime then
    return ""
  end

  local t = math.floor(h.cha.mtime)
  local fmt = os.date("%Y", t) == os.date("%Y") and "%m-%d %H:%M" or "%Y-%m-%d"

  return ui.Line { ui.Span(" " .. os.date(fmt, t) .. " "):fg("blue") }
end, 2500, Status.LEFT)
