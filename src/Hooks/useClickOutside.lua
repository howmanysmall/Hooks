--!optimize 2
local UserInputService = game:GetService("UserInputService")
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local React = require(script.Parent.Parent.RoactCompat)
local Types = require(script.Parent.Parent.Types)

local DEFAULT_INPUTS = {Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch}

local function contains(guiObject: GuiObject, position: Vector3)
	local absolutePosition = guiObject.AbsolutePosition
	local absoluteSize = guiObject.AbsoluteSize

	local X = position.X
	local Y = position.Y

	return
		absolutePosition.X <= X and
		absolutePosition.Y <= Y and
		absolutePosition.X + absoluteSize.X >= X and
		absolutePosition.Y + absoluteSize.Y >= Y
end

local function useClickOutside<T>(
	onClick: () -> (),
	userInputTypes: {Enum.UserInputType}?,
	guiObjects: {GuiObject}?
): Types.ReactRef<T & GuiObject>
	local trueUserInputTypes = if userInputTypes then userInputTypes else DEFAULT_INPUTS
	local ref = React.useRef(React.createRef()).current

	React.useEffect(function()
		local function onInputBegan(inputObject: InputObject)
			if type(guiObjects) == "table" then
				local shouldTrigger = true
				for _, guiObject in guiObjects do
					if not (guiObject ~= nil and not contains(guiObject, inputObject.Position)) then
						shouldTrigger = false
						break
					end
				end

				if shouldTrigger then
					onClick()
				end
			else
				local guiObject = ref:getValue()
				if guiObject ~= nil and not contains(guiObject, inputObject.Position) then
					onClick()
				end
			end
		end

		local connection = UserInputService.InputBegan:Connect(function(inputObject)
			if table.find(trueUserInputTypes, inputObject.UserInputType) then
				onInputBegan(inputObject)
			end
		end)

		return function()
			connection:Disconnect()
		end
	end, GetDependencies(ref, onClick, guiObjects))

	return ref
end

return useClickOutside
