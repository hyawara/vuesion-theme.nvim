local config = require("vuesion-theme.config")
local theme = require("vuesion-theme.theme")

local M = {}

function M.setup(opts)
  config.setup(opts)
end

function M.load(opts)
  local options = config.extend(opts)

  vim.api.nvim_command("hi clear")
  if vim.g.colors_name then
    vim.api.nvim_command("hi clear")
  end
  vim.g.colors_name = "vuesion-theme"
  vim.o.background = "dark"

  theme.setup(options)
end

return M
