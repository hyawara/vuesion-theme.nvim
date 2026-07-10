-- lualine 状态栏主题。
--   a 段（模式指示）按 Vim 模式变色；b/c/x/y/z 段统一走 bg_highlight / bg 两级背景。
--   末尾直接 M.get("dark")，让 require("lualine.themes.vuesion-theme") 可直接拿到表。
local M = {}

function M.get(style)
  local ok, colors = pcall(require, "vuesion-theme.colors")
  if not ok then
    return {}
  end
  local c = colors.load({ style = style or "dark" })
  local config = require("vuesion-theme.config")
  local opts = config.options()

  local hl = {}

  local modes = {
    normal   = { a = { bg = c.blue,         fg = c.bg } },
    insert   = { a = { bg = c.green,        fg = c.bg } },
    visual   = { a = { bg = c.pink,         fg = c.bg } },
    replace  = { a = { bg = c.red,          fg = c.bg } },
    command  = { a = { bg = c.yellow,       fg = c.bg } },
    terminal = { a = { bg = c.blue_light,   fg = c.bg } },
  }

  for mode, mode_hl in pairs(modes) do
    hl[mode] = {
      a = mode_hl.a,
      b = { bg = c.bg_highlight, fg = c.fg },
      c = { bg = c.bg,           fg = c.fg },
      x = { bg = c.bg_highlight, fg = c.fg },
      y = { bg = c.bg_highlight, fg = c.fg },
      z = { bg = c.bg_highlight, fg = c.fg },
    }
  end

  hl.inactive = {
    a = { bg = c.bg_highlight, fg = c.fg_dark },
    b = { bg = c.bg_highlight, fg = c.fg_dark },
    c = { bg = c.bg,           fg = c.fg_dark },
  }

  if opts.lualine_bold then
    for mode, mode_hl in pairs(hl) do
      if mode_hl.a then
        mode_hl.a.gui = "bold"
      end
    end
  end

  return hl
end

return M.get("dark")
