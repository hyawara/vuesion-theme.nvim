-- 配置中心：默认值定义 + 用户配置合并。
--   setup()  写入全局 state（keep 语义：用户值优先，缺失项补默认）。
--   extend() 每次加载时生成最终配置（force 语义：入参 > state > 默认）。
local M = {}

M.defaults = {
  style = "dark",
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = {},
    variables = {},
    sidebars = "dark",
    floats = "dark",
    underline = false,
  },
  dim_inactive = false,
  lualine_bold = false,
  on_colors = nil,
  on_highlights = nil,
  cache = true,
  plugins = {
    all = false,
    auto = true,
    snacks = false,
    blink = false,
    blink_kind_hl = "theme",
    gitsigns = false,
    bufferline = false,
    which_key = false,
    flash = false,
    mini = false,
    indent_blankline = false,
    noice = false,
    trouble = false,
    dashboard = false,
  },
}

local state = {
  options = {},
}

function M.setup(opts)
  state.options = vim.tbl_deep_extend("keep", opts or {}, M.defaults)
end

function M.options()
  return state.options
end

function M.extend(opts)
  return vim.tbl_deep_extend("force", {}, M.defaults, state.options, opts or {})
end

return M
