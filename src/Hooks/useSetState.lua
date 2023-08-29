--!optimize 2
local LuauPolyfill = require(script.Parent.Parent.LuauPolyfill)
local React = require(script.Parent.Parent.RoactCompat)

local LuauPolyfill_Object_assign = LuauPolyfill.Object.assign

local function useSetState<T>(initialState: T?)
	assert(not initialState or type(initialState) == "table", "initialState must be a table?, got something else.")
	local state, updateState = React.useState(if initialState then initialState else {})
	local function setState(patch)
		LuauPolyfill_Object_assign(state, patch)
		updateState(state)
	end

	return state, setState
end

return useSetState
