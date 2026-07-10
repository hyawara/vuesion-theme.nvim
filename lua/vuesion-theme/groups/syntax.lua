local M = {}

-- 传统 Vim 正则语法组（:help group-name）。
--
-- 为什么需要这个文件：
--   Neovim 的 Treesitter capture（@keyword 等）在没有对应 parser 时不会生效，
--   此时编辑器回退到传统的正则语法高亮，即 Keyword/Function/String 这些经典组。
--   很多插件、帮助文档、以及未安装 parser 的文件类型仍然依赖它们。
--   若不显式定义，这些组会保持 Neovim 内置默认色，与本主题脱节。
--
-- 颜色语义与 treesitter.lua / DEFAULT_* 完全对齐，确保两套高亮观感一致。
function M.get(c, opts)
  local styles = opts.styles or {}

  return {
    -- ██  Statement 家族：DEFAULT_KEYWORD（#ff92bb 粗体）
    Statement = { fg = c.keyword },
    Keyword = { fg = c.keyword },
    Conditional = { fg = c.keyword },
    Repeat = { fg = c.keyword },
    Label = { fg = c.keyword },
    Exception = { fg = c.keyword },
    Operator = { fg = c.operator },

    -- ██  Identifier 家族：DEFAULT_LOCAL_VARIABLE（继承 TEXT）/ DEFAULT_INSTANCE_FIELD
    Identifier = { fg = c.fg },
    Function = { fg = c.function_decl, italic = true, underline = true },

    -- ██  Constant 家族：DEFAULT_STRING / DEFAULT_NUMBER / DEFAULT_CONSTANT
    Constant = { fg = c.constant },
    String = { fg = c.string },
    Character = { fg = c.string },
    Number = { fg = c.number },
    Boolean = { fg = c.number },
    Float = { fg = c.number },

    -- ██  Type 家族：DEFAULT_CLASS_NAME（#f3c811）/ DEFAULT_KEYWORD（修饰符）
    Type = { fg = c.class },
    StorageClass = { fg = c.keyword },
    Structure = { fg = c.class },
    Typedef = { fg = c.class },

    -- ██  PreProc 家族：DEFAULT_KEYWORD（预处理指令归为关键字色）
    PreProc = { fg = c.keyword },
    Include = { fg = c.keyword },
    Define = { fg = c.keyword },
    Macro = { fg = c.predefined },
    PreCondit = { fg = c.keyword },

    -- ██  Special 家族：DEFAULT_ENTITY / DEFAULT_BRACES / DEFAULT_TAG
    Special = { fg = c.entity },
    SpecialChar = { fg = c.entity },
    Tag = { fg = c.tag },
    Delimiter = { fg = c.punctuation },
    SpecialComment = { fg = c.doc_comment, italic = true },
    Debug = { fg = c.keyword },

    -- ██  其它基础组
    Underlined = { underline = true },
    Bold = { bold = true },
    Italic = { italic = true },
    Ignore = { fg = c.fg_dark },
    Error = { fg = c.error },
    -- Comment 与 Todo 在 base.lua 中已按用户 styles 处理，这里不重复定义。
  }
end

return M
