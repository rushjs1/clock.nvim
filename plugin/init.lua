local clock = require("clock")
local timer = require("timer")

vim.api.nvim_create_user_command("ClockShowTime", clock.toggle, {})
vim.api.nvim_create_user_command("ClockStartTimer", timer.start, {})
vim.api.nvim_create_user_command("ClockToggleTimer", timer.toggle_timer, {})
