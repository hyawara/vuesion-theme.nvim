-- 纯数据文件：所有色值的唯一来源。
-- 语法色直接对应 IntelliJ vuesion_theme.xml 的 DEFAULT_* token；
-- UI 色对应 vuesion_theme.theme.json。改色只需动这里，不碰逻辑代码。
local M = {}

M.syntax = {
  keyword = "#ff92bb",
  string = "#40bf77",
  number = "#f9846c",
  function_decl = "#90e0a4",
  ["function"] = "#ffffff",
  class = "#f3c811",
  constant = "#3d8beb",
  parameter = "#8dc3f9",
  operator = "#40bf77",
  tag = "#f43b6c",
  attribute = "#40bf77",
  comment = "#6f7a86",
  doc_comment = "#6f7a86",
  predefined = "#3d8beb",
  entity = "#f9846c",
  punctuation = "#ffffff",
  semicolon = "#40bf77",
}

M.ui = {
  bg = "#202831",
  bg_dark = "#0c1014",
  bg_float = "#0c1014",
  bg_highlight = "#303a45",
  bg_popup = "#0c1014",
  -- 补全菜单“匹配字符”高亮色。IntelliJ 原值为深绿 #0d9660，
  -- 但深绿在深色弹窗上对比度低、且与语法绿系（字符串/操作符）混淆，
  -- 故改用橙色，与 snacks picker 的 SnacksPickerMatch 统一“匹配”语义。
  completion_match = "#f9846c",
  bg_sidebar = "#202831",
  -- 搜索高亮走“冷底 + 暖焦点”护眼配色，刻意避开代码里遍地的绿色（字符串/函数声明/操作符），
  -- 也避开旧版刺眼的芥末黄(#7a6300)与荧光亮黄(#f3c811)。中低饱和、中等明度，久看不累：
  --   bg_search         柔青蓝 → 所有匹配（Search），冷静打底，与深蓝灰背景同冷调但更亮
  --   bg_search_current 柔琥珀 → 当前匹配（IncSearch/CurSearch），暖色聚焦，冷暖对比一眼锁定
  bg_search = "#2d5a66",
  bg_search_current = "#e0a458",
  bg_visual = "#303a45",
  bg_selection = "#9ca2aa",
  bg_caret = "#182029",

  fg = "#ececee",
  fg_dim = "#c9cbcf",
  fg_dark = "#6f7a86",
  fg_gutter = "#55616c",
  fg_sidebar = "#6f7a86",

  border = "#303a45",
  border_highlight = "#434e5b",
  border_focus = "#434e5b",

  caret = "#ececee",
  line_number = "#55616c",
  line_number_active = "#c9cbcf",

  indent_guide = "#303a45",
  indent_guide_active = "#6f7a86",

  whitespace = "#6f7a86",

  selection_fg = "#202831",

  folded = "#d8ecfe",
}

M.accents = {
  blue = "#3d8beb",
  blue_dark = "#216fe0",
  blue_light = "#8dc3f9",
  blue_deep = "#063cbe",
  red = "#f43b6c",
  red_dark = "#cd0940",
  red_deep = "#70011f",
  red_error = "#c82600",
  green = "#40bf77",
  green_light = "#90e0a4",
  green_deep = "#045a3f",
  orange = "#f9846c",
  yellow = "#f3c811",
  yellow_dark = "#d5aa00",
  pink = "#ff92bb",
  cyan = "#33cccc",
  magenta = "#b30636",
  purple = "#b30636",
}

M.diagnostic = {
  error = "#e84606",
  warning = "#d5aa00",
  info = "#216fe0",
  hint = "#6f7a86",
  error_stripe = "#e84606",
  warning_stripe = "#d5aa00",
  info_stripe = "#216fe0",
  hint_stripe = "#6f7a86",
}

M.diff = {
  add = "#045a3f",
  delete = "#70011f",
  change = "#303a45",
  text = "#8dc3f9",
}

M.terminal = {
  black = "#202831",
  red = "#de3700",
  green = "#40bf77",
  yellow = "#f3c811",
  blue = "#3d8beb",
  magenta = "#ff92bb",
  cyan = "#33cccc",
  white = "#c9cbcf",
  bright_black = "#434e5b",
  bright_red = "#e84606",
  bright_green = "#40bf77",
  bright_yellow = "#f3c811",
  bright_blue = "#8dc3f9",
  bright_magenta = "#ff92bb",
  bright_cyan = "#33cccc",
  bright_white = "#ececee",
}

return M
