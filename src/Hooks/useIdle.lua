--!optimize 2
local UserInputService = game:GetService("UserInputService")
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local LuauPolyfill = require(script.Parent.Parent.LuauPolyfill)
local React = require(script.Parent.Parent.RoactCompat)
local Sift = require(script.Parent.Parent.Sift)

local DEFAULT_INPUTS = {
	Enum.UserInputType.Keyboard,
	Enum.UserInputType.Touch,
	Enum.UserInputType.Gamepad1,
	Enum.UserInputType.MouseButton1,
	Enum.UserInputType.MouseButton2,
	Enum.UserInputType.MouseButton3,
}

local DEFAULT_OPTIONS = {
	InitialState = true,
	UserInputTypes = DEFAULT_INPUTS,
	UseWindowFocus = true,
}

local Sift_Dictionary_merge = Sift.Dictionary.merge

export type IOptions = {
	InitialState: boolean?,
	UserInputTypes: {Enum.UserInputType}?,
	UseWindowFocus: boolean?,
}

type PatchOptions = {
	InitialState: boolean,
	UserInputTypes: {Enum.UserInputType},
	UseWindowFocus: boolean,
}

local function useIdle(timeout: number, options: IOptions?)
	local trueOptions = Sift_Dictionary_merge(DEFAULT_OPTIONS, options) :: PatchOptions
	local idle, setIdle = React.useState(trueOptions.InitialState)
	local timer = React.useRef(nil)

	local handleInput = React.useCallback(function()
		setIdle(false)
		if timer.current then
			LuauPolyfill.clearTimeout(timer.current)
		end

		timer.current = LuauPolyfill.setTimeout(function()
			setIdle(true)
		end, timeout)
	end, GetDependencies(timeout))

	React.useEffect(function()
		local connection = UserInputService.InputBegan:Connect(function(inputObject)
			if table.find(trueOptions.UserInputTypes, inputObject.UserInputType) then
				handleInput()
			end
		end)

		return function()
			connection:Disconnect()
		end
	end, GetDependencies(handleInput))

	React.useEffect(function()
		if trueOptions.UseWindowFocus then
			local onWindowFocused = UserInputService.WindowFocused:Connect(handleInput)
			local onWindowFocusReleased = UserInputService.WindowFocusReleased:Connect(function()
				if timer.current then
					LuauPolyfill.clearTimeout(timer.current)
					timer.current = nil
				end

				setIdle(true)
			end)

			return function()
				onWindowFocused:Disconnect()
				onWindowFocusReleased:Disconnect()
			end
		end
	end, GetDependencies(handleInput, trueOptions.UseWindowFocus))

	return idle
end

return useIdle
