# Clock.nvim

Display the time in a floating window using a keymap.

![Preview](https://i.imgur.com/Dr09AtI.gif)

## Purpose

Learning the basics about creating a plugin for neovim.

## Installation

Install via package manager.

```lua
-- Packer
use("rushjs1/clock.nvim")
```

```lua
-- Packer
 use({
    "rushjs1/clock.nvim",
    config = function()
        require("clock").setup({
            keymap = "<space>m",
            title_pos = "left",
            window_pos = "center",
            timeout_duration = 3000,
        })
    end,
})

```

## Setup & Usage

Example using the default options

```lua

-- Call the setup function - empty to use defaults
require("clock").setup({})
```

Example using custom options

```lua
-- Call the setup function and pass the following options
require("clock").setup({
	keymap = "<space>m", -- keymap used to toggle the window
	title_pos = "left", -- "left, right or center"
	window_pos = "center", --"TR(top right) or center"
	timeout = false, --disable the timeout
	timeout_duration = 3000, --duration for the timeout
})
```

## Commands

`:ClockShowTime` Toggle the window.

## Configuration

```lua
--default_options

--@field keymap string
--@field title_pos string
--@field window_pos string
--@field timeout boolean
--@field timeout_duration integer

M.default_opts = {
	keymap = "<space><space>t", --keymap used to toggle the window
	title_pos = "center", -- "left, right or center"
	window_pos = "TR", -- "TR(top right) or center"
	timeout = true, --disable the timeout
	timeout_duration = 5000,
}
```
