--!optimize 2
local React = require(script.Parent.Parent.RoactCompat)

local function reducer(value: number)
	return (value + 1)%1_000_000
end

local function useForceUpdate(): () -> ()
	local _, update = React.useReducer(reducer, 0)
	return update
end

return useForceUpdate
