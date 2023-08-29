--!optimize 2
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local React = require(script.Parent.Parent.RoactCompat)

local function useEffectOnce(callback: () -> (), when: any)
	local hasRunEver = React.useRef(false)
	React.useEffect(function()
		if when and not hasRunEver.current then
			callback()
			hasRunEver.current = true
		end
	end, GetDependencies(when))
end

return useEffectOnce
