local config = require("vuesion-theme.config")

local M = {}

local cache = {}

function M.setup(opts)
  local styles = {
    dark = "vuesion-theme.colors.dark",
  }

  local palette = require(styles[opts.style])

  local colors = {}

  colors.syntax = palette.syntax
  colors.ui = palette.ui
  colors.accents = palette.accents
  colors.diagnostic = palette.diagnostic
  colors.diff = palette.diff
  colors.terminal = palette.terminal

  for k, v in pairs(palette.syntax) do colors[k] = v end
  for k, v in pairs(palette.ui) do colors[k] = v end
  for k, v in pairs(palette.accents) do colors[k] = v end
  for k, v in pairs(palette.diagnostic) do colors[k] = v end
  for k, v in pairs(palette.diff) do colors[k] = v end
  for k, v in pairs(palette.terminal) do colors[k] = v end

  colors.none = "NONE"

  colors.bg_dim = colors.bg_dark
  colors.fg_dim = colors.fg_dark

  if opts.transparent then
    colors.bg = colors.none
    colors.bg_dark = colors.none
    colors.bg_float = colors.none
    colors.bg_popup = colors.none
  end

  colors.sidebar_bg = colors.bg_sidebar
  colors.float_bg = colors.bg_float

  if opts.dim_inactive then
    colors.bg_dim = colors.bg_highlight
  end

  if opts.on_colors then
    opts.on_colors(colors)
  end

  cache[opts.style] = colors
  return colors
end

function M.load(opts)
  if cache[opts.style] then
    return cache[opts.style]
  end
  return M.setup(opts)
end

return M
