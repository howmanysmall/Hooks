--!optimize 2
local UserInputService = game:GetService("UserInputService")
local React = require(script.Parent.Parent.RoactCompat)
local useBinding = require(script.Parent.useBinding)

local function useMouse(onChange: nil | (mouseLocation: Vector2) -> ()): React.ReactBinding<Vector2>
	local location, setLocation = useBinding(UserInputService:GetMouseLocation())
	React.useEffect(function()
		local connection = UserInputService.InputChanged:Connect(function(inputObject)
			if inputObject.UserInputType == Enum.UserInputType.MouseMovement then
				local mouseLocation = UserInputService:GetMouseLocation()
				setLocation(mouseLocation)

				if onChange then
					onChange(mouseLocation)
				end
			end
		end)

		return function()
			connection:Disconnect()
		end
	end, {})

	return location
end

return useMouse
