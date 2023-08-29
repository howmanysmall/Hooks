--!optimize 2
local React = require(script.Parent.Parent.RoactCompat)
local useBinding = require(script.Parent:FindFirstChild("useBinding"))
local useViewportSize = require(script.Parent:FindFirstChild("useViewportSize"))

--local function useStrokeScale(pixelThickness: number?, relativeSize: number?): React.ReactBinding<number>
--	local truePixelThickness = if pixelThickness then pixelThickness else 1
--	local trueRelativeSize = if relativeSize then relativeSize else 985
--	local ratio = truePixelThickness/trueRelativeSize

--	local thickness, setThickness = useBinding(0)
--	useViewportSize(function(viewportSize)
--		setThickness(viewportSize.X*ratio)
--	end)

--	return thickness
--end

local function useStrokeScale(pixelThickness: number?, relativeSize: number?): React.ReactBinding<number>
	local truePixelThickness = if pixelThickness then pixelThickness else 1
	local trueRelativeSize = if relativeSize then relativeSize else 985
	local ratio = truePixelThickness/trueRelativeSize

	return (useViewportSize() :: any):map(React.useCallback(function(viewportSize)
		return viewportSize.X*ratio
	end, {ratio}))
end

return useStrokeScale
