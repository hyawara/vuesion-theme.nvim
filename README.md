<h1 align="center">vuesion-theme.nvim</h1>

<p align="center">
  <img alt="vuesion" src="https://img.shields.io/badge/vuesion-theme-ff92bb?style=flat-square"/>
  <img alt="Neovim" src="https://img.shields.io/badge/Neovim-0.9%2B-green?style=flat-square"/>
  <img alt="License" src="https://img.shields.io/badge/license-MIT-blue?style=flat-square"/>
</p>

<p align="center">
  A Neovim colorscheme ported from <a href="https://github.com/vuesion/intellij-theme">vuesion/intellij-theme</a> for IntelliJ IDEA.
</p>

![Preview](https://github.com/vuesion/intellij-theme/raw/master/resources/screenshot.png)

## Features

- Full port of the vuesion IntelliJ IDEA theme colors
- Treesitter support with semantic highlights
- LSP diagnostic and semantic token integration
- Plugin support: snacks.nvim, blink.cmp, gitsigns, bufferline, which-key, noice, trouble, and more
- Lualine theme included
- Optimized for dark backgrounds

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "hyawa/vuesion-theme.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("vuesion-theme").setup({
      -- your config here
    })
    vim.cmd.colorscheme("vuesion-theme")
  end,
}
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  "hyawa/vuesion-theme.nvim",
  config = function()
    require("vuesion-theme").setup()
    vim.cmd.colorscheme("vuesion-theme")
  end,
}
```

## Configuration

Default options:

```lua
require("vuesion-theme").setup({
  -- style = "dark" is the only style currently
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    -- functions = {},
    -- variables = {},
    sidebars = "dark",
    floats = "dark",
  },
  dim_inactive = false,
  lualine_bold = false,
  on_colors = function(colors) end,
  on_highlights = function(highlights, colors) end,
  plugins = {
    all = true,
    auto = true,
  },
})
```

## Credits

- [vuesion](https://github.com/vuesion/intellij-theme) - Original IntelliJ IDEA theme
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) - Architecture inspiration
