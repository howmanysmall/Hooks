--!optimize 2
local NilDependency = setmetatable({}, {
	__tostring = function()
		return "Symbol(NilDependency)"
	end,
})

local function GetDependencies(...: unknown)
	local Length = select("#", ...)
	local Array = table.create(Length)

	for Index = 1, Length do
		local Dependency = select(Index, ...)
		Array[Index] = if Dependency == nil then NilDependency else Dependency
	end

	return Array
end

return GetDependencies
