local clock = require("clock")

describe("clock", function()
	before_each(function()
		clock._win = nil
	end)

	it("is loaded", function()
		assert.is_truthy(package.loaded["clock"])
	end)

	it("setup can accept options", function()
		local defaultOps = {
			title_pos = "right",
			window_pos = "TR",
			timeout = true,
			timeout_duration = 7000,
			timer_opts = {
				duration = 300,
			},
		}

		clock.setup({
			title_pos = "right",
			window_pos = "TR",
			timeout_duration = 7000,
			timer_opts = {
				duration = 300,
			},
		})

		assert.are.same(defaultOps, clock.opts)
	end)

	it("can get time", function()
		clock._get_time()
		assert.are.same(2, #clock._time)
	end)

	it("opens a window", function()
		clock.toggle()
		assert.is_truthy(clock._win)
	end)

	it("can call the user command", function()
		vim.defer_fn(function()
			vim.api.nvim_command("ClockShowTime")
			assert.is_truthy(clock._win)
		end, 100)
	end)
end)
