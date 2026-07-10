<h1 align="center">vuesion-theme.nvim</h1>

<p align="center">
  <img alt="vuesion" src="https://img.shields.io/badge/vuesion-theme-ff92bb?style=flat-square"/>
  <img alt="Neovim" src="https://img.shields.io/badge/Neovim-0.9%2B-green?style=flat-square"/>
  <img alt="License" src="https://img.shields.io/badge/license-MIT-blue?style=flat-square"/>
</p>

<p align="center">
  Neovim 主题 · 源自 <a href="https://github.com/vuesion/intellij-theme">vuesion/intellij-theme</a> for IntelliJ IDEA
</p>

![Preview](https://github.com/vuesion/intellij-theme/raw/master/resources/screenshot.png)

## 特性

- 完整移植 IntelliJ IDEA vuesion 主题配色
- Treesitter 语义高亮（`@keyword`、`@string`、`@function` 等 80+ 组）
- LSP 诊断颜色 + 语义令牌（`@lsp.type.*` / `@lsp.typemod.*`）
- 插件集成：snacks.nvim、blink.cmp、gitsigns、bufferline、which-key、noice、trouble 等
- Lualine 主题内置
- 深色背景优化

## 安装

### lazy.nvim

```lua
{
  "hyawara/vuesion-theme.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("vuesion-theme").setup({
      -- 配置项见下方
    })
    vim.cmd.colorscheme("vuesion-theme")
  end,
}
```

### packer.nvim

```lua
use {
  "hyawara/vuesion-theme.nvim",
  config = function()
    require("vuesion-theme").setup()
    vim.cmd.colorscheme("vuesion-theme")
  end,
}
```

### 快速使用（无配置）

```lua
vim.cmd.colorscheme("vuesion-theme")
```

## 配置

所有配置均有默认值，按需覆盖即可：

```lua
require("vuesion-theme").setup({
  -- 主题风格（当前仅支持 dark）
  style = "dark",

  -- 透明背景（取消 Normal 背景色）
  transparent = false,

  -- 是否设置终端 16 色
  terminal_colors = true,

  -- 各 token 类型的附加样式
  styles = {
    comments  = { italic = true },  -- 注释斜体
    keywords  = { bold = true },    -- 关键字粗体
    functions = {},                 -- 函数样式
    variables = {},                 -- 变量样式
    sidebars  = "dark",             -- 侧边栏风格：dark | transparent | normal
    floats    = "dark",             -- 浮动窗口风格：同上
  },

  -- 非活跃窗口变暗
  dim_inactive = false,

  -- lualine 主题 section A 使用粗体
  lualine_bold = false,

  -- 插件集成（以下插件开启 auto 后可自动识别）
  plugins = {
    -- 全部启用已注册的插件分组（未安装插件也会安全跳过）
    all   = false,
    -- 自动识别已安装插件（依赖 lazy.nvim）
    auto  = true,

    -- 手动开关（all = false 时生效）
    snacks          = false,
    blink           = false,
    -- blink.cmp Kind 图标颜色：theme = 使用本主题语义色；blink = 回退到 blink/PmenuKind 默认链
    blink_kind_hl   = "theme",
    gitsigns        = false,
    bufferline      = false,
    which_key       = false,
    flash           = false,
    mini            = false,
    indent_blankline = false,
    noice           = false,
    trouble         = false,
    dashboard       = false,
  },
})
```

## 自定义

### 1. 覆盖颜色

```lua
require("vuesion-theme").setup({
  on_colors = function(colors)
    -- 修改任意颜色值
    colors.keyword = "#ff0000"
    colors.bg = "#1a1b2f"
    -- 新增自定义颜色供高亮回调使用
    colors.my_custom = "#ffcc00"
  end,
})
```

### 2. 覆盖高亮组

```lua
require("vuesion-theme").setup({
  on_highlights = function(highlights, colors)
    -- 修改单个高亮组
    highlights.Normal = { fg = colors.fg, bg = colors.bg }
    -- 新增高亮组
    highlights.MyGroup = { fg = colors.my_custom, bold = true }
    -- 链接到已有组
    highlights.MyLink = { link = "Comment" }
  end,
})
```


### 3. blink.cmp Kind 图标颜色策略

默认情况下，本主题会让 `BlinkCmpKind*` 使用与代码语义一致的颜色，例如函数、类名、字段、常量分别复用主题里的 `function_decl`、`class`、`function`、`constant`。如果你更希望交给 blink.cmp 的默认高亮链（通常回退到 `PmenuKind` / 用户自己的 blink 配置），可这样设置：

```lua
require("vuesion-theme").setup({
  plugins = {
    blink_kind_hl = "blink",
  },
})
```

`blink_kind_hl = "theme"` 是默认值，适合追求整体主题一致；`"blink"` 适合已经在 blink.cmp 或其他配置里维护补全图标颜色的用户。

### 4. Lualine 主题

```lua
require("lualine").setup({
  options = {
    theme = "vuesion-theme",  -- 自动加载内置主题
  },
})
```

## 插件支持

| 插件 | 分组文件 | 说明 |
|------|----------|------|
| [snacks.nvim](https://github.com/folke/snacks.nvim) | `snacks.lua` | Picker 界面配色 |
| [blink.cmp](https://github.com/Saghen/blink.cmp) | `blink.lua` | 补全菜单、文档窗口、Kind 图标 |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | `git.lua` | Git 增删改标记 |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | `base.lua` | Tab 标签栏 |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | `base.lua` | 快捷键弹窗 |
| [flash.nvim](https://github.com/folke/flash.nvim) | `base.lua` | 快速跳转标签 |
| [noice.nvim](https://github.com/folke/noice.nvim) | `base.lua` | 消息 UI 美化 |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | `base.lua` | 诊断列表 |
| [mini.nvim](https://github.com/echasnovski/mini.nvim) | `base.lua` | 多个 mini 模块配色 |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | `base.lua` | 缩进参考线 |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | `base.lua` | Markdown 渲染 |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | `lint.lua` | Lint 提示颜色 |

> 更多插件集成（telescope、neo-tree、dap 等）持续添加中。

## 配色参考

以下是从 IntelliJ 原始主题直接移植的核心颜色对照：

| 语义 | Neovim 高亮组 | 色值 | 来源 |
|------|---------------|------|------|
| 背景 | `Normal.bg` | `#202831` | 编辑器背景 |
| 前景 | `Normal.fg` | `#ececee` | 基础文本 |
| 关键字 | `@keyword` | `#ff92bb` | DEFAULT_KEYWORD |
| 字符串 | `@string` | `#40bf77` | DEFAULT_STRING |
| 数字 | `@number` | `#f9846c` | DEFAULT_NUMBER |
| 函数声明 | `@function` | `#90e0a4` | DEFAULT_FUNCTION_DECLARATION |
| 函数调用 | `@function.call` | `#ffffff` | DEFAULT_INSTANCE_METHOD |
| 类名 | `@type` / `@lsp.type.class` | `#f3c811` | DEFAULT_CLASS_NAME |
| 参数 | `@parameter` | `#8dc3f9` | DEFAULT_PARAMETER |
| 常量 | `@constant` | `#3d8beb` | DEFAULT_CONSTANT |
| 运算符 | `@operator` | `#40bf77` | DEFAULT_OPERATION_SIGN |
| HTML 标签 | `@tag` | `#f43b6c` | DEFAULT_TAG |
| HTML 属性 | `@tag.attribute` | `#40bf77` | DEFAULT_ATTRIBUTE |
| 注释 | `@comment` | `#6f7a86` | DEFAULT_LINE_COMMENT |
| 标点 | `@punctuation.bracket` | `#ffffff` | DEFAULT_BRACES |
| 类型 | `@type.builtin` | `#3d8beb` | DEFAULT_PREDEFINED_SYMBOL |
| 错误 | `DiagnosticError` | `#e84606` | ERRORS_ATTRIBUTES |
| 警告 | `DiagnosticWarn` | `#d5aa00` | WARNING_ATTRIBUTES |

## 鸣谢

- [vuesion/intellij-theme](https://github.com/vuesion/intellij-theme) — 原始 IntelliJ IDEA 主题
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) — 架构参考与灵感来源

## 许可

MIT
