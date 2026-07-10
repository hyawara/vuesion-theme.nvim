local M = {}

M.url = "https://github.com/mfussenegger/nvim-lint"

-- nvim-lint 适配：诊断信息的三档颜色（警告/错误/提示）。
function M.get(c, opts)
  return {
    LintWarning = { fg = c.warning },
    LintError = { fg = c.error },
    LintInfo = { fg = c.info },
  }
end

return M
