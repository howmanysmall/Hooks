--!optimize 2
local Workspace = game:GetService("Workspace")
local React = require(script.Parent.Parent.RoactCompat)
local useBinding = require(script.Parent.useBinding)

local function useViewportSize(onChange: nil | (viewportSize: Vector2) -> ()): React.ReactBinding<Vector2>
	local currentCamera, setCurrentCamera = React.useState(Workspace.CurrentCamera)
	local viewportSize, setViewportSize = useBinding(currentCamera.ViewportSize)

	React.useEffect(function()
		local connection = Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
			if Workspace.CurrentCamera then
				setCurrentCamera(Workspace.CurrentCamera)
				setViewportSize(Workspace.CurrentCamera.ViewportSize)
				if onChange then
					onChange(Workspace.CurrentCamera.ViewportSize)
				end
			end
		end)

		return function()
			connection:Disconnect()
		end
	end, {})

	React.useEffect(function()
		local connection = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
			setViewportSize(currentCamera.ViewportSize)
			if onChange then
				onChange(currentCamera.ViewportSize)
			end
		end)

		return function()
			connection:Disconnect()
		end
	end, {currentCamera})

	return viewportSize
end

return useViewportSize
