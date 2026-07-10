# vuesion-theme.nvim 移植参考文档

> 本文档记录从 IntelliJ vuesion 主题移植到 Neovim 的完整调查资料，
> 包括原始配色对照、映射逻辑、架构设计，方便后续二次修改。

---

## 参考仓库

- **原始 IntelliJ 主题仓库**：https://github.com/vuesion/intellij-theme
- **本 Neovim 移植仓库**：https://github.com/hyawara/vuesion-theme.nvim
- **架构参考 tokyonight.nvim**：https://github.com/folke/tokyonight.nvim

### 获取原始配色文件

```bash
# 1. 克隆原始仓库
git clone --depth 1 https://github.com/vuesion/intellij-theme.git

# 2. 核心文件位置
#    UI 配色：  resources/META-INF/vuesion_theme.theme.json
#    语法配色： resources/META-INF/vuesion_theme.xml

# 3. 更新后对比差异
cd intellij-theme && git pull
# 对比 vuesion_theme.xml 的 <colors> 段和 DEFAULT_* 有没有新变化
# 对比 vuesion_theme.theme.json 的 UI 色有没有变化
```

### 原始文件说明

| 文件 | 大小 | 行数 | 内容 |
|------|------|------|------|
| `vuesion_theme.theme.json` | 10.8KB | 430 | UI 界面配色（按钮、面板、标签、滚动条等） |
| `vuesion_theme.xml` | 101.2KB | 3470 | 编辑器语法配色（继承 Darcula，覆盖差异部分） |

---

## 目录

