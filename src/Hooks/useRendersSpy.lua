--!optimize 2
local React = require(script.Parent.Parent.RoactCompat)

local function useRendersSpy(): number
	local count = React.useRef(0)
	React.useEffect(function()
		count.current += 1
	end)

	return count.current
end

return useRendersSpy
