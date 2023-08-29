--!optimize 2
local UserInputService = game:GetService("UserInputService")
local React = require(script.Parent.Parent.RoactCompat)
local useExternalEvent = require(script.Parent.useExternalEvent)

local IS_GAMEPAD_MAP = {
	[Enum.UserInputType.Gamepad1] = true,
	[Enum.UserInputType.Gamepad2] = true,
	[Enum.UserInputType.Gamepad3] = true,
	[Enum.UserInputType.Gamepad4] = true,
	[Enum.UserInputType.Gamepad5] = true,
	[Enum.UserInputType.Gamepad6] = true,
	[Enum.UserInputType.Gamepad7] = true,
	[Enum.UserInputType.Gamepad8] = true,

	-- Mouse and keyboard input
	[Enum.UserInputType.MouseButton1] = false,
	[Enum.UserInputType.MouseButton2] = false,
	[Enum.UserInputType.MouseButton3] = false,
	[Enum.UserInputType.MouseWheel] = false,
	[Enum.UserInputType.MouseMovement] = false,
	[Enum.UserInputType.Keyboard] = false,
	[Enum.UserInputType.TextInput] = false,

	-- Touch input
	[Enum.UserInputType.Touch] = false,
}

local function useIsGamepad()
	local isGamepad, setIsGamepad = React.useState(function()
		local lastInputType = UserInputService:GetLastInputType()
		return IS_GAMEPAD_MAP[lastInputType] == true
	end)

	local lastInputTypeChangedCallback = React.useCallback(function(lastInputType)
		local newInputIsGamepad = IS_GAMEPAD_MAP[lastInputType]
		if newInputIsGamepad ~= nil then
			setIsGamepad(newInputIsGamepad)
		end
	end)

	useExternalEvent(UserInputService.LastInputTypeChanged, lastInputTypeChangedCallback)
	return isGamepad
end

return useIsGamepad
