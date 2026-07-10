local M = {}

M.url = "https://github.com/nvim-treesitter/nvim-treesitter"

function M.get(c, opts)
  return {
    -- ██  LSP Semantic Token Types
    ["@lsp.type.class"] = { fg = c.class },
    ["@lsp.type.decorator"] = { fg = c.attribute, italic = true },
    ["@lsp.type.enum"] = { fg = c.class },
    ["@lsp.type.enumMember"] = { fg = c.constant },
    ["@lsp.type.function"] = { fg = c["function"] },
    ["@lsp.type.interface"] = { fg = c.class },
    ["@lsp.type.macro"] = { fg = c.predefined },
    ["@lsp.type.method"] = { fg = c["function"], underline = true },
    ["@lsp.type.namespace"] = { fg = c.blue },
    ["@lsp.type.parameter"] = { fg = c.parameter },
    ["@lsp.type.property"] = { fg = c["function"], underline = true },
    ["@lsp.type.struct"] = { fg = c.class },
    ["@lsp.type.type"] = { fg = c.class },
    ["@lsp.type.typeParameter"] = { fg = c.parameter },
    ["@lsp.type.variable"] = { fg = c.fg },

    -- ██  LSP Semantic Token Modifiers
    ["@lsp.typemod.class.defaultLibrary"] = { fg = c.predefined },
    ["@lsp.typemod.enumMember.readonly"] = { fg = c.constant },
    ["@lsp.typemod.function.readonly"] = { fg = c.function_decl },
    ["@lsp.typemod.method.static"] = { fg = c.predefined, italic = true },
    ["@lsp.typemod.method.abstract"] = { fg = c.function_decl, italic = true, underline = true },
    ["@lsp.typemod.parameter.declaration"] = { fg = c.parameter },
    ["@lsp.typemod.property.static"] = { fg = c["function"], italic = true, underline = true },
    ["@lsp.typemod.variable.global"] = { fg = c.fg },
    ["@lsp.typemod.variable.static"] = { fg = c.fg, italic = true, underline = true },
    ["@lsp.typemod.variable.readonly"] = { fg = c.constant },
    ["@lsp.type.macro"] = { fg = c.predefined },
  }
end

return M
