local config = require("vuesion-theme.config")
local colors = require("vuesion-theme.colors")
local groups = require("vuesion-theme.groups")
local util = require("vuesion-theme.util")

-- 装配线：把调色板、高亮组、工具函数串起来，最终逐个调用 nvim_set_hl 生效。
-- 流程：加载调色板 → （可选）设置终端 16 色 → 组装高亮 → resolve 归一 → on_highlights 回调 → 应用。
local M = {}

function M.setup(opts)
  local c = colors.setup(opts)

  if opts.terminal_colors then
    M.set_terminal_colors(c)
  end

  local highlights = groups.setup(c, opts)

  util.resolve(highlights)

  if not opts.styles.underline then
    for _, hl in pairs(highlights) do
      hl.underline = nil
      hl.undercurl = nil
      hl.underdotted = nil
      hl.underdashed = nil
    end
  end

  if opts.on_highlights then
    opts.on_highlights(highlights, c)
  end

  for group, hl in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, hl)
  end
end

function M.set_terminal_colors(c)
  vim.g.terminal_color_0 = c.black
  vim.g.terminal_color_1 = c.red
  vim.g.terminal_color_2 = c.green
  vim.g.terminal_color_3 = c.yellow
  vim.g.terminal_color_4 = c.blue
  vim.g.terminal_color_5 = c.magenta
  vim.g.terminal_color_6 = c.cyan
  vim.g.terminal_color_7 = c.white
  vim.g.terminal_color_8 = c.bright_black
  vim.g.terminal_color_9 = c.bright_red
  vim.g.terminal_color_10 = c.bright_green
  vim.g.terminal_color_11 = c.bright_yellow
  vim.g.terminal_color_12 = c.bright_blue
  vim.g.terminal_color_13 = c.bright_magenta
  vim.g.terminal_color_14 = c.bright_cyan
  vim.g.terminal_color_15 = c.bright_white
end

return M
