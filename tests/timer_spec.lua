local timer = require("timer")

describe("timer", function()
	before_each(function()
		timer._clear()
	end)

	it("can call start", function()
		assert.has_no.errors(timer.start)
		assert.is_truthy(timer._remainingTime)
	end)

	it("can call clear", function()
		timer.start()
		assert.is_truthy(timer._win)

		timer._clear()
		assert.are.same(nil, timer._win)
	end)

	it("can be stopped", function()
		timer.start()
		assert.is_truthy(timer._remainingTime)

		timer.stop()
		assert.are.same(nil, timer._remainingTime)
	end)

	it("can be restarted", function()
		timer.start()

		if timer._count == 1 then
			timer.restart()
		end

		assert.are.same(0, timer._count)
	end)

	it("duration can be selected", function()
		timer._selected_duration = 900
		timer.start()
		assert.are.same(timer._remainingTime, "15:00")
	end)

	it("select window can be opened", function()
		timer.select()
		assert.is_truthy(timer._select_win)
	end)
end)