1. [原始来源文件结构](#1-原始来源文件结构)
2. [IntelliJ 配色系统解析](#2-intellij-配色系统解析)
3. [完整色彩对照表](#3-完整色彩对照表)
4. [DEFAULT_* → Neovim Treesitter 映射](#4-default_-neovim-treesitter-映射)
5. [UI 颜色映射表](#5-ui-颜色映射表)
6. [插件高亮组参考](#6-插件高亮组参考)
7. [架构设计与文件职责](#7-架构设计与文件职责)
8. [调试即扩展指南](#8-调试即扩展指南)

---

## 1. 原始来源文件结构

vuesion/intellij-theme 仓库中有两个核心配色文件：

```
resources/META-INF/
├── vuesion_theme.theme.json    # UI 配色（430 行）
└── vuesion_theme.xml           # 编辑器语法配色（3470 行，142 个 scheme）
```

- `theme.json`：定义 IDE 界面颜色（背景、按钮、标签、滚动条等 UI 组件）
- `vuesion_theme.xml`：定义编辑器区域语法高亮（基于 Darcula 父 scheme 的增量覆盖）
  - `<colors>` 段 (38 行)：编辑器核心颜色（光标、行号、选区、缩进线等）
  - `<attributes>` 段 (3432 行)：各语言的语法 token 颜色定义

**关键设计细节**：vuesion 主题继承自 `Darcula`（IntelliJ 内置深色方案），
只覆盖有差异的部分。绝大部分标记语言（如 Apache Config、Blade、Bash 等）
的特定 token 直接从 Darcula 继承，未在 vuesion 中显式定义。

---

## 2. IntelliJ 配色系统解析

### 2.1 解析架构

IntelliJ 的配色基于"语义 token"系统，与 Neovim Treesitter 高度相似：

```
IntelliJ 层次:           Neovim 层次:
                   
  UI (theme.json)   ──→  Normal, Pmenu, StatusLine 等
                      ↓
  Editor (xml)      ──→  vim 原生组 (Cursor/LineNr/Search)
                      ↓
  DEFAULT_*         ──→  Treesitter @groups (语义无关)
                      ↓
  语言特定 token    ──→  (可选，暂未移植)
  (BASH.xxx,        ──→  各语言 parser 专用组
   PYTHON.xxx, ...)
```

**移植策略**：仅移植 `DEFAULT_*` 通用语义组 + 编辑器 `<colors>` 段。
语言特定 token 由 Treesitter 的 `@` 组自动映射覆盖。

### 2.2 FONT_TYPE 编码对照

在 `vuesion_theme.xml` 中，每个 `<option name="FONT_TYPE">` 值的含义：

| 值 | 含义       | Neovim 对应     |
|----|-----------|-----------------|
| 0  | 普通       | -               |
| 1  | **粗体**   | `bold = true`   |
| 2  | *斜体*     | `italic = true` |
| 3  | ***粗斜体*** | `bold = true, italic = true` |

### 2.3 EFFECT_TYPE 编码对照

| 值 | 含义       | Neovim 对应          |
|----|-----------|----------------------|
| 0  | 无         | -                    |
| 1  | 下划线     | `underline = true`   |
| 2  | 波浪线     | `undercurl = true`   |
| 3  | 删除线     | `strikethrough = true` |
| 4  | 盒状       | 不支持               |
| 5  | 点状下划线 | 近似为 `underline = true`（Neovim 亦可用 `underdotted`） |

> 注意：**斜体/粗体由 `FONT_TYPE` 控制，不属于 `EFFECT_TYPE`**。
> vuesion 中方法/字段声明（`DEFAULT_INSTANCE_METHOD` 等）用 `EFFECT_TYPE=5`
> 表现为点状下划线，本移植统一近似为普通 `underline`。

---

## 3. 完整色彩对照表

### 3.1 编辑器核心颜色（来自 XML `<colors>` 段）

```xml
<option name="ADDED_LINES_COLOR"            value="40bf77" />
<option name="CARET_COLOR"                  value="ececee" />
<option name="CARET_ROW_COLOR"              value="182029" />
<option name="CONSOLE_BACKGROUND_KEY"       value="202831" />
<option name="DELETED_LINES_COLOR"          value="303a45" />
<option name="DIFF_SEPARATORS_BACKGROUND"   value="303a45" />
<option name="DOCUMENTATION_COLOR"          value="303a45" />
<option name="ERROR_HINT"                   value="770600" />
<option name="FILESTATUS_ADDED"             value="40bf77" />
<option name="FILESTATUS_UNKNOWN"           value="f9846c" />
<option name="FOLDED_TEXT_BORDER_COLOR"     value="d8ecfe" />
<option name="GUTTER_BACKGROUND"            value="202831" />
<option name="INDENT_GUIDE"                 value="303a45" />
<option name="INFORMATION_HINT"             value="303a45" />
<option name="LINE_NUMBERS_COLOR"           value="55616c" />
<option name="LINE_NUMBER_ON_CARET_ROW_COLOR" value="c9cbcf" />
<option name="MODIFIED_LINES_COLOR"         value="55616c" />
<option name="NOTIFICATION_BACKGROUND"      value="434e5b" />
<option name="QUESTION_HINT"                value="303a45" />
<option name="RECENT_LOCATIONS_SELECTION"   value="303a45" />
<option name="RIGHT_MARGIN_COLOR"           value="434e5b" />
<option name="SELECTED_INDENT_GUIDE"        value="6f7a86" />
<option name="SELECTION_BACKGROUND"         value="9ca2aa" />
<option name="SELECTION_FOREGROUND"         value="202831" />
<option name="TEARLINE_COLOR"               value="303a45" />
<option name="TOOLTIP"                      value="303a45" />
<option name="WHITESPACES"                  value="6f7a86" />
<option name="WHITESPACES_MODIFIED_LINES_COLOR" value="55616c" />
```

### 3.2 UI 界面颜色（来自 theme.json）

```json
{
  "*": {
    "background":              "#202831",
    "foreground":              "#c9cbcf",
    "infoForeground":          "#6f7a86",
    "selectionBackground":     "#303a45",
    "selectionForeground":     "#ececee",
    "selectionInactiveBackground": "#303a45",
    "disabledBackground":      "#70011f",
    "inactiveBackground":      "#70011f",
    "disabledForeground":      "#303a45",
    "disabledText":            "#303a45",
    "inactiveForeground":      "#ececee",
    "acceleratorForeground":   "#ececee",
    "acceleratorSelectionForeground": "#ececee",
    "errorForeground":         "#c82600",
    "borderColor":             "#303a45",
    "disabledBorderColor":     "#303a45",
    "focusColor":              "#434e5b",
    "focusedBorderColor":      "#434e5b",
    "hoverBorderColor":        "#434e5b",
    "pressedBorderColor":      "#434e5b",
    "separatorColor":          "#303a45",
    "lineSeparatorColor":      "#434e5b"
  }
}
```

### 3.3 主色提取总表

| 变量名          | 色值       | 来源                                              |
|----------------|-----------|---------------------------------------------------|
| `bg`           | `#202831` | theme.json `*background` + CONSOLE_BACKGROUND_KEY  |
| `bg_dark`      | `#0c1014` | CompletionPopup.selectionBackground                |
| `bg_float`     | `#0c1014` | 同上，浮动窗口用                                   |
| `bg_highlight` | `#303a45` | selectionBackground + INDENT_GUIDE                 |
| `bg_popup`     | `#0c1014` | CompletionPopup                                    |
| `bg_sidebar`   | `#202831` | ToolWindow.Header.background                       |
| `bg_search`         | `#434e5b` | 搜索所有匹配灰底（灰底+冷光点睛方案，中性灰 + 亮字）|
| `bg_search_current` | `#4a6076` | 搜索当前匹配蓝灰底（灰底+冷光点睛方案，配淡蓝字）   |
| `bg_visual`    | `#303a45` | selectionBackground                                |
| `bg_selection` | `#9ca2aa` | SELECTION_BACKGROUND                               |
| `bg_caret`     | `#182029` | CARET_ROW_COLOR                                    |
| `fg`           | `#ececee` | Editor.foreground + TEXT foreground                |
| `fg_dim`       | `#c9cbcf` | theme.json `*foreground` + LINE_NUMBER_ON_CARET_ROW |
| `fg_dark`      | `#6f7a86` | infoForeground + WHITESPACES                       |
| `fg_gutter`    | `#55616c` | LINE_NUMBERS_COLOR                                 |
| `border`       | `#303a45` | borderColor                                        |
| `border_highlight` | `#434e5b` | focusColor + RIGHT_MARGIN_COLOR                  |

---

## 4. DEFAULT_* → Neovim Treesitter 映射

这是移植最核心的映射表。每个 `DEFAULT_*` token 对应 IntelliJ 的跨语言语义类。

| IntelliJ DEFAULT_* Token | 色值 | 修饰 | → Neovim Treesitter 组 | dark.lua 变量 |
|--------------------------|------|------|------------------------|--------------|
| `DEFAULT_KEYWORD` | `#ff92bb` | 粗体 | `@keyword`, `@conditional`, `@repeat`, `@exception`, `@include`, `@define`, `@debug`, `@keyword.return`, `@keyword.function`, `@keyword.operator`, `@storageclass`, `@type.qualifier` | `keyword` |
| `DEFAULT_STRING` | `#40bf77` | - | `@string`, `@string.regex`, `@string.escape`, `@character` | `string` |
| `DEFAULT_NUMBER` | `#f9846c` | - | `@number`, `@number.float`, `@boolean` | `number` |
| `DEFAULT_FUNCTION_DECLARATION` | `#90e0a4` | 斜体+下划线 | `@function` | `function_decl` |
| `DEFAULT_INSTANCE_METHOD` | `#ffffff` | 下划线 | `@function.method`, `@function.method.call` | `["function"]` |
| `DEFAULT_STATIC_METHOD` | `#ffffff`(继承 INSTANCE_METHOD) | 斜体 | `@lsp.typemod.method.static` | `["function"]` (白色+斜体+下划线) |
| `DEFAULT_CLASS_NAME` | `#f3c811` | - | `@type`, `@type.definition`, `@lsp.type.class`, `@lsp.type.enum`, `@lsp.type.struct` | `class` |
| `DEFAULT_INTERFACE_NAME` | `#f3c811` | - | `@lsp.type.interface` | `class` |
| `DEFAULT_CONSTANT` | `#3d8beb` | - | `@constant`, `@lsp.type.enumMember`, `@lsp.typemod.variable.readonly` | `constant` |
| `DEFAULT_PARAMETER` | `#8dc3f9` | - | `@parameter`, `@parameter.reference`, `@variable.parameter`, `@lsp.type.parameter`, `@lsp.typemod.parameter.declaration` | `parameter` |
| `DEFAULT_LOCAL_VARIABLE` | 继承(TEXT) | - | `@variable` | `fg` (#ececee) |
| `DEFAULT_GLOBAL_VARIABLE` | 继承(TEXT) | - | `@lsp.typemod.variable.global` | `fg` |
| `DEFAULT_INSTANCE_FIELD` | `#ffffff` | 下划线 | `@field`, `@property`, `@variable.member`, `@lsp.type.property` | `["function"]` |
| `DEFAULT_STATIC_FIELD` | `#ffffff` | 斜体+下划线 | `@lsp.typemod.property.static` | `["function"]` (斜体) |
| `DEFAULT_PREDEFINED_SYMBOL` | `#3d8beb` | - | `@constant.builtin`, `@constant.macro`, `@variable.builtin`, `@type.builtin`, `@function.builtin`, `@lsp.type.macro`, `@lsp.typemod.class.defaultLibrary`, `@lsp.typemod.method.static` | `predefined` |
| `DEFAULT_ATTRIBUTE` | `#40bf77` | 斜体 | `@attribute`, `@annotation`, `@decorator`, `@tag.attribute` | `attribute` |
| `DEFAULT_TAG` | `#f43b6c` | - | `@tag` | `tag` |
| `DEFAULT_ENTITY` | `#f9846c` | - | `@string.special`, `@string.special.symbol`, `@string.special.path`, `@character.special` | `entity` |
| `DEFAULT_OPERATION_SIGN` | `#40bf77` | - | `@operator` | `operator` |
| `DEFAULT_SEMICOLON` | `#40bf77` | - | 无（归入 `@punctuation.delimiter`） | `semicolon` |
| `DEFAULT_BRACES` | `#ffffff` | - | `@punctuation.bracket` | `punctuation` |
| `DEFAULT_BRACKETS` | `#ffffff` | - | `@punctuation.bracket` | `punctuation` |
| `DEFAULT_PARENTHS` | `#ffffff` | - | `@punctuation.bracket` | `punctuation` |
| `DEFAULT_COMMA` | `#ffffff` | - | `@punctuation.delimiter` | `punctuation` |
| `DEFAULT_DOT` | `#ffffff` | 斜体 | `@punctuation.delimiter` | `punctuation` |
| `DEFAULT_LINE_COMMENT` | `#6f7a86` | 斜体 | `@comment`, `@comment.documentation` | `comment` |
| `DEFAULT_BLOCK_COMMENT` | `#6f7a86` | 斜体 | `@comment.documentation` | `comment` |
| `DEFAULT_DOC_COMMENT` | `#6f7a86` | 斜体 | `@comment.documentation` | `doc_comment` |
| `DEFAULT_DOC_COMMENT_TAG` | 继承 | 粗体+下划线 | `@comment.tag.doc` | - |
| `DEFAULT_DOC_COMMENT_TAG_VALUE` | `#3d8beb` | 斜体 | `@comment.tag.doc` | `predefined` |
| `DEFAULT_DOC_MARKUP` | `#40bf77` | - | `@markup.raw` | `string` |
| `DEFAULT_VALID_STRING_ESCAPE` | `#40bf77` | - | `@string.escape` | `string` |
| `DEFAULT_INVALID_STRING_ESCAPE` | `#40bf77` | 红色波浪线(#de3700) | `@string.escape` | `string` |
| `DEFAULT_METADATA` | `#3d8beb` | - | `@annotation` (部分) | `predefined` |

---

## 5. UI 颜色映射表

### 5.1 XML `<colors>` → Neovim 高亮组

| XML 选项             | 色值       | → Neovim 高亮组                |
|---------------------|-----------|-------------------------------|
| CARET_COLOR         | `#ececee` | `Cursor` (fg)                 |
| CARET_ROW_COLOR     | `#182029` | `CursorLine` (bg)             |
| LINE_NUMBERS_COLOR  | `#55616c` | `LineNr` (fg)                 |
| LINE_NUMBER_ON_CARET_ROW_COLOR | `#c9cbcf` | `CursorLineNr` (fg)         |
| SELECTION_BACKGROUND | `#9ca2aa` | `Visual` 选区背景 (但实际用了 `bg_visual` = #303a45) |
| SELECTION_FOREGROUND | `#202831` | 暂未使用（IntelliJ 文本选中后前景色） |
| INDENT_GUIDE        | `#303a45` | `IndentBlanklineChar`         |
| SELECTED_INDENT_GUIDE | `#6f7a86` | `IndentBlanklineContextChar`  |
| RIGHT_MARGIN_COLOR  | `#434e5b` | `ColorColumn` (参考)           |
| WHITESPACES         | `#6f7a86` | `Whitespace`                  |
| GUTTER_BACKGROUND   | `#202831` | `SignColumn` (bg)             |
| FOLDED_TEXT_BORDER_COLOR | `#d8ecfe` | `Folded` (fg)               |
| ERROR_HINT          | `#770600` | `DiagnosticVirtualTextError` (bg) |
| NOTIFICATION_BACKGROUND | `#434e5b` | 浮动窗口分隔符色              |
| ADDED_LINES_COLOR   | `#40bf77` | `DiffAdd`/`GitSignsAdd` (参考) |
| DELETED_LINES_COLOR | `#303a45` | `DiffDelete` (参考)           |

### 5.2 theme.json 关键 UI → Neovim 映射

| JSON 路径                     | 色值       | → Neovim 高亮组               |
|------------------------------|-----------|------------------------------|
| `*background`                | `#202831` | `Normal` (bg)                |
| `*foreground`                | `#c9cbcf` | `Normal` (fg 使用了 Editor.fg=#ececee) |
| `Editor.background`          | `#202831` | 编辑器背景                    |
| `Editor.foreground`          | `#ececee` | `Normal` (fg)                |
| `Button.default.startBackground` | `#f43b6c` | 主按钮背景（状态栏模式指示） |
| `Button.default.endBackground`   | `#cd0940` | 主按钮渐变结束色             |
| `Link.activeForeground`      | `#3d8beb` | `@markup.link`               |
| `Link.hoverForeground`       | `#216fe0` | 链接悬停                     |
| `CompletionPopup.selectionBackground` | `#0c1014` | `Pmenu` (bg)           |
| `CompletionPopup.matchForeground` | `#0d9660` | 补全匹配高亮               |
| `DefaultTabs.underlineColor` | `#3d8beb` | `TabLineSel` 下划线           |
| `Table.stripeColor`          | `#303a45` | 表格条纹背景                  |
| `ScrollBar.thumbColor`       | `#303a45` | `PmenuThumb`                 |
| `ScrollBar.hoverThumbColor`  | `#9ca2aa` | 滚动条悬停                    |
| `ProgressBar.trackColor`     | `#ececee` | 进度条轨道                    |
| `ProgressBar.progressColor`  | `#303a45` | 进度条填充                    |
| `ToggleButton.onBackground`  | `#216fe0` | 开关开启背景                  |
| `ToggleButton.offBackground` | `#0c1014` | 开关关闭背景                  |

---

## 6. 插件高亮组参考

### 6.1 snacks.nvim (`groups/snacks.lua`)

```lua
SnacksPicker, SnacksPickerBorder, SnacksPickerTitle
SnacksPickerList, SnacksPickerListCursorLine, SnacksPickerListSelected
SnacksPickerInput, SnacksPickerInputBorder, SnacksPickerInputTitle
SnacksPickerPreview, SnacksPickerPreviewBorder, SnacksPickerPreviewTitle
SnacksPickerPrompt, SnacksPickerIcon, SnacksPickerIconFile
SnacksPickerDirectory, SnacksPickerFile, SnacksPickerMatch
SnacksPickerHeader, SnacksPickerFooter, SnacksPickerToggle
SnacksPickerKeymap, SnacksPickerGitStatus, SnacksPickerGitBranch
SnacksPickerProgress, SnacksPickerTotal, SnacksPickerHidden
SnacksPickerCell, SnacksPickerCellText, SnacksPickerCellIcon
SnacksPickerCellLabel, SnacksPickerScrollbar, SnacksPickerScrollbarThumb
```

### 6.2 blink.cmp (`groups/blink.lua`)

```lua
BlinkCmpMenu, BlinkCmpMenuBorder, BlinkCmpMenuSelection
BlinkCmpScrollBarThumb, BlinkCmpScrollBarGutter
BlinkCmpDoc, BlinkCmpDocBorder, BlinkCmpDocSeparator, BlinkCmpDocCursorLine
BlinkCmpSignatureHelp, BlinkCmpSignatureHelpBorder, BlinkCmpSignatureHelpActiveParameter
BlinkCmpLabel, BlinkCmpLabelDeprecated, BlinkCmpLabelMatch
BlinkCmpLabelDetail, BlinkCmpLabelDescription
BlinkCmpKind, BlinkCmpSource, BlinkCmpGhostText
BlinkCmpKindText, BlinkCmpKindMethod, BlinkCmpKindFunction,
BlinkCmpKindConstructor, BlinkCmpKindField, BlinkCmpKindVariable,
BlinkCmpKindClass, BlinkCmpKindInterface, BlinkCmpKindModule,
BlinkCmpKindProperty, BlinkCmpKindUnit, BlinkCmpKindValue,
BlinkCmpKindEnum, BlinkCmpKindKeyword, BlinkCmpKindSnippet,
BlinkCmpKindColor, BlinkCmpKindFile, BlinkCmpKindReference,
BlinkCmpKindFolder, BlinkCmpKindEnumMember, BlinkCmpKindConstant,
BlinkCmpKindStruct, BlinkCmpKindEvent, BlinkCmpKindOperator,
BlinkCmpKindTypeParameter, BlinkCmpKindArray, BlinkCmpKindObject,
BlinkCmpKindComponent, BlinkCmpKindFragment, BlinkCmpKindNull,
BlinkCmpKindNumber, BlinkCmpKindBoolean
```

### 6.3 gitsigns (`groups/git.lua`)

```lua
GitSignsAdd, GitSignsChange, GitSignsDelete
GitSignsAddLn, GitSignsChangeLn, GitSignsDeleteLn
GitSignsAddNr, GitSignsChangeNr, GitSignsDeleteNr
GitSignsAddInline, GitSignsDeleteInline, GitSignsChangeInline
GitSignsUntracked, GitSignsCurrentLineBlame
```

### 6.4 base.lua 中集成的插件

| 插件 | 高亮组前缀 |
|------|-----------|
| bufferline.nvim | `BufferLine*` |
| which-key.nvim | `WhichKey*` |
| lazy.nvim | `Lazy*` |
| trouble.nvim | `Trouble*` |
| noice.nvim | `Noice*` |
| flash.nvim | `Flash*` |
| indent-blankline.nvim | `IndentBlankline*` |
| notify (vim.notify) | `Notify*` |
| snacks dashboard | `Dashboard*` |
| mini.nvim | `Mini*` |
| nvim-dap | `Dap*`, `DapUI*` |
| navic | `Navic*` |
| render-markdown.nvim | `RenderMarkdown*` |
| nvim-tree | `NvimTree*` |
| rainbow-delimiters | `RainbowDelimiter*` |

---

## 7. 架构设计与文件职责

### 7.1 加载流程

```
:colorscheme vuesion-theme
  └→ colors/vuesion-theme.lua
       └→ require("vuesion-theme").load({})
            │
            ├── config.extend(opts)     ← 合并默认配置
            ├── vim.o.background = "dark"
            ├── theme.setup(options)
            │    │
            │    ├── colors.setup(opts) ← 加载调色板
            │    │    ├── require("vuesion-theme.colors.dark")  ← 纯数据文件
            │    │    ├── 展平所有子表到 colors 顶层
            │    │    ├── on_colors(colors)  ← 用户回调
            │    │    └── return colors
            │    │
            │    ├── theme.set_terminal_colors(c)
            │    │
            │    ├── groups.setup(c, opts)  ← 组装高亮
            │    │    ├── 计算启动的 group 列表
            │    │    ├── require 每个 group 文件
            │    │    ├── mod.get(c, opts) ← 各文件返回高亮表
            │    │    ├── 合并所有 group 的结果
            │    │    └── on_highlights(groups, c) ← 用户回调
            │    │
            │    └── for group, hl in pairs(groups) do
            │          vim.api.nvim_set_hl(0, group, hl)
            │       done
```

### 7.2 各文件职责速查

| 文件 | 职责 | 是否数据文件 |
|------|------|------------|
| `colors/vuesion-theme.lua` | colorscheme 入口，一行加载 | 否 |
| `lua/vuesion-theme/init.lua` | 公开 API：`setup()` / `load()` | 否 |
| `lua/vuesion-theme/config.lua` | 配置默认值 + 合并逻辑 | 否 |
| `lua/vuesion-theme/theme.lua` | 装配线：调度以上所有模块 | 否 |
| `lua/vuesion-theme/util.lua` | 颜色工具：blend/lighten/darken/template | 否 |
| `lua/vuesion-theme/colors/init.lua` | 调色板加载 + 衍生色计算 | 部分 |
| `lua/vuesion-theme/colors/dark.lua` | **纯数据**：所有颜色值定义 | **是** |
| `lua/vuesion-theme/groups/init.lua` | 分发器：插件检测 + 合并 | 否 |
| `lua/vuesion-theme/groups/base.lua` | 编辑器核心 + 大部分插件集成 | 否 |
| `lua/vuesion-theme/groups/syntax.lua` | 传统 Vim 正则语法组（无 treesitter parser 时的 fallback） | 否 |
| `lua/vuesion-theme/groups/treesitter.lua` | `@` 语义组定义 | 否 |
| `lua/vuesion-theme/groups/semantic_tokens.lua` | LSP 语义令牌定义 | 否 |
| `lua/vuesion-theme/groups/blink.lua` | blink.cmp 专用 | 否 |
| `lua/vuesion-theme/groups/snacks.lua` | snacks.nvim 专用 | 否 |
| `lua/vuesion-theme/groups/git.lua` | gitsigns 专用 | 否 |
| `lua/vuesion-theme/groups/lint.lua` | nvim-lint 专用 | 否 |
| `lua/lualine/themes/vuesion-theme.lua` | lualine 主题 | 否 |

### 7.3 新增/修改颜色的步骤

1. **改颜色值** → 编辑 `lua/vuesion-theme/colors/dark.lua`（纯数据，最安全）
2. **新增颜色变量** → dark.lua 中加键值对，如 `my_color = "#ff0000"`
3. **新增高亮组映射** → 在对应 `groups/*.lua` 的 `get()` 函数中 return 表内添加
4. **新增插件支持** → 在 `groups/` 下新建文件，返回 `{get = function(c, opts) return { ... } end}`
5. **注册新插件** → 在 `groups/init.lua` 的 `M.plugins` 表中添加对应关系

---

## 8. 调试即扩展指南

### 8.1 快速查看当前高亮颜色

```vim
:lua local hl = vim.api.nvim_get_hl(0, {name="Normal"})
      print(string.format("fg=#%06x bg=#%06x", hl.fg, hl.bg))
```

### 8.2 实时重载主题

```vim
:lua require("vuesion-theme").load({})
```

### 8.3 调试加载链

```vim
" 检查 colors 是否正确
:lua local c = require("vuesion-theme.colors").setup({style="dark"})
     print(c.fg, c.bg, c.keyword)

" 检查某个 group 文件
:lua local g = require("vuesion-theme.groups.treesitter")
     local c = require("vuesion-theme.colors").setup({style="dark"})
     local hl = g.get(c, {styles={}})
     print(vim.inspect(hl["@keyword"]))
```

### 8.4 添加新语言支持

参考 IntelliJ XML 中的语言特定 token，例如对 TypeScript 的支持：

```xml
<!-- 如果有 TS 特定色值 -->
<option name="TS.PARAMETER">
  <value><option name="FOREGROUND" value="8dc3f9" /></value>
</option>
```

→ 在 `lua/langs/` 下建 `typescript.lua`（按照用户现有 Neovim 配置的多语言模式），
→ 或在 `lua/vuesion-theme/groups/` 下直接加 `typescript.lua`。

### 8.5 IntelliJ 原始主题升级适配

当 vuesion/intellij-theme 更新时：

1. 重新拉取：`git pull` vuesion/intellij-theme
2. 对比 `vuesion_theme.xml` 的 `<colors>` 段是否有新颜色
3. 对比 `vuesion_theme.xml` 的 `DEFAULT_*` 是否有新 token 或颜色变更
4. 对比 `vuesion_theme.theme.json` 的 UI 配色是否有变化
5. 更新 `lua/vuesion-theme/colors/dark.lua` 中的色值
6. 更新各组 `groups/*.lua` 中的映射
7. 运行完整的颜色验证：

```vim
:lua require("vuesion-theme").load({})
:lua local expected = {Normal="#ececee", ["@keyword"]="#ff92bb"}
     for name, expect in pairs(expected) do
       local hl = vim.api.nvim_get_hl(0, {name=name})
       local actual = hl.fg and ("#" .. string.format("%06x", hl.fg)) or "NONE"
       print(name, actual == expect and "✓" or ("✗ expected "..expect.." got "..actual))
     end
```

---

## 附录 A：终端 16 色映射

| 颜色索引 | 名称        | 色值       | 来源                    |
|---------|------------|-----------|------------------------|
| 0       | black      | `#202831` | 编辑器背景              |
| 1       | red        | `#de3700` | CONSOLE_ERROR_OUTPUT   |
| 2       | green      | `#40bf77` | DEFAULT_STRING         |
| 3       | yellow     | `#f3c811` | DEFAULT_CLASS_NAME     |
| 4       | blue       | `#3d8beb` | DEFAULT_CONSTANT       |
| 5       | magenta    | `#ff92bb` | DEFAULT_KEYWORD        |
| 6       | cyan       | `#33cccc` | CONSOLE_CYAN_OUTPUT    |
| 7       | white      | `#c9cbcf` | theme.json *foreground |
| 8       | bright_black | `#434e5b` | NOTIFICATION_BACKGROUND |
| 9       | bright_red | `#e84606` | ERRORS_ATTRIBUTES       |
| 10      | bright_green | `#40bf77` | 同 green               |
| 11      | bright_yellow | `#f3c811` | 同 yellow              |
| 12      | bright_blue | `#8dc3f9` | CONSOLE_BLUE_BRIGHT_OUTPUT |
| 13      | bright_magenta | `#ff92bb` | 同 magenta            |
| 14      | bright_cyan | `#33cccc` | 同 cyan               |
| 15      | bright_white | `#ececee` | Editor.foreground      |

## 附录 B：IntelliJ Icon 调色板（参考）

`theme.json` 中 `icons.ColorPalette` 段的颜色，GUI 文件与代码图标专用：

| 图标名              | 色值       |
|--------------------|-----------|
| Actions.Grey       | `#ececee` |
| Actions.Red        | `#c82600` |
| Actions.Yellow     | `#f3c811` |
| Actions.Green      | `#40bf77` |
| Actions.Blue       | `#216fe0` |
| Objects.Grey       | `#ececee` |
| Objects.RedStatus  | `#e84606` |
| Objects.Red        | `#e84606` |
| Objects.Pink       | `#ff92bb` |
| Objects.Yellow     | `#f3c811` |
| Objects.Green      | `#40bf77` |
| Objects.Blue       | `#216fe0` |
| Objects.Purple     | `#b30636` |
| Objects.BlackText  | `#0c1014` |
| Objects.YellowDark | `#d5aa00` |
| Objects.GreenAndroid | `#0d9660` |
