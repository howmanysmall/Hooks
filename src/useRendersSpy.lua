--!optimize 2
--!strict
local React = require(script.Parent.Packages.React)

--[=[
	Returns the amount of times the component has been rendered since mounting. This is a very useful hook for testing.

	@tag Lifecycle
	@tag Debugging
	@within Hooks
	@return number -- The amount of renders.
]=]
local function useRendersSpy()
	local count = React.useRef(0)
	React.useEffect(function()
		local current = count.current :: number
		count.current = current + 1
	end)

	return count.current
end

return useRendersSpy
