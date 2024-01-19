local M = {}

--TODO:
--timers?

--default_options
--
--@field keymap string
--@field title_pos string
--@field window_pos string
--@field timeout boolean
--@field timeout_duration integer

M.default_opts = {
	keymap = "<space><space>t",
	title_pos = "center", -- "left, right or center"
	window_pos = "TR", -- "TR(top right) or center"
	timeout = true,
	timeout_duration = 5000,
}

M._win = nil

M.setup = function(options)
	M.opts = M.default_opts

	for opt_key, opt_val in pairs(options) do
		M.opts[opt_key] = opt_val
	end
end

M.toggle = function()
	if M._win and vim.api.nvim_win_is_valid(M._win) and M.opts.timeout == false then
		-- user doesnt want timeout so just close the window upon toggle
		vim.api.nvim_win_close(M._win, true)
		M._win = nil
		return
	end

	M._get_time()
end

M._get_time = function()
	local d = os.date("%A %B %d")
	local t = os.date("%I:%M %p")
	local m = os.date("%p")

	M._time = {
		d,
		t,
	}

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, M._time)

	local width = 30
	local height = #M._time + 2
	local title = m == "AM" and "Good Morning" or "Good Afternoon"

	local row
	local col

	if M.opts.window_pos == "center" then
		row = math.floor((vim.fn.winheight(0) - height) / 2)
		col = math.floor((vim.fn.winwidth(0) - width) / 2)
	else
		row = 0
		col = vim.fn.winwidth(0) - width - 4
	end

	local opts = {
		relative = "win",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = title,
		title_pos = M.opts.title_pos,
	}

	M._win = vim.api.nvim_open_win(buf, false, opts)

	if not M.opts.timeout then
		return
	end

	vim.defer_fn(function()
		vim.api.nvim_win_close(M._win, true)

		M._win = nil
	end, M.opts.timeout_duration)
end

return M
