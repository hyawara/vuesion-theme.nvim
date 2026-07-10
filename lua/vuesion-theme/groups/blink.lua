local M = {}

M.url = "https://github.com/Saghen/blink.cmp"

local kind_groups = {
  "Text",
  "Method",
  "Function",
  "Constructor",
  "Field",
  "Variable",
  "Class",
  "Interface",
  "Module",
  "Property",
  "Unit",
  "Value",
  "Enum",
  "Keyword",
  "Snippet",
  "Color",
  "File",
  "Reference",
  "Folder",
  "EnumMember",
  "Constant",
  "Struct",
  "Event",
  "Operator",
  "TypeParameter",
  "Array",
  "Object",
  "Component",
  "Fragment",
  "Null",
  "Number",
  "Boolean",
}

-- blink.cmp 自带的是一套默认高亮链（通常回落到 Pmenu/PmenuKind）。
-- 本主题默认给 kind 图标上“语义色”；若想完全交还给 blink 默认链，设：
--   require("vuesion-theme").setup({ plugins = { blink_kind_hl = "blink" } })
local function apply_blink_kind_links(groups)
  for _, kind in ipairs(kind_groups) do
    groups["BlinkCmpKind" .. kind] = { link = "PmenuKind" }
  end
end

local function apply_theme_kind_colors(groups, c)
  local colors = {
    Text = c.string,
    Method = c["function"],
    Function = c.function_decl,
    Constructor = c.class,
    Field = c["function"],
    Variable = c.fg,
    Class = c.class,
    Interface = c.class,
    Module = c.blue,
    Property = c["function"],
    Unit = c.string,
    Value = c.string,
    Enum = c.class,
    Keyword = c.keyword,
    Snippet = c.orange,
    Color = c.fg,
    File = c.blue,
    Reference = c.blue,
    Folder = c.blue,
    EnumMember = c.constant,
    Constant = c.constant,
    Struct = c.class,
    Event = c.class,
    Operator = c.operator,
    TypeParameter = c.parameter,
    Array = c.entity,
    Object = c.class,
    Component = c.class,
    Fragment = c.tag,
    Null = c.fg_dark,
    Number = c.number,
    Boolean = c.number,
  }

  for _, kind in ipairs(kind_groups) do
    groups["BlinkCmpKind" .. kind] = { fg = colors[kind] or c.blue }
  end
end

function M.get(c, opts)
  local groups = {
    BlinkCmp = { fg = c.fg, bg = c.bg_popup },
    BlinkCmpMenu = { fg = c.fg, bg = c.bg_popup },
    BlinkCmpMenuBorder = { fg = c.border_highlight, bg = c.bg_popup },
    BlinkCmpMenuSelection = { fg = c.selection_fg, bg = c.bg_selection },
    BlinkCmpScrollBarThumb = { bg = c.fg_dark },
    BlinkCmpScrollBarGutter = { bg = c.bg_highlight },
    BlinkCmpDoc = { fg = c.fg, bg = c.bg_float },
    BlinkCmpDocBorder = { fg = c.border_highlight, bg = c.bg_float },
    BlinkCmpDocSeparator = { fg = c.border, bg = c.bg_highlight },
    BlinkCmpSignatureHelp = { fg = c.fg, bg = c.bg_float },
    BlinkCmpSignatureHelpBorder = { fg = c.border_highlight, bg = c.bg_float },
    BlinkCmpLabel = { fg = c.fg },
    BlinkCmpLabelDeprecated = { fg = c.fg_dark, strikethrough = true },
    BlinkCmpLabelMatch = { fg = c.completion_match, bold = true },
    BlinkCmpLabelDetail = { fg = c.fg_dark },
    BlinkCmpLabelDescription = { fg = c.fg_dim },
    BlinkCmpKind = { fg = c.blue },
    BlinkCmpSource = { fg = c.fg_dark },
    BlinkCmpGhostText = { fg = c.fg_dark, italic = true },
  }

  if opts.plugins and opts.plugins.blink_kind_hl == "blink" then
    apply_blink_kind_links(groups)
  else
    apply_theme_kind_colors(groups, c)
  end

  return groups
end

return M
