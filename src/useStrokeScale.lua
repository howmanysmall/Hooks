--!optimize 2
--!strict
local Workspace = game:GetService("Workspace")
local React = require(script.Parent.Packages.React)

--[=[
	A hook used to scale a stroke size based on the viewport size.

	@tag UI
	@tag Effects
	@client
	@within Hooks
	@param pixelThickness? number -- The thickness of the stroke in pixels. Defaults to 1.
	@param relativeSize? number -- The relative size of the screen. Defaults to 985.
	@return Binding<number> -- The thickness of the stroke in pixels.
]=]
local function useStrokeScale(pixelThickness: number?, relativeSize: number?)
	local truePixelThickness = if pixelThickness then pixelThickness else 1
	local trueRelativeSize = if relativeSize then relativeSize else 985

	local ratio = truePixelThickness / trueRelativeSize
	local thickness, setThickness = React.useBinding(0)

	React.useEffect(function()
		local currentCamera = Workspace.CurrentCamera
		setThickness(currentCamera.ViewportSize.X * ratio)

		local connection = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
			setThickness(currentCamera.ViewportSize.X * ratio)
		end)

		return function()
			connection:Disconnect()
		end
	end, {})

	return thickness
end

return useStrokeScale
