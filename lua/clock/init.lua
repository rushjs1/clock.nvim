local M = {}

--[[ M.foo = function()
	print("foooooo")

	vim.keymap.set("n", "<space>m", M.bar)
end

M.foo()

M.bar = function()
	print("barrrrrrr")
end ]]

M.get_time = function()
	local weekday = os.date("%A")
	local month = os.date("%B")
	local day = os.date("%d")

	local hour = os.date("%I")
	local minute = os.date("%M")
	local meridiem = os.date("%p")

	local t = {
		weekday,
		month,
		day,
		hour .. ":" .. minute .. meridiem,
	}

	P(t)
end

return M
