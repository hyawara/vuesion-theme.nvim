local M = {}

function M.blend(fg, bg, alpha)
  alpha = alpha or 0.5
  local function parse(hex)
    return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
  end

  local rf, gf, bf = parse(fg)
  local rb, gb, bb = parse(bg)

  local r = math.floor(rf * alpha + rb * (1 - alpha))
  local g = math.floor(gf * alpha + gb * (1 - alpha))
  local b = math.floor(bf * alpha + bb * (1 - alpha))

  return string.format("#%02x%02x%02x", r, g, b)
end

function M.lighten(hex, amount)
  local function parse(h)
    return tonumber(h:sub(1, 2), 16), tonumber(h:sub(3, 4), 16), tonumber(h:sub(5, 6), 16)
  end
  local r, g, b = parse(hex)
  r = math.min(255, math.floor(r + (255 - r) * amount))
  g = math.min(255, math.floor(g + (255 - g) * amount))
  b = math.min(255, math.floor(b + (255 - b) * amount))
  return string.format("#%02x%02x%02x", r, g, b)
end

function M.darken(hex, amount)
  local function parse(h)
    return tonumber(h:sub(1, 2), 16), tonumber(h:sub(3, 4), 16), tonumber(h:sub(5, 6), 16)
  end
  local r, g, b = parse(hex)
  r = math.floor(r * (1 - amount))
  g = math.floor(g * (1 - amount))
  b = math.floor(b * (1 - amount))
  return string.format("#%02x%02x%02x", r, g, b)
end

function M.resolve(highlights)
  for group, hl in pairs(highlights) do
    if hl.style then
      if hl.style.bold then hl.bold = true end
      if hl.style.italic then hl.italic = true end
      if hl.style.underline then hl.underline = true end
      if hl.style.undercurl then hl.undercurl = true end
      if hl.style.strikethrough then hl.strikethrough = true end
      if hl.style.reverse then hl.reverse = true end
      hl.style = nil
    end
  end
end

function M.template(str, vars)
  return str:gsub("%$([%w_]+)", function(key)
    return vars[key] or ("$" .. key)
  end)
end

return M
