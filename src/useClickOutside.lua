--!optimize 2
--!strict
local UserInputService = game:GetService("UserInputService")
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local React = require(script.Parent.Packages.React)

local DEFAULT_INPUTS = {Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch}

local function ContainsPosition(guiObject: GuiObject, position: Vector3)
	local absolutePosition = guiObject.AbsolutePosition
	local absoluteSize = guiObject.AbsoluteSize

	local x = position.X
	local y = position.Y

	return absolutePosition.X <= x
		and absolutePosition.Y <= y
		and absolutePosition.X + absoluteSize.X >= x
		and absolutePosition.Y + absoluteSize.Y >= y
end

--[=[
	A hook used to detect click and touch events outside of specified element.

	### Luau:

	```lua
	local function Component()
		local visible, setVisible = React.useBinding(false)
		local ref = Hooks.useClickOutside(function()
			setVisible(false)
		end)

		return React.createElement("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(100, 100),
			Visible = visible,

			ref = ref,
		})
	end
	```

	@tag User Interface
	@client
	@within Hooks
	@param onClick () -> () -- A callback to call when a click or touch event is detected outside of the element.
	@param userInputTypes? {Enum.UserInputType} -- A list of user input types to detect. Defaults to `Enum.UserInputType.MouseButton1` and `Enum.UserInputType.Touch`.
	@param guiObjects? {GuiObject} -- A list of elements to detect clicks outside of. Defaults to the element returned by `useRef`.
	@return Ref<GuiObject> -- A ref to the element to detect clicks outside of.
]=]
local function useClickOutside<T>(onClick: () -> (), userInputTypes: {Enum.UserInputType}?, guiObjects: {GuiObject}?)
	local trueUserInputTypes: {Enum.UserInputType} = if userInputTypes then userInputTypes else DEFAULT_INPUTS
	local ref = assert(React.useRef(React.createRef()).current, "Type correction failed.")

	local onInputBegan = React.useCallback(function(inputObject: InputObject)
		if guiObjects then
			local shouldTrigger = true
			for _, guiObject in guiObjects do
				if not (guiObject and not ContainsPosition(guiObject, inputObject.Position)) then
					shouldTrigger = false
					break
				end
			end

			if shouldTrigger then
				onClick()
			end
		else
			local guiObject = ref:getValue()
			if guiObject and not ContainsPosition(guiObject, inputObject.Position) then
				onClick()
			end
		end
	end, GetDependencies(ref, onClick, guiObjects))

	React.useEffect(function()
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
