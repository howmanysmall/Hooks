--!optimize 2
--!strict
local React = require(script.Parent.Packages.React)

local function Reducer(value: number)
	return (value + 1) % 1_000_000
end

--[=[
	A hook that creates a function used to force a component to re-render.

	@tag Lifecycle
	@within Hooks
	@return () -> () -- The function to call to force a re-render.
]=]
local function useForceUpdate(): () -> ()
	local _, dispatch = React.useReducer(Reducer, 0)
	return dispatch :: () -> ()
end

return useForceUpdate
