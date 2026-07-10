local M = {}

M.url = "https://github.com/nvim-treesitter/nvim-treesitter"

-- 将 IntelliJ 的 DEFAULT_* 语义 token 映射到 Neovim Treesitter capture。
-- 这里尽量只处理“语言无关”的核心语法；语言/插件专用适配后续再分文件补。
function M.get(c, opts)
  local styles = opts.styles or {}

  local function with_style(base, extra)
    return vim.tbl_extend("force", {}, base, extra or {})
  end

  local comment = with_style({ fg = c.comment }, styles.comments)
  local doc_comment = with_style({ fg = c.doc_comment }, styles.comments)
  local keyword = with_style({ fg = c.keyword }, styles.keywords)
  local function_decl = with_style({ fg = c.function_decl, italic = true, underline = true }, styles.functions)
  local function_call = with_style({ fg = c["function"] }, styles.functions)
  local method = with_style({ fg = c["function"], underline = true }, styles.functions)
  local variable = with_style({ fg = c.fg }, styles.variables)

  return {
    -- ██  注释：DEFAULT_LINE_COMMENT / DEFAULT_BLOCK_COMMENT / DEFAULT_DOC_COMMENT
    ["@comment"] = comment,
    ["@comment.documentation"] = doc_comment,
    ["@comment.error"] = { fg = c.error, italic = true },
    ["@comment.warning"] = { fg = c.warning, italic = true },
    ["@comment.todo"] = { fg = c.yellow, bold = true },
    ["@comment.note"] = { fg = c.blue, bold = true },
    ["@comment.tag"] = { fg = c.predefined, bold = true, underline = true },
    ["@comment.tag.doc"] = { fg = c.predefined, italic = true },

    -- ██  标点：DEFAULT_BRACES / DEFAULT_BRACKETS / DEFAULT_PARENTHS / DEFAULT_COMMA / DEFAULT_DOT
    ["@punctuation.delimiter"] = { fg = c.punctuation },
    ["@punctuation.delimiter.semicolon"] = { fg = c.semicolon },
    ["@punctuation.delimiter.dot"] = { fg = c.punctuation, italic = true },
    ["@punctuation.bracket"] = { fg = c.punctuation },
    ["@punctuation.special"] = { fg = c.punctuation },

    -- ██  常量：DEFAULT_CONSTANT / DEFAULT_PREDEFINED_SYMBOL
    ["@constant"] = { fg = c.constant },
    ["@constant.builtin"] = { fg = c.predefined },
    ["@constant.macro"] = { fg = c.predefined },

    -- ██  字符串：DEFAULT_STRING / DEFAULT_VALID_STRING_ESCAPE / DEFAULT_INVALID_STRING_ESCAPE
    ["@string"] = { fg = c.string },
    ["@string.regex"] = { fg = c.string },
    ["@string.regexp"] = { fg = c.string },
    ["@string.escape"] = { fg = c.string },
    ["@string.escape.invalid"] = { fg = c.string, sp = c.red, undercurl = true },
    ["@string.special"] = { fg = c.entity },
    ["@string.special.symbol"] = { fg = c.entity },
    ["@string.special.path"] = { fg = c.entity },
    ["@string.special.url"] = { fg = c.blue, underline = true },

    -- ██  字符与数字：DEFAULT_STRING / DEFAULT_ENTITY / DEFAULT_NUMBER
    ["@character"] = { fg = c.string },
    ["@character.special"] = { fg = c.entity },
    ["@number"] = { fg = c.number },
    ["@number.float"] = { fg = c.number },
    ["@boolean"] = { fg = c.number },

    -- ██  函数：DEFAULT_FUNCTION_DECLARATION / DEFAULT_INSTANCE_METHOD / DEFAULT_PREDEFINED_SYMBOL
    ["@function"] = function_decl,
    ["@function.builtin"] = { fg = c.predefined },
    ["@function.call"] = function_call,
    ["@function.macro"] = { fg = c.predefined },
    ["@function.method"] = method,
    ["@function.method.call"] = function_call,
    ["@method"] = method,
    ["@method.call"] = function_call,
    ["@constructor"] = { fg = c.class },
    ["@constructor.ts"] = { fg = c.class },

    -- ██  参数/字段/变量：DEFAULT_PARAMETER / DEFAULT_INSTANCE_FIELD / DEFAULT_LOCAL_VARIABLE
    ["@parameter"] = { fg = c.parameter },
    ["@parameter.reference"] = { fg = c.parameter },
    ["@variable.parameter"] = { fg = c.parameter },
    ["@field"] = method,
    ["@property"] = method,
    ["@variable"] = variable,
    ["@variable.builtin"] = { fg = c.predefined },
    ["@variable.member"] = method,

    -- ██  关键字：DEFAULT_KEYWORD
    ["@keyword"] = keyword,
    ["@keyword.conditional"] = keyword,
    ["@keyword.debug"] = keyword,
    ["@keyword.directive"] = keyword,
    ["@keyword.directive.define"] = keyword,
    ["@keyword.exception"] = keyword,
    ["@keyword.function"] = keyword,
    ["@keyword.import"] = keyword,
    ["@keyword.operator"] = keyword,
    ["@keyword.repeat"] = keyword,
    ["@keyword.return"] = keyword,
    ["@conditional"] = keyword,
    ["@repeat"] = keyword,
    ["@debug"] = keyword,
    ["@exception"] = keyword,
    ["@include"] = keyword,
    ["@define"] = keyword,

    -- ██  类型：DEFAULT_CLASS_NAME / DEFAULT_INTERFACE_NAME / DEFAULT_PREDEFINED_SYMBOL
    ["@type"] = { fg = c.class },
    ["@type.builtin"] = { fg = c.predefined },
    ["@type.definition"] = { fg = c.class },
    ["@type.qualifier"] = keyword,

    -- ██  修饰符/属性：DEFAULT_KEYWORD / DEFAULT_ATTRIBUTE / DEFAULT_METADATA
    ["@storageclass"] = keyword,
    ["@attribute"] = { fg = c.attribute, italic = true },
    ["@annotation"] = { fg = c.predefined, italic = true },
    ["@decorator"] = { fg = c.attribute, italic = true },

    -- ██  模块/命名空间
    ["@module"] = { fg = c.blue },
    ["@module.builtin"] = { fg = c.predefined },
    ["@namespace"] = { fg = c.blue },
    ["@label"] = { fg = c.fg_dim },

    -- ██  运算符：DEFAULT_OPERATION_SIGN
    ["@operator"] = { fg = c.operator },

    -- ██  标签：DEFAULT_TAG / DEFAULT_ATTRIBUTE
    ["@tag"] = { fg = c.tag },
    ["@tag.attribute"] = { fg = c.attribute, italic = true },
    ["@tag.delimiter"] = { fg = c.punctuation },

    -- ██  Markup / Markdown：兼容 Neovim 新式 @markup.* capture
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { fg = c.blue, bold = true },
    ["@markup.heading.1"] = { fg = c.red, bold = true },
    ["@markup.heading.2"] = { fg = c.orange, bold = true },
    ["@markup.heading.3"] = { fg = c.yellow, bold = true },
    ["@markup.heading.4"] = { fg = c.green, bold = true },
    ["@markup.heading.5"] = { fg = c.blue, bold = true },
    ["@markup.heading.6"] = { fg = c.pink, bold = true },
    ["@markup.quote"] = { fg = c.fg_dark, italic = true },
    ["@markup.math"] = { fg = c.number },
    ["@markup.link"] = { fg = c.blue, underline = true },
    ["@markup.link.url"] = { fg = c.blue, underline = true },
    ["@markup.link.label"] = { fg = c.blue },
    ["@markup.list"] = { fg = c.fg_dim },
    ["@markup.list.checked"] = { fg = c.green },
    ["@markup.list.unchecked"] = { fg = c.fg_dim },
    ["@markup.raw"] = { fg = c.string },
    ["@markup.raw.block"] = { fg = c.fg, bg = c.bg_highlight },

    -- ██  Diff
    ["@diff.plus"] = { fg = c.green },
    ["@diff.minus"] = { fg = c.error },
    ["@diff.delta"] = { fg = c.blue },

    -- ██  Special / Misc
    ["@none"] = {},
    ["@conceal"] = { fg = c.fg_dark },
    ["@spell"] = {},
    ["@error"] = { fg = c.error },
    ["@todo"] = { fg = c.yellow, bold = true },
    ["@underline"] = { underline = true },
    ["@nospell"] = {},
  }
end

return M
