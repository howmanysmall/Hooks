--!optimize 2
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local LuauPolyfill = require(script.Parent.Parent.LuauPolyfill)
local React = require(script.Parent.Parent.RoactCompat)

local function useTimeout(ms: number?): boolean
	local ready, setReady = React.useState(false)
	React.useEffect(function()
		local timer = LuauPolyfill.setTimeout(function()
			setReady(true)
		end, ms or 0)

		return function()
			LuauPolyfill.clearTimeout(timer)
		end
	end, GetDependencies(ms))

	return ready
end

return useTimeout
