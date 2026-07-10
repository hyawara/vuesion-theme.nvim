local M = {}

M.url = "https://github.com/lewis6991/gitsigns.nvim"

function M.get(c, opts)
  return {
    GitSignsAdd = { fg = c.green },
    GitSignsChange = { fg = c.blue },
    GitSignsDelete = { fg = c.red },
    GitSignsAddLn = { bg = c.diff.add },
    GitSignsChangeLn = { bg = c.diff.text },
    GitSignsDeleteLn = { bg = c.diff.delete },
    GitSignsAddNr = { fg = c.green },
    GitSignsChangeNr = { fg = c.blue },
    GitSignsDeleteNr = { fg = c.red },
    GitSignsAddInline = { bg = c.diff.add },
    GitSignsDeleteInline = { bg = c.diff.delete },
    GitSignsChangeInline = { bg = c.diff.text },
    GitSignsUntracked = { fg = c.green },

    -- GitSigns preview
    GitSignsCurrentLineBlame = { fg = c.fg_dark },
  }
end

return M
