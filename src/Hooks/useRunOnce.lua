--!optimize 2
local React = require(script.Parent.Parent.RoactCompat)

local function useRunOnce(callback: () -> ())
	local hasRan = React.useRef(false)
	React.useEffect(function()
		if not hasRan.current then
			hasRan.current = true
			callback()
		end
	end, {})
end

return useRunOnce
