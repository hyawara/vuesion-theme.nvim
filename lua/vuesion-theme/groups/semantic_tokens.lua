local M = {}

M.url = "https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#semanticTokens"

-- LSP 语义令牌是 Treesitter 的补充：这里保持与 DEFAULT_* 同一套颜色语义。
function M.get(c, opts)
  return {
    -- ██  LSP Semantic Token Types
    ["@lsp.type.class"] = { fg = c.class },
    ["@lsp.type.comment"] = { fg = c.comment, italic = true },
    ["@lsp.type.decorator"] = { fg = c.attribute, italic = true },
    ["@lsp.type.enum"] = { fg = c.class },
    ["@lsp.type.enumMember"] = { fg = c.constant },
    ["@lsp.type.event"] = { fg = c.class },
    ["@lsp.type.function"] = { fg = c["function"] },
    ["@lsp.type.interface"] = { fg = c.class },
    ["@lsp.type.keyword"] = { fg = c.keyword, bold = true },
    ["@lsp.type.macro"] = { fg = c.predefined },
    ["@lsp.type.method"] = { fg = c["function"], underline = true },
    ["@lsp.type.modifier"] = { fg = c.keyword, bold = true },
    ["@lsp.type.namespace"] = { fg = c.blue },
    ["@lsp.type.number"] = { fg = c.number },
    ["@lsp.type.operator"] = { fg = c.operator },
    ["@lsp.type.parameter"] = { fg = c.parameter },
    ["@lsp.type.property"] = { fg = c["function"], underline = true },
    ["@lsp.type.regexp"] = { fg = c.string },
    ["@lsp.type.string"] = { fg = c.string },
    ["@lsp.type.struct"] = { fg = c.class },
    ["@lsp.type.type"] = { fg = c.class },
    ["@lsp.type.typeParameter"] = { fg = c.parameter },
    ["@lsp.type.variable"] = { fg = c.fg },

    -- ██  LSP Semantic Token Modifiers
    ["@lsp.typemod.class.defaultLibrary"] = { fg = c.predefined },
    ["@lsp.typemod.enumMember.readonly"] = { fg = c.constant },
    ["@lsp.typemod.function.declaration"] = { fg = c.function_decl, italic = true, underline = true },
    ["@lsp.typemod.function.readonly"] = { fg = c.function_decl },
    ["@lsp.typemod.method.abstract"] = { fg = c.function_decl, italic = true, underline = true },
    ["@lsp.typemod.method.declaration"] = { fg = c.function_decl, italic = true, underline = true },
    -- DEFAULT_STATIC_METHOD 原始只有 FONT_TYPE=2（斜体），前景继承 INSTANCE_METHOD 的白色。
    ["@lsp.typemod.method.static"] = { fg = c["function"], italic = true, underline = true },
    ["@lsp.typemod.parameter.declaration"] = { fg = c.parameter },
    ["@lsp.typemod.property.declaration"] = { fg = c["function"], underline = true },
    ["@lsp.typemod.property.readonly"] = { fg = c.constant, underline = true },
    ["@lsp.typemod.property.static"] = { fg = c["function"], italic = true, underline = true },
    ["@lsp.typemod.variable.global"] = { fg = c.fg },
    ["@lsp.typemod.variable.readonly"] = { fg = c.constant },
    ["@lsp.typemod.variable.static"] = { fg = c.fg, italic = true, underline = true },
  }
end

return M
