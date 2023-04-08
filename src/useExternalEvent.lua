--!optimize 2
--!strict
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local React = require(script.Parent.Packages.React)

--[=[
	A hook that connects and disconnects a callback to an event. This is really
	just a fancy `useEffect` wrapper.

	### Luau:

	```lua
	local function Component()
	end
	```

	@tag Lifecycle
	@within Hooks
	@param event RBXScriptSignal -- The event to connect to.
	@param callback (...any) -> () -- The callback to connect to the event.
]=]
local function useExternalEvent(event: RBXScriptSignal, callback: (...any) -> ())
	debug.profilebegin("useExternalEvent")
	React.useEffect(function()
		local connection = event:Connect(callback)
		return function()
			connection:Disconnect()
		end
	end, GetDependencies(callback, event))
	debug.profileend()
end

return useExternalEvent
