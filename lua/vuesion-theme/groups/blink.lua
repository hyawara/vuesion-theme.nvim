local M = {}

M.url = "https://github.com/Saghen/blink.cmp"

function M.get(c, opts)
  return {
    BlinkCmp = { fg = c.fg, bg = c.bg_popup },
    BlinkCmpMenu = { fg = c.fg, bg = c.bg_popup },
    BlinkCmpMenuBorder = { fg = c.border_highlight, bg = c.bg_popup },
    BlinkCmpMenuSelection = { fg = c.fg, bg = c.blue_dark },
    BlinkCmpScrollBarThumb = { bg = c.fg_dark },
    BlinkCmpScrollBarGutter = { bg = c.bg_highlight },
    BlinkCmpDoc = { fg = c.fg, bg = c.bg_float },
    BlinkCmpDocBorder = { fg = c.border_highlight, bg = c.bg_float },
    BlinkCmpDocSeparator = { fg = c.border, bg = c.bg_highlight },
    BlinkCmpSignatureHelp = { fg = c.fg, bg = c.bg_float },
    BlinkCmpSignatureHelpBorder = { fg = c.border_highlight, bg = c.bg_float },
    BlinkCmpLabel = { fg = c.fg },
    BlinkCmpLabelDeprecated = { fg = c.fg_dark },
    BlinkCmpLabelMatch = { fg = c.orange },
    BlinkCmpLabelDetail = { fg = c.fg_dark },
    BlinkCmpLabelDescription = { fg = c.fg_dim },
    BlinkCmpKind = { fg = c.blue },
    BlinkCmpSource = { fg = c.fg_dark },
    BlinkCmpGhostText = { fg = c.fg_dark },

    -- Kind icons
    BlinkCmpKindText = { fg = c.green },
    BlinkCmpKindMethod = { fg = c.blue },
    BlinkCmpKindFunction = { fg = c.pink },
    BlinkCmpKindConstructor = { fg = c.yellow },
    BlinkCmpKindField = { fg = c.blue },
    BlinkCmpKindVariable = { fg = c.fg },
    BlinkCmpKindClass = { fg = c.yellow },
    BlinkCmpKindInterface = { fg = c.yellow },
    BlinkCmpKindModule = { fg = c.blue },
    BlinkCmpKindProperty = { fg = c.blue },
    BlinkCmpKindUnit = { fg = c.green },
    BlinkCmpKindValue = { fg = c.green },
    BlinkCmpKindEnum = { fg = c.yellow },
    BlinkCmpKindKeyword = { fg = c.pink },
    BlinkCmpKindSnippet = { fg = c.orange },
    BlinkCmpKindColor = { fg = c.fg },
    BlinkCmpKindFile = { fg = c.blue },
    BlinkCmpKindReference = { fg = c.blue },
    BlinkCmpKindFolder = { fg = c.blue },
    BlinkCmpKindEnumMember = { fg = c.cyan },
    BlinkCmpKindConstant = { fg = c.orange },
    BlinkCmpKindStruct = { fg = c.yellow },
    BlinkCmpKindEvent = { fg = c.yellow },
    BlinkCmpKindOperator = { fg = c.keyword },
    BlinkCmpKindTypeParameter = { fg = c.parameter },
    BlinkCmpKindArray = { fg = c.orange },
    BlinkCmpKindObject = { fg = c.yellow },
    BlinkCmpKindComponent = { fg = c.yellow },
    BlinkCmpKindFragment = { fg = c.pink },
    BlinkCmpKindNull = { fg = c.fg_dark },
    BlinkCmpKindNumber = { fg = c.orange },
    BlinkCmpKindBoolean = { fg = c.number },
  }
end

return M
