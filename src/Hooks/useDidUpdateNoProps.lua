--!optimize 2
local React = require(script.Parent.Parent.RoactCompat)

local function useDidUpdateNoProps(callback: nil | () -> ())
	local componentDidMount = React.useRef(false)
	local componentDidUpdate = React.useRef(false)

	React.useEffect(function()
		if not componentDidMount.current then
			componentDidMount.current = true
			return
		end

		if not componentDidUpdate.current then
			componentDidUpdate.current = true
		end

		if callback then
			callback()
		end
	end)

	return componentDidUpdate
end

return useDidUpdateNoProps
