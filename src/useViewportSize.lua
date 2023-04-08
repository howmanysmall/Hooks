--!optimize 2
--!strict
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local React = require(script.Parent.Packages.React)
local useCurrentCamera = require(script.Parent.useCurrentCamera)

--[=[
	A hook that returns the current ViewportSize of the CurrentCamera.

	@client
	@within Hooks
	@param onChange? (viewportSize: Vector2) -> () -- A callback that is called when the viewport size changes.
	@return Binding<Vector2> -- The current viewport size.
]=]
local function useViewportSize(onChange: nil | (viewportSize: Vector2) -> ())
	local currentCamera = useCurrentCamera()
	local viewportSize, setViewportSize = React.useBinding(currentCamera.ViewportSize)

	React.useEffect(function()
		local newViewportSize = currentCamera.ViewportSize
		setViewportSize(newViewportSize)
		if onChange then
			onChange(newViewportSize)
		end

		local connection = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
			local newNewViewportSize = currentCamera.ViewportSize
			setViewportSize(newNewViewportSize)
			if onChange then
				onChange(newNewViewportSize)
			end
		end)

		return function()
			connection:Disconnect()
		end
	end, GetDependencies(currentCamera))

	return viewportSize
end

return useViewportSize
