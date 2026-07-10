local M = {}

M.url = "https://github.com/hyawa/vuesion-theme.nvim"

function M.get(c, opts)
  local styles = opts.styles
  local is_transparent = opts.transparent
  local dim_inactive = opts.dim_inactive

  local groups = {
    -- ██  Editor
    Normal = { fg = c.fg, bg = c.bg },
    NormalNC = { fg = c.fg, bg = dim_inactive and c.bg_dim or c.bg },
    NormalFloat = { fg = c.fg, bg = c.bg_float },
    NormalSB = { fg = c.fg_sidebar, bg = c.bg_sidebar },
    FloatBorder = { fg = c.border_highlight, bg = c.bg_float },
    FloatTitle = { fg = c.blue, bg = c.bg_float },

    -- ██  Cursor
    Cursor = { fg = c.bg, bg = c.caret },
    lCursor = { fg = c.bg, bg = c.caret },
    CursorLine = { bg = c.bg_caret },
    CursorLineNr = { fg = c.line_number_active, bg = c.bg_caret },
    CursorColumn = { bg = c.bg_highlight },
    LineNr = { fg = c.line_number },
    LineNrAbove = { fg = c.line_number },
    LineNrBelow = { fg = c.line_number },
    Conceal = { fg = c.fg_dark },
    -- 搜索高亮走“灰底 + 冷光点睛”：所有匹配纯灰底白字后退；当前匹配蓝灰底 + 淡蓝字 + bold，
    -- 底仍是灰、观感统一，仅以一点冷光把视线勾到光标所在的词，克制而不喧宾。
    CurSearch = { fg = c.blue_light, bg = c.bg_search_current, bold = true },
    IncSearch = { fg = c.blue_light, bg = c.bg_search_current, bold = true },
    Search = { fg = c.fg, bg = c.bg_search },
    Substitute = { fg = c.bg, bg = c.orange },
    MatchParen = { bg = c.bg_highlight, bold = true },

    -- ██  Visual / Selection
    Visual = { fg = c.selection_fg, bg = c.bg_selection },
    VisualNOS = { bg = c.bg_highlight },
    WildMenu = { fg = c.blue, bg = c.bg_highlight },

    -- ██  Popup Menu
    Pmenu = { fg = c.fg, bg = c.bg_popup },
    PmenuSel = { fg = c.fg, bg = c.blue_dark },
    PmenuKind = { fg = c.blue },
    PmenuKindSel = { fg = c.fg, bg = c.blue_dark },
    PmenuExtra = { fg = c.fg_dark },
    PmenuExtraSel = { fg = c.fg, bg = c.blue_dark },
    PmenuSbar = { bg = c.bg_highlight },
    PmenuThumb = { bg = c.fg_dark },

    -- ██  Statusline
    StatusLine = { fg = c.fg, bg = c.bg_highlight },
    StatusLineNC = { fg = c.fg_dark, bg = c.bg_highlight },
    StatusLineTerm = { fg = c.fg, bg = c.bg_highlight },
    StatusLineTermNC = { fg = c.fg_dark, bg = c.bg_highlight },

    -- ██  Tabline
    TabLine = { fg = c.fg_dim, bg = c.bg },
    TabLineSel = { fg = c.fg, bg = c.bg_highlight },
    TabLineFill = { bg = c.bg },
    TabBar = { bg = c.bg },

    -- ██  Window / Split
    WinSeparator = { fg = c.border, bg = c.bg },
    VertSplit = { fg = c.border },
    WinBar = { fg = c.fg_dim, bg = c.bg },
    WinBarNC = { fg = c.fg_dark, bg = c.bg },

    -- ██  Sidebar / Gutter
    SignColumn = { bg = c.bg },
    SignColumnSB = { bg = c.bg_sidebar },
    FoldColumn = { fg = c.fg_gutter, bg = c.bg },
    Folded = { fg = c.folded, bg = c.bg_highlight },

    -- ██  Special
    NonText = { fg = c.fg_gutter },
    SpecialKey = { fg = c.fg_gutter },
    Whitespace = { fg = c.whitespace },
    EndOfBuffer = { fg = c.bg },
    Title = { fg = c.blue, bold = true },
    Directory = { fg = c.blue },

    -- ██  Messages
    ErrorMsg = { fg = c.error, bold = true },
    WarningMsg = { fg = c.warning, bold = true },
    MoreMsg = { fg = c.green, bold = true },
    ModeMsg = { fg = c.fg_dim },
    Question = { fg = c.blue },

    -- ██  Spelling
    SpellBad = { sp = c.error, undercurl = true },
    SpellCap = { sp = c.warning, undercurl = true },
    SpellLocal = { sp = c.info, undercurl = true },
    SpellRare = { sp = c.hint, undercurl = true },

    -- ██  Column / Highlight
    ColorColumn = { bg = c.bg_highlight },
    QuickFixLine = { bg = c.bg_highlight, bold = true },
    debugBreakpoint = { fg = c.error, bg = c.bg_highlight },

    -- ██  Diff
    DiffAdd = { bg = c.diff.add },
    DiffChange = { bg = c.diff.change },
    DiffDelete = { bg = c.diff.delete },
    DiffText = { bg = c.diff.text },

    -- ██  Diagnostic
    DiagnosticError = { fg = c.error },
    DiagnosticWarn = { fg = c.warning },
    DiagnosticInfo = { fg = c.info },
    DiagnosticHint = { fg = c.hint },
    DiagnosticOk = { fg = c.green },
    DiagnosticVirtualTextError = { fg = c.error },
    DiagnosticVirtualTextWarn = { fg = c.warning },
    DiagnosticVirtualTextInfo = { fg = c.info },
    DiagnosticVirtualTextHint = { fg = c.hint },
    DiagnosticUnderlineError = { sp = c.error_stripe, undercurl = true },
    DiagnosticUnderlineWarn = { sp = c.warning_stripe, undercurl = true },
    DiagnosticUnderlineInfo = { sp = c.info_stripe, undercurl = true },
    DiagnosticUnderlineHint = { sp = c.hint_stripe, undercurl = true },
    DiagnosticSignError = { fg = c.error, bg = c.bg },
    DiagnosticSignWarn = { fg = c.warning, bg = c.bg },
    DiagnosticSignInfo = { fg = c.info, bg = c.bg },
    DiagnosticSignHint = { fg = c.hint, bg = c.bg },
    DiagnosticFloatingError = { fg = c.error },
    DiagnosticFloatingWarn = { fg = c.warning },
    DiagnosticFloatingInfo = { fg = c.info },
    DiagnosticFloatingHint = { fg = c.hint },
    DiagnosticDeprecated = { sp = c.error_stripe, strikethrough = true },

    -- ██  LSP
    LspReferenceText = { bg = c.bg_highlight },
    LspReferenceRead = { bg = c.bg_highlight },
    LspReferenceWrite = { bg = c.bg_highlight },
    LspSignatureActiveParameter = { bg = c.bg_highlight, bold = true },
    LspInlayHint = { fg = c.fg_dark, bg = c.bg_highlight },
    LspCodeLens = { fg = c.fg_dark },
    LspCodeLensSeparator = { fg = c.fg_dark },

    -- ██  Treesitter context / rainbow
    TreesitterContext = { bg = c.bg_highlight },
    TreesitterContextLineNumber = { fg = c.line_number_active, bg = c.bg_highlight },
    RainbowDelimiterRed = { fg = c.red },
    RainbowDelimiterYellow = { fg = c.yellow },
    RainbowDelimiterBlue = { fg = c.blue },
    RainbowDelimiterOrange = { fg = c.orange },
    RainbowDelimiterGreen = { fg = c.green },
    RainbowDelimiterViolet = { fg = c.magenta },
    RainbowDelimiterCyan = { fg = c.cyan },

    -- ██  NvimTree / NeoTree / File navigation
    NvimTreeNormal = { fg = c.fg_sidebar, bg = c.bg_sidebar },
    NvimTreeVertSplit = { fg = c.border },
    NvimTreeFolderIcon = { fg = c.blue },
    NvimTreeFolderName = { fg = c.blue },
    NvimTreeOpenedFolderName = { fg = c.blue_light },
    NvimTreeEmptyFolderName = { fg = c.fg_dark },
    NvimTreeFileDirty = { fg = c.yellow },
    NvimTreeImageFile = { fg = c.pink },
    NvimTreeSpecialFile = { fg = c.pink },
    NvimTreeSymlink = { fg = c.cyan },
    NvimTreeGitDirty = { fg = c.yellow },
    NvimTreeGitStaged = { fg = c.blue },
    NvimTreeGitMerge = { fg = c.red },
    NvimTreeGitRenamed = { fg = c.blue },
    NvimTreeGitNew = { fg = c.green },
    NvimTreeGitDeleted = { fg = c.red },
    NvimTreeRootFolder = { fg = c.fg, bold = true },
    NvimTreeExecFile = { fg = c.green },
    NvimTreeIndentMarker = { fg = c.fg_gutter },
    NvimTreeWindowPicker = { fg = c.bg, bg = c.blue },

    -- ██  Bufferline
    BufferLineFill = { bg = c.bg },
    BufferLineBackground = { fg = c.fg_dim, bg = c.bg },
    BufferLineBufferSelected = { fg = c.fg, bg = c.bg },
    BufferLineBufferVisible = { fg = c.fg_dim, bg = c.bg },
    BufferLineCloseButton = { fg = c.fg_dark },
    BufferLineCloseButtonSelected = { fg = c.red },
    BufferLineCloseButtonVisible = { fg = c.fg_dark },
    BufferLineTab = { fg = c.fg_dim, bg = c.bg },
    BufferLineTabSelected = { fg = c.fg, bg = c.bg },
    BufferLineTabSeparator = { fg = c.border },
    BufferLineTabSeparatorSelected = { fg = c.border },
    BufferLineIndicatorSelected = { fg = c.red },
    BufferLinePick = { fg = c.blue },
    BufferLinePickVisible = { fg = c.blue },
    BufferLinePickSelected = { fg = c.blue },
    BufferLineModified = { fg = c.blue },
    BufferLineModifiedSelected = { fg = c.green },
    BufferLineModifiedVisible = { fg = c.blue },
    BufferLineSeparator = { fg = c.border },
    BufferLineSeparatorSelected = { fg = c.border },
    BufferLineSeparatorVisible = { fg = c.border },
    BufferLineGroupSelected = { fg = c.blue },
    BufferLineGroupClose = { fg = c.red },

    -- ██  WhichKey
    WhichKey = { fg = c.blue, bold = true },
    WhichKeyGroup = { fg = c.pink },
    WhichKeySeparator = { fg = c.fg_dark },
    WhichKeyDesc = { fg = c.fg },
    WhichKeyFloat = { bg = c.bg_float },
    WhichKeyValue = { fg = c.fg_dark },

    -- ██  Lazy
    LazyNormal = { fg = c.fg, bg = c.bg_float },
    LazyButton = { fg = c.fg, bg = c.bg_highlight },
    LazyButtonActive = { fg = c.bg, bg = c.blue },
    LazyReason = { fg = c.fg_dark },
    LazyReasonCmd = { fg = c.orange },
    LazyReasonEvent = { fg = c.yellow },
    LazyReasonFt = { fg = c.blue },
    LazyReasonImport = { fg = c.blue },
    LazyReasonKeys = { fg = c.green },
    LazyReasonPlugin = { fg = c.pink },
    LazyReasonRuntime = { fg = c.pink },
    LazyReasonSource = { fg = c.orange },
    LazyReasonStart = { fg = c.green },
    LazyProp = { fg = c.fg_dark },
    LazyValue = { fg = c.fg },
    LazyCommit = { fg = c.fg_dark },
    LazyCommitType = { fg = c.blue },
    LazySpecial = { fg = c.green },
    LazyDir = { fg = c.blue },
    LazyUrl = { fg = c.blue },
    LazyH1 = { fg = c.blue, bg = c.bg_highlight, bold = true },
    LazyH2 = { fg = c.blue, bg = c.bg_highlight, bold = true },

    -- ██  Trouble
    TroubleNormal = { fg = c.fg, bg = c.bg_float },
    TroubleText = { fg = c.fg_dim },
    TroubleSource = { fg = c.fg_dark },
    TroubleIndent = { fg = c.fg_gutter },
    TroubleCount = { fg = c.pink },
    TroubleFoldIcon = { fg = c.fg_gutter },
    TroubleFile = { fg = c.blue },
    TroubleLocation = { fg = c.fg_dark },

    -- ██  Noice
    NoiceNormal = { fg = c.fg, bg = c.bg_float },
    NoiceBorder = { fg = c.border_highlight, bg = c.bg_float },
    NoicePopupmenu = { fg = c.fg, bg = c.bg_popup },
    NoiceCmdline = { fg = c.fg, bg = c.bg_float },
    NoiceCmdlineIcon = { fg = c.blue },
    NoiceMsgHistory = { fg = c.fg_dim },
    NoiceMini = { fg = c.fg_dim },

    -- ██  Flash
    -- 与搜索的“灰底 + 冷光点睛”对齐：Match（所有候选）用中性灰底 + 亮白字，后退低调；
    -- Current（当前候选）用蓝灰底 + 淡蓝字 + bold，底仍是灰、观感统一，仅以一点冷光聚焦跳出；
    -- 唯独 Label（要敲的键）用淡红底跳出，深字保证对比，一眼锁定目标键。
    FlashBackdrop = { fg = c.fg_dark },
    FlashLabel = { fg = c.bg, bg = c.flash_label, bold = true },
    FlashMatch = { fg = c.fg, bg = c.bg_search, bold = true },
    FlashCurrent = { fg = c.blue_light, bg = c.bg_search_current, bold = true },

    -- ██  Indent Blankline
    IndentBlanklineChar = { fg = c.indent_guide },
    IndentBlanklineContextChar = { fg = c.indent_guide_active },
    IndentBlanklineContextStart = { fg = c.indent_guide_active, underline = true },
    IndentBlanklineSpaceChar = { fg = c.whitespace },
    IndentBlanklineSpaceCharBlankline = { fg = c.whitespace },

    -- ██  Notification / Messages
    NotifyBackground = { bg = c.bg_float },
    NotifyERRORBorder = { fg = c.error },
    NotifyWARNBorder = { fg = c.warning },
    NotifyINFOBorder = { fg = c.info },
    NotifyDEBUGBorder = { fg = c.hint },
    NotifyTRACEBorder = { fg = c.blue_light },
    NotifyERRORIcon = { fg = c.error },
    NotifyWARNIcon = { fg = c.warning },
    NotifyINFOIcon = { fg = c.info },
    NotifyDEBUGIcon = { fg = c.hint },
    NotifyTRACEIcon = { fg = c.blue_light },
    NotifyERRORTitle = { fg = c.error },
    NotifyWARNTitle = { fg = c.warning },
    NotifyINFOTitle = { fg = c.info },
    NotifyDEBUGTitle = { fg = c.hint },
    NotifyTRACETitle = { fg = c.blue_light },
    NotifyERRORBody = { fg = c.fg },
    NotifyWARNBody = { fg = c.fg },
    NotifyINFOBody = { fg = c.fg },
    NotifyDEBUGBody = { fg = c.fg },
    NotifyTRACEBody = { fg = c.fg },

    -- ██  Dashboard / Snacks dashboard
    DashboardHeader = { fg = c.blue },
    DashboardIcon = { fg = c.pink },
    DashboardFooter = { fg = c.fg_dark },
    DashboardProjectTitle = { fg = c.blue },
    DashboardProjectTitleIcon = { fg = c.pink },
    DashboardSection = { fg = c.blue },
    DashboardSectionHeader = { fg = c.blue },
    DashboardMruTitle = { fg = c.fg },
    DashboardFileIcon = { fg = c.fg_dark },
    DashboardShortcut = { fg = c.blue },
    DashboardDesc = { fg = c.fg_dim },
    DashboardKey = { fg = c.orange },

    -- ██  Mini
    MiniCursorword = { bg = c.bg_highlight },
    MiniCursorwordCurrent = { bg = c.bg_highlight },
    MiniIndentscopeSymbol = { fg = c.indent_guide_active },
    MiniJump = { fg = c.blue, bold = true },
    MiniStarterCurrent = { bg = c.bg_highlight },
    MiniStarterFooter = { fg = c.fg_dark },
    MiniStarterHeader = { fg = c.blue },
    MiniStarterInactive = { fg = c.fg_dark },
    MiniStarterItem = { fg = c.fg },
    MiniStarterItemBullet = { fg = c.fg_dark },
    MiniStarterPage = { fg = c.fg_dark },
    MiniStarterQuery = { fg = c.blue },
    MiniStarterSection = { fg = c.blue },
    MiniStatuslineDevinfo = { fg = c.fg, bg = c.bg_highlight },
    MiniStatuslineFileinfo = { fg = c.fg, bg = c.bg_highlight },
    MiniStatuslineModeCommand = { fg = c.bg, bg = c.yellow },
    MiniStatuslineModeInsert = { fg = c.bg, bg = c.green },
    MiniStatuslineModeNormal = { fg = c.bg, bg = c.blue },
    MiniStatuslineModeOther = { fg = c.bg, bg = c.cyan },
    MiniStatuslineModeReplace = { fg = c.bg, bg = c.red },
    MiniStatuslineModeVisual = { fg = c.bg, bg = c.pink },
    MiniTablineCurrent = { fg = c.fg, bg = c.bg_highlight },
    MiniTablineHidden = { fg = c.fg_dim, bg = c.bg },
    MiniTablineModifiedCurrent = { fg = c.green, bg = c.bg_highlight },
    MiniTablineModifiedHidden = { fg = c.green, bg = c.bg },
    MiniTablineModifiedVisible = { fg = c.green, bg = c.bg },
    MiniTablineVisible = { fg = c.fg_dim, bg = c.bg },
    MiniTestEmphasis = { bold = true },
    MiniTestFail = { fg = c.error, bold = true },
    MiniTestPass = { fg = c.green, bold = true },
    MiniTrailspace = { bg = c.error },
    MiniDiffSignAdd = { fg = c.green },
    MiniDiffSignChange = { fg = c.blue },
    MiniDiffSignDelete = { fg = c.red },

    -- ██  DAP
    DapBreakpoint = { fg = c.error },
    DapBreakpointCondition = { fg = c.info },
    DapLogPoint = { fg = c.blue },
    DapStopped = { fg = c.green },
    DapUIBreakpointsCurrentLine = { fg = c.error, bold = true },

    -- ██  Navic
    NavicText = { fg = c.fg_dim },
    NavicSeparator = { fg = c.fg_gutter },

    -- ██  RenderMarkdown
    RenderMarkdownH1 = { fg = c.red, bold = true },
    RenderMarkdownH2 = { fg = c.orange, bold = true },
    RenderMarkdownH3 = { fg = c.yellow, bold = true },
    RenderMarkdownH4 = { fg = c.green, bold = true },
    RenderMarkdownH5 = { fg = c.blue, bold = true },
    RenderMarkdownH6 = { fg = c.pink, bold = true },
    RenderMarkdownCode = { bg = c.bg_highlight },
    RenderMarkdownCodeInline = { fg = c.green_light, bg = c.bg_highlight },
    RenderMarkdownTableHead = { fg = c.fg, bg = c.bg_highlight },
    RenderMarkdownTableRow = { bg = c.bg },
    RenderMarkdownTableFill = { bg = c.bg_highlight },
    RenderMarkdownBullet = { fg = c.fg_dark },
    RenderMarkdownChecked = { fg = c.green },
    RenderMarkdownUnchecked = { fg = c.fg_dim },

    -- ██  Todo（传统正则组；@comment.todo 等语义组统一在 treesitter.lua 定义）
    Todo = { fg = c.yellow, bold = true },

    -- ██  Health
    healthError = { fg = c.error },
    healthSuccess = { fg = c.green },
    healthWarning = { fg = c.warning },
  }

  if is_transparent then
    groups.Normal = { fg = c.fg, bg = c.none }
    groups.SignColumn = { bg = c.none }
    groups.LineNr = { fg = c.line_number, bg = c.none }
    groups.FoldColumn = { fg = c.fg_gutter, bg = c.none }
  end

  if styles.comments and styles.comments.italic then
    groups.Comment = { fg = c.comment, italic = true }
  else
    groups.Comment = { fg = c.comment }
  end

  return groups
end

return M
