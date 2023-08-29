--!optimize 2
--!strict
local React = require(script.Parent.Parent.RoactCompat)
local Types = require(script.Parent.Parent.Types)

local function useBinding<T>(initialValue: T): (React.ReactBinding<T>, Types.SetFunction<T>)
	local bindingRef = React.useRef({React.createBinding(initialValue)}).current :: {any}
	return bindingRef[1], bindingRef[2] :: Types.SetFunction<T>
end

return useBinding
