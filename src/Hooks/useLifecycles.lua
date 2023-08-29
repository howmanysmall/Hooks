--!optimize 2
local React = require(script.Parent.Parent.RoactCompat)

type LifecycleFunction = () -> ()

local function useLifecycles(didMount: LifecycleFunction?, willUnmount: LifecycleFunction?)
	React.useEffect(function()
		if didMount then
			didMount()
		end

		return function()
			if willUnmount then
				willUnmount()
			end
		end
	end, {})
end

return useLifecycles
