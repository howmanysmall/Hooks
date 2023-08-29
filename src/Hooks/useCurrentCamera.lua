--!optimize 2
local Workspace = game:GetService("Workspace")
local React = require(script.Parent.Parent.RoactCompat)

local function useCurrentCamera(onChange: nil | (currentCamera: Camera) -> ()): Camera
	local currentCamera, setCurrentCamera = React.useState(Workspace.CurrentCamera)
	React.useEffect(function()
		local connection = Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
			if Workspace.CurrentCamera then
				setCurrentCamera(Workspace.CurrentCamera)
				if onChange then
					onChange(Workspace.CurrentCamera)
				end
			end
		end)

		return function()
			connection:Disconnect()
		end
	end, {})

	return currentCamera
end

return useCurrentCamera
