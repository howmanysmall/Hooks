--!optimize 2
--!strict
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local React = require(script.Parent.Packages.React)

--[=[
	The `usePrevious` hook stores the previous value of a state in a ref, it returns undefined on initial render and the previous value of a state after rerender.

	@tag State Management
	@within Hooks
	@param value T -- The value to store.
	@return T? -- The previous value of the state.
]=]
local function usePrevious<T>(value: T)
	local ref = React.useRef(nil :: T?)

	React.useEffect(function()
		ref.current = value
	end, GetDependencies(value))

	return ref.current
end

return usePrevious
