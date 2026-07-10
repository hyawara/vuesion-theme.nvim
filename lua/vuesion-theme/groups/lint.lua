local M = {}

M.url = "https://github.com/mfussenegger/nvim-lint"

function M.get(c, opts)
  return {
    LintWarning = { fg = c.warning },
    LintError = { fg = c.error },
    LintInfo = { fg = c.info },
  }
end

return M
