local M = {}

M.did_setup = false

function M.setup(opts)
	M.did_setup = true

	local options = require("clock.config").setup(opts)

	local clock = require("clock.clock")
	local timer = require("clock.timer")

	clock.setup(options)
	timer.setup(options)

	vim.api.nvim_create_user_command("ClockShowTime", clock.toggle, {})

	vim.api.nvim_create_user_command("ClockStartTimer", timer.start, {})
	vim.api.nvim_create_user_command("ClockToggleTimer", timer.toggle_timer, {})
	vim.api.nvim_create_user_command("ClockRestartTimer", timer.restart, {})
	vim.api.nvim_create_user_command("ClockStopTimer", timer.stop, {})
	vim.api.nvim_create_user_command("ClockSelectTime", timer.select, {})
end

return M
