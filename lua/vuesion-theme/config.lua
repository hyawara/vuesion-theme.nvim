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
