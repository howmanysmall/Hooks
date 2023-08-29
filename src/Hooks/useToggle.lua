--!optimize 2
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local React = require(script.Parent.Parent.RoactCompat)

local function useToggle(initialState: boolean?): (boolean, () -> ())
	local value, setValue = React.useState(not not initialState)
	local toggleValue = React.useCallback(function()
		setValue(not value)
	end, GetDependencies(value))

	return value, toggleValue
end

return useToggle
