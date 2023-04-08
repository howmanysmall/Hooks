--!optimize 2
--!strict
local LuauPolyfill = require(script.Parent.Parent.Packages.LuauPolyfill)
local String = LuauPolyfill.String

local POSSIBLE_VALUES = string.split("0123456789abcdefghijklmnopqrstuvwxyz", "")

local function ToBase36(value: number)
	local new = ""
	local intPart, decimalPart = math.modf(value)

	while intPart > 0 do
		local index = intPart % 36 + 1
		new = POSSIBLE_VALUES[index] .. new
		intPart = math.floor(intPart / 36)
	end

	if decimalPart > 0 then
		new ..= "."
		while decimalPart > 0 do
			decimalPart *= 36
			local digit = math.floor(decimalPart)
			new ..= POSSIBLE_VALUES[digit + 1]
			decimalPart -= digit
		end
	end

	return new
end

local function GetRandomId()
	return `hooks-{String.slice(ToBase36(math.random()), 2, 11)}`
end

return GetRandomId
