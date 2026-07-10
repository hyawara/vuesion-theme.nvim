-- 高亮组分发器：决定加载哪些 group 文件并合并结果。
--   核心组（base/syntax/treesitter/semantic_tokens）永远加载；
--   插件组支持三种开启方式：all 全开 / auto 自动检测已装插件 / 手动逐个开。
local M = {
  plugins = {
    ["snacks.nvim"] = "snacks",
    ["blink.cmp"] = "blink",
    ["gitsigns.nvim"] = "git",
    ["nvim-lint"] = "lint",
    ["lualine.nvim"] = "lualine",
  },
}

local function plugin_available(name)
  -- lazy.nvim 存在时优先读它的插件表；没有 lazy 时不应让主题加载失败。
  local ok, lazy = pcall(require, "lazy.core.config")
  if ok and lazy.plugins and lazy.plugins[name] then
    return true
  end

  return vim.fn.exists(":Lazy") == 0 and pcall(require, name)
end

local function load(module)
  local ok, mod = pcall(require, "vuesion-theme.groups." .. module)
  if ok then
    return mod
  end
  return nil
end

local function enable_all(groups)
  for _, module in pairs(M.plugins) do
    groups[module] = true
  end
end

local function enable_auto(groups)
  for name, module in pairs(M.plugins) do
    if plugin_available(name) then
      groups[module] = true
    end
  end
end

local function enable_manual(groups, plugin_opts)
  for key, enabled in pairs(plugin_opts) do
    if type(enabled) == "boolean" and enabled then
      for _, module in pairs(M.plugins) do
        if module == key then
          groups[key] = true
        end
      end
    end
  end
end

function M.setup(c, opts)
  local plugin_opts = opts.plugins or {}
  local groups = {
    base = true,
    syntax = true,
    treesitter = true,
    semantic_tokens = true,
  }

  if plugin_opts.all then
    enable_all(groups)
  end

  if plugin_opts.auto then
    enable_auto(groups)
  end

  enable_manual(groups, plugin_opts)

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
