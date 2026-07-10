local M = {}

M.url = "https://github.com/folke/snacks.nvim"

function M.get(c, opts)
  local snacks = require("snacks.picker.config")
  local stylus = snacks.styles

  local function get_hl(name)
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
    if ok and hl then
      return hl
    end
    return {}
  end

  return {
    SnacksPicker = { fg = c.fg, bg = c.bg_float },
    SnacksPickerBorder = { fg = c.border_highlight, bg = c.bg_float },
    SnacksPickerTitle = { fg = c.blue, bg = c.bg_float },
    SnacksPickerList = { fg = c.fg, bg = c.bg_float },
    SnacksPickerListCursorLine = { bg = c.bg_highlight },
    SnacksPickerListSelected = { fg = c.fg, bg = c.blue_dark },
    SnacksPickerInput = { fg = c.fg, bg = c.bg_dark },
    SnacksPickerInputBorder = { fg = c.border_highlight, bg = c.bg_dark },
    SnacksPickerInputTitle = { fg = c.blue, bg = c.bg_dark },
    SnacksPickerPreview = { fg = c.fg, bg = c.bg },
    SnacksPickerPreviewBorder = { fg = c.border, bg = c.bg },
    SnacksPickerPreviewTitle = { fg = c.fg_dark, bg = c.bg },
    SnacksPickerPrompt = { fg = c.blue },
    SnacksPickerIcon = { fg = c.blue },
    SnacksPickerIconFile = { fg = c.fg_dim },
    SnacksPickerDirectory = { fg = c.blue },
    SnacksPickerFile = { fg = c.fg },
    SnacksPickerMatch = { fg = c.orange },
    SnacksPickerHeader = { fg = c.fg_dark },
    SnacksPickerFooter = { fg = c.fg_dark },
    SnacksPickerToggle = { fg = c.blue },
    SnacksPickerKeymap = { fg = c.pink },
    SnacksPickerGitStatus = { fg = c.green },
    SnacksPickerGitBranch = { fg = c.blue },
    SnacksPickerProgress = { fg = c.blue },
    SnacksPickerTotal = { fg = c.fg_dim },
    SnacksPickerHidden = { fg = c.fg_dark },
    SnacksPickerCell = { fg = c.fg, bg = c.bg_float },
    SnacksPickerCellText = { fg = c.fg },
    SnacksPickerCellIcon = { fg = c.fg_dim },
    SnacksPickerCellLabel = { fg = c.fg_dim },
    SnacksPickerScrollbar = { fg = c.fg_dark, bg = c.bg_highlight },
    SnacksPickerScrollbarThumb = { bg = c.fg_dark },
  }
end

return M
