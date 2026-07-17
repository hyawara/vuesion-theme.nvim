local M = {}

M.url = "https://github.com/akinsho/bufferline.nvim"

function M.get(c, opts)
  return {
    BufferLineFill = { bg = c.bg },
    BufferLineBackground = { fg = c.fg_dim, bg = c.bg },
    BufferLineBufferSelected = { fg = c.fg, bg = c.bg_dark },
    BufferLineBufferVisible = { fg = c.fg_dim, bg = c.bg },
    BufferLineCloseButton = { fg = c.fg_dark },
    BufferLineCloseButtonSelected = { fg = c.red },
    BufferLineCloseButtonVisible = { fg = c.fg_dark },
    BufferLineTab = { fg = c.fg_dim, bg = c.bg },
    BufferLineTabSelected = { fg = c.fg, bg = c.bg_dark },
    BufferLineTabSeparator = { fg = c.border },
    BufferLineTabSeparatorSelected = { fg = c.border },
    BufferLineIndicatorSelected = { fg = c.blue },
    BufferLinePick = { fg = c.blue },
    BufferLinePickVisible = { fg = c.blue },
    BufferLinePickSelected = { fg = c.blue },
    BufferLineModified = { fg = c.blue },
    BufferLineModifiedSelected = { fg = c.green },
    BufferLineModifiedVisible = { fg = c.blue },
    BufferLineSeparator = { fg = c.border },
    BufferLineSeparatorSelected = { fg = c.border },
    BufferLineSeparatorVisible = { fg = c.border },
    BufferLineGroupSelected = { fg = c.blue },
    BufferLineGroupClose = { fg = c.red },
    BufferLineDuplicate = { fg = c.fg_dark },
    BufferLineDuplicateSelected = { fg = c.fg },
    BufferLineDuplicateVisible = { fg = c.fg_dark },
    BufferLineNumbers = { fg = c.fg_dark },
    BufferLineNumbersSelected = { fg = c.blue },
    BufferLineNumbersVisible = { fg = c.fg_dark },
    BufferLineOffsetSeparator = { fg = c.border },
    BufferLineHint = { fg = c.hint },
    BufferLineHintSelected = { fg = c.hint },
    BufferLineHintVisible = { fg = c.hint },
    BufferLineError = { fg = c.error },
    BufferLineErrorSelected = { fg = c.error },
    BufferLineErrorVisible = { fg = c.error },
    BufferLineWarning = { fg = c.warning },
    BufferLineWarningSelected = { fg = c.warning },
    BufferLineWarningVisible = { fg = c.warning },
    BufferLineInfo = { fg = c.info },
    BufferLineInfoSelected = { fg = c.info },
    BufferLineInfoVisible = { fg = c.info },
  }
end

return M
