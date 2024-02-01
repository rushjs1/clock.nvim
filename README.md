# Clock.nvim

Display the time or a simple pomodoro timer in a floating window.

![Preview](https://i.imgur.com/414ToUX.gif)

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
        require("clock").setup({})
    end,
})
```

## Setup

Example using the default options

```lua

-- Call the setup function - empty to use defaults
require("clock").setup({})
```

Example using custom options

```lua
-- Call the setup function and pass the following options
require("clock").setup({
	title_pos = "left", -- "left, right or center"
	window_pos = "center", --"TR(top right) or center"
	timeout = false, --disable the timeout
	timeout_duration = 3000, --duration for the timeout
	timer_opts = {
		timer_duration = 600, --(10mins - in seconds)
		timer_completion_duration = 10000, --(10seconds - in miliseconds)
        timer_title = "Focus Time" -- title for the timer floating window
	},
})
```

## Commands

`:ClockShowTime` Toggle the 'time' window.

`:ClockStartTimer` Start the pomodoro timer.

`:ClockSelectTime` Opens the window to select a duration for the timer.

`:ClockToggleTimer` Toggle the pomodoro timer floating window(timer continues to run in the background).

`:ClockStopTimer` Stop and clear the pomodoro timer.

`:ClockRestartTimer` Restart the pomodoro timer.

```lua
keymap.set("n", "<leader><leader>t", ":ClockShowTime<CR>")
keymap.set("n", "<leader><leader>s", ":ClockSelectTime<CR>")
keymap.set("n", "<leader><leader>dt", ":ClockToggleTimer<CR>")
```

## Configuration

```lua
--default_options

--@field title_pos string
--@field window_pos string
--@field timeout boolean
--@field timeout_duration integer
--@table timer_opts
--@field timer_duration integer
--@field timer_completion_duration integer
--@field timer_title string

M.default_opts = {
	title_pos = "center", -- "left, right or center"
	window_pos = "TR", -- "TR(top right) or center"
	timeout = true, --disable the timeout
	timeout_duration = 5000,
	timer_opts = {
		timer_duration = 600, --(10mins - in seconds)
		timer_completion_duration = 10000, --(10seconds - in miliseconds)
        timer_title = "Focus Time" -- title for the timer floating window
	},
}
```
