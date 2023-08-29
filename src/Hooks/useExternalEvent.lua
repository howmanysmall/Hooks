--!optimize 2
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local React = require(script.Parent.Parent.RoactCompat)

local function useExternalEvent(event: RBXScriptSignal, callback: (...any) -> ())
	React.useEffect(function()
		local connection = event:Connect(callback)
		return function()
			connection:Disconnect()
		end
	end, GetDependencies(event, callback))
end

return useExternalEvent
