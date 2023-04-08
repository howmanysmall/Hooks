--!optimize 2
--!strict

local Workspace = game:GetService("Workspace")
local React = require(script.Parent.Packages.React)
local useExternalEvent = require(script.Parent.useExternalEvent)

--[=[
	A hook used for getting the current camera.

	@client
	@within Hooks
	@param onChange? (currentCamera: Camera) -> () -- A callback that is called when the current camera changes.
	@return Camera -- The current camera.
]=]
local function useCurrentCamera(onChange: nil | (currentCamera: Camera) -> ())
	local currentCamera, setCurrentCamera = React.useState(Workspace.CurrentCamera)
	useExternalEvent(Workspace:GetPropertyChangedSignal("CurrentCamera"), function()
		local newCurrentCamera = Workspace.CurrentCamera
		if newCurrentCamera then
			setCurrentCamera(newCurrentCamera)
			if onChange then
				onChange(newCurrentCamera)
			end
		end
	end)

	return currentCamera
end

return useCurrentCamera
