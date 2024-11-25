local timer = (vim.uv or vim.loop).new_timer()

timer:start(
	500,
	0,
	vim.schedule_wrap(function()
		local clock = require("clock")

		if not clock.did_setup then
			clock.setup()
		end
	end)
)
