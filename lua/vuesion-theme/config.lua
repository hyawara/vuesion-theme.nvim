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
    all = true,
    auto = true,
    snacks = true,
    blink = true,
    gitsigns = true,
    bufferline = true,
    which_key = true,
    flash = true,
    mini = true,
    indent_blankline = true,
    noice = true,
    trouble = true,
    dashboard = true,
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
