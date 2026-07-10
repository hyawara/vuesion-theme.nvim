local M = {}

M.url = "https://github.com/nvim-treesitter/nvim-treesitter"

function M.get(c, opts)
  local styles = opts.styles

  return {
    -- ██  Comments
    ["@comment"] = { fg = c.comment, italic = true },
    ["@comment.documentation"] = { fg = c.doc_comment, italic = true },
    ["@comment.error"] = { fg = c.error, italic = true },
    ["@comment.warning"] = { fg = c.warning, italic = true },
    ["@comment.todo"] = { fg = c.yellow, bold = true },
    ["@comment.note"] = { fg = c.blue, bold = true },

    -- ██  Punctuation
    ["@punctuation.delimiter"] = { fg = c.punctuation },
    ["@punctuation.bracket"] = { fg = c.punctuation },
    ["@punctuation.special"] = { fg = c.punctuation },

    -- ██  Constants
    ["@constant"] = { fg = c.constant },
    ["@constant.builtin"] = { fg = c.predefined },
    ["@constant.macro"] = { fg = c.predefined },

    -- ██  Strings
    ["@string"] = { fg = c.string },
    ["@string.regex"] = { fg = c.string },
    ["@string.escape"] = { fg = c.string },
    ["@string.special"] = { fg = c.entity },
    ["@string.special.symbol"] = { fg = c.entity },
    ["@string.special.path"] = { fg = c.entity },

    -- ██  Character
    ["@character"] = { fg = c.string },
    ["@character.special"] = { fg = c.entity },

    -- ██  Numbers
    ["@number"] = { fg = c.number },
    ["@number.float"] = { fg = c.number },
    ["@boolean"] = { fg = c.number },

    -- ██  Functions
    ["@function"] = { fg = c.function_decl, italic = true, underline = true },
    ["@function.builtin"] = { fg = c.predefined },
    ["@function.call"] = { fg = c["function"] },
    ["@function.method"] = { fg = c["function"], underline = true },
    ["@function.method.call"] = { fg = c["function"] },
    ["@constructor"] = { fg = c.yellow },
    ["@constructor.ts"] = { fg = c.class },

    -- ██  Parameters
    ["@parameter"] = { fg = c.parameter },
    ["@parameter.reference"] = { fg = c.parameter },

    -- ██  Fields
    ["@field"] = { fg = c["function"], underline = true },
    ["@property"] = { fg = c["function"], underline = true },

    -- ██  Variables
    ["@variable"] = { fg = c.fg },
    ["@variable.builtin"] = { fg = c.predefined },
    ["@variable.member"] = { fg = c["function"], underline = true },
    ["@variable.parameter"] = { fg = c.parameter },

    -- ██  Keywords
    ["@keyword"] = { fg = c.keyword, bold = true },
    ["@keyword.function"] = { fg = c.keyword, bold = true },
    ["@keyword.operator"] = { fg = c.keyword, bold = true },
    ["@keyword.return"] = { fg = c.keyword, bold = true },
    ["@conditional"] = { fg = c.keyword, bold = true },
    ["@repeat"] = { fg = c.keyword, bold = true },
    ["@debug"] = { fg = c.keyword, bold = true },
    ["@exception"] = { fg = c.keyword, bold = true },
    ["@include"] = { fg = c.keyword, bold = true },
    ["@define"] = { fg = c.keyword, bold = true },

    -- ██  Types
    ["@type"] = { fg = c.class },
    ["@type.builtin"] = { fg = c.predefined },
    ["@type.definition"] = { fg = c.class },
    ["@type.qualifier"] = { fg = c.keyword, bold = true },

    -- ██  Storage / Modifiers
    ["@storageclass"] = { fg = c.keyword, bold = true },
    ["@attribute"] = { fg = c.attribute, italic = true },
    ["@annotation"] = { fg = c.attribute, italic = true },
    ["@decorator"] = { fg = c.attribute, italic = true },

    -- ██  Modules / Namespaces
    ["@module"] = { fg = c.blue },
    ["@namespace"] = { fg = c.blue },
    ["@label"] = { fg = c.fg_dim },

    -- ██  Operators
    ["@operator"] = { fg = c.operator },

    -- ██  Tags (HTML/JSX)
    ["@tag"] = { fg = c.tag },
    ["@tag.attribute"] = { fg = c.attribute, italic = true },
    ["@tag.delimiter"] = { fg = c.punctuation },

    -- ██  Markup
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
