-- 高亮组分发器：决定加载哪些 group 文件并合并结果。
--   核心组（base/syntax/treesitter/semantic_tokens）永远加载；
--   插件组通过 plugins 配置项逐个开启，默认全部关闭。
local M = {
  plugins = {
    ["snacks.nvim"] = "snacks",
    ["blink.cmp"] = "blink",
    ["gitsigns.nvim"] = "git",
    ["nvim-lint"] = "lint",
    ["lualine.nvim"] = "lualine",
    ["bufferline.nvim"] = "bufferline",
  },
}

local function load(module)
  local ok, mod = pcall(require, "vuesion-theme.groups." .. module)
  if ok then
    return mod
  end
  return nil
end

function M.setup(c, opts)
  local plugin_opts = opts.plugins or {}
  local groups = {
    base = true,
    syntax = true,
    treesitter = true,
    semantic_tokens = true,
  }

  for _, module in pairs(M.plugins) do
    if plugin_opts[module] then
      groups[module] = true
    end
  end

  local results = {}
  for group in pairs(groups) do
    local mod = load(group)
    if mod and mod.get then
      -- 某些插件分组会读取插件内部模块；插件未安装或 API 变动时跳过，不拖垮 colorscheme。
      local ok, hl = pcall(mod.get, c, opts)
      if ok and type(hl) == "table" then
        for k, v in pairs(hl) do
          results[k] = v
        end
      end
    end
  end

  return results
end

return M
