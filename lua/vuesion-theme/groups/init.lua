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
  local lazy = require("lazy.core.config")
  if lazy.plugins and lazy.plugins[name] then
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

function M.setup(c, opts)
  local groups = {
    base = true,
    treesitter = true,
    semantic_tokens = true,
  }

  if opts.plugins.all then
    for _, name in ipairs(vim.tbl_keys(M.plugins)) do
      groups[M.plugins[name]] = true
    end
  elseif opts.plugins.auto then
    for name, module in pairs(M.plugins) do
      if plugin_available(name) then
        groups[module] = true
      end
    end
  end

  for name, enabled in pairs(opts.plugins) do
    if type(enabled) == "boolean" and enabled then
      for pname, module in pairs(M.plugins) do
        if module == name then
          groups[name] = true
        end
      end
    end
  end

  local results = {}
  for group in pairs(groups) do
    local mod = load(group)
    if mod and mod.get then
      local hl = mod.get(c, opts)
      for k, v in pairs(hl) do
        results[k] = v
      end
    end
  end

  return results
end

return M
