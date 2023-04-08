--!optimize 2
--!strict
local NilDependency = setmetatable({}, {
	__tostring = function()
		return "Symbol(NilDependency)"
	end,
})

local function GetDependencies(...: unknown)
	local length = select("#", ...)
	local array = table.create(length)

	for index = 1, length do
		local dependency = select(index, ...)
		array[index] = if dependency == nil then NilDependency else dependency
	end

	return array
end

return GetDependencies
