local clock = require("clock")

--TODO:
--Accept duration via user_command param
------ instead... window to maybe select or enter duration ??
--Swap out demo gif on README
--tests

local M = {}

local timeFormat = "%I:%M:%S %p"

M._count = 0
M._endTime = nil
M._remainingTime = nil
M._startTime = nil
M._win_opts = nil

M._win = nil
M._buf = nil

M._tick = function()
	vim.defer_fn(function()
		if M.is_timer_running() == false then
			return
		end

		local content = M.calculate_time()

		if M._remainingTime == "00:00" then
			M._timer_completed()

			return
		end

		vim.api.nvim_buf_set_lines(M._buf, 0, -1, false, content)

		M._tick()
	end, 1000)
end

M.start = function()
	print("starting timer...")

	local duration = clock.opts.timer_opts.timer_duration

	M._count = M._count + 1

	if M._count == 1 then
		M._endTime = os.date(timeFormat, os.time() + duration)
		M._startTime = os.time() + duration
		M._tick()

		local info = M.calculate_time()

		M._open_win({ content = info })

		return
	end
end

M.calculate_time = function()
	local remainingSeconds = os.difftime(M._startTime, os.time())

	M._remainingTime = os.date("%M:%S", remainingSeconds)

	return {
		"🕰️ Current Time: " .. os.date(timeFormat),
		"🛎️ Completed At: " .. M._endTime,
		"",
		"⏳ Remaining Time: " .. M._remainingTime,
	}
end

M._open_win = function(args)
	M._buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(M._buf, 0, -1, false, args.content)

	local width = 40
	local height = #args.content + 2

	local row
	local col

	if clock.opts.window_pos == "center" then
		row = math.floor((vim.fn.winheight(0) - height) / 2)
		col = math.floor((vim.fn.winwidth(0) - width) / 2)
	else
		row = 0
		col = vim.fn.winwidth(0) - width - 4
	end

	M._win_opts = {
		relative = "win",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = clock.opts.timer_opts.timer_title,
		title_pos = clock.opts.title_pos,
	}

	M._win = vim.api.nvim_open_win(M._buf, false, M._win_opts)

	if not args.close then
		return
	end

	vim.defer_fn(function()
		M._clear()

		if not args.cb then
			return
		end

		args.cb()
	end, 2000)
end

M.is_timer_running = function()
	if M._win == nil then
		return false
	else
		return true
	end
end

M.stop = function()
	if M.is_timer_running() == false then
		print("No timer running.")
		return
	end

	M._clear(M._open_win, { content = { "Stopping timer..." }, close = true })
end

M.restart = function()
	if M.is_timer_running() == false then
		print("No timer running.")
		return
	end

	M._clear(M._open_win, { content = { "Restarting timer..." }, close = true, cb = M.start })
end

M.toggle_timer = function()
	if M.is_timer_running() == false then
		print("No timer running.")
		return
	end

	if vim.api.nvim_win_is_valid(M._win) then
		vim.api.nvim_win_close(M._win, true)
	else
		M._win = vim.api.nvim_open_win(M._buf, false, M._win_opts)
	end
end

M._timer_completed = function()
	print("Timer Completed!!")

	vim.api.nvim_buf_set_lines(
		M._buf,
		0,
		-1,
		false,
		{ "🍅🍅 Focus Time Completed!! 🍅🍅", "", "Go enjoy a break" }
	)

	if not vim.api.nvim_win_is_valid(M._win) then
		M._win = vim.api.nvim_open_win(M._buf, false, M._win_opts)
	end

	vim.defer_fn(function()
		M._clear()
	end, clock.opts.timer_opts.timer_completion_duration)
end

M._clear = function(cb, arg)
	if M._win ~= nil then
		vim.api.nvim_win_close(M._win, true)
	end

	M._win = nil
	M._buf = nil

	M._endTime = nil
	M._remainingTime = nil
	M._startTime = nil
	M._win_opts = nil
	M._count = 0

	if not cb then
		return
	end

	--wait for the tick to finish
	vim.defer_fn(function()
		cb(arg)
	end, 1000)
end

return M
