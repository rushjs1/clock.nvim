local M = {}

--params to get at setup:
-- keymap to call get_time
-- position of window (northEast or center)
-- timeout enabled (if so, also get timeout duration)

--TODO:
--docs
--tests
--timers?

M.get_time = function()
	local d = os.date("%A %B %d")
	local t = os.date("%I:%M %p")
	local m = os.date("%p")

	local time = {
		d,
		t,
	}

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, time)

	local width = 30
	local height = #time + 2
	local title = m == "AM" and "Good Morning" or "Good Afternoon"

	local opts = {
		relative = "win",
		width = width,
		height = height,
		row = 0,
		col = vim.fn.winwidth(0) - width - 4,
		style = "minimal",
		border = "rounded",
		title = title,
		title_pos = "center",
	}

	-- opts for center of screen
	--[[ local opts = {
		relative = "win",
		width = width,
		height = height,
		row = math.floor((vim.fn.winheight(0) - height) / 2),
		col = math.floor((vim.fn.winwidth(0) - width) / 2),
		style = "minimal",
		border = "rounded",
	} ]]

	local win = vim.api.nvim_open_win(buf, false, opts)

	vim.defer_fn(function()
		vim.api.nvim_win_close(win, true)
	end, 5000)
end

return M
