--!optimize 2
--!strict
local GuiService = game:GetService("GuiService")
local useViewportSize = require(script.Parent.useViewportSize)

local TOP_INSET, BOTTOM_INSET = GuiService:GetGuiInset()

--[=[
	A hook used for scaling UI elements to fit the current screen.

	@tag UI
	@client
	@within Hooks
	@param scale number -- The scale to use for the UI element.
	@param goalSize Vector2 | Vector3 -- The size of the UI element. Recommended to use Vector3 as it is faster.
	@return Binding<number> -- The scale to use for the UI element.
]=]
local function useScale(scale: number, goalSize: Vector2 | Vector3)
	return useViewportSize():map(function(viewportSize: Vector2)
		local size = viewportSize - TOP_INSET + BOTTOM_INSET
		return 1 / math.max(goalSize.X / size.X, goalSize.Y / size.Y) * scale
	end)
end

return useScale
