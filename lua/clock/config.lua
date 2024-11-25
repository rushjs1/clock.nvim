local M = {}

local defaults = {
	title_pos = "center", -- "left, right or center"
	window_pos = "TR", -- "TR(top right) or center"
	timeout = true,
	timeout_duration = 5000,
	timer_opts = {
		timer_duration = 600, --(10mins - in seconds)
		timer_completion_duration = 10000, --(10seconds - in miliseconds)
		timer_title = "Focus Time",
		timer_duration_selections = {
			60,
			300,
			600,
			900,
			1200,
			1500,
			1800,
			2100,
			2400,
			2700,
			3000,
			3300,
		},
	},
}

function M.setup(user_opts)
	M.opts = vim.tbl_deep_extend("force", {}, defaults, user_opts or {})

	return M.opts
end

return M
