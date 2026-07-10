local config = require("vuesion-theme.config")
local theme = require("vuesion-theme.theme")

-- 插件公开入口。
--   setup(opts)  只登记用户配置，不立即生效（供懒加载场景提前配置）。
--   load(opts)   真正清空旧高亮、设置 colors_name 并应用整套主题。
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
