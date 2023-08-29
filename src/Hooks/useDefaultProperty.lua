--!optimize 2
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local React = require(script.Parent.Parent.RoactCompat)
local Types = require(script.Parent.Parent.Types)

local function useDefaultProperty<T, V>(props: T, propertyName: string, defaultValue: V): V
	assert(type(props) == "table", "Props must be a table.")
	local property = React.useMemo(function()
		local value = props[propertyName]
		return if value == nil then defaultValue else value
	end, GetDependencies(props))

	return property
end

return useDefaultProperty
