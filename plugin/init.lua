local clock = require("clock")

vim.api.nvim_create_user_command("ClockShowTime", clock.toggle, {})
vim.keymap.set("n", clock.opts.keymap, clock.toggle)
