--!optimize 2
--!strict
local RunService = game:GetService("RunService")
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local React = require(script.Parent.Packages.React)

local FREQUENCY = math.pi / 12
local PI_DIV_40 = math.pi / 40
local TAU = math.pi * 2
local TOTAL_POINTS = 15

--[=[
	@interface IRainbowColorSequenceParameters
	.Event? RBXScriptSignal -- The event to connect to. Defaults to [RunService.Heartbeat].
	.IsPerformanceMode? boolean -- Whether or not the hook should be in performance mode. Performance mode disables the effect entirely. Defaults to `false`.
	.Visible? boolean -- Whether or not the hook should be visible. Defaults to `true`.
	@within Types
]=]
export type IRainbowColorSequenceParameters = {
	Event: RBXScriptSignal?,
	IsPerformanceMode: boolean?,
	Visible: boolean?,
}

type IRainbowColorSequenceParametersPatched = {
	Event: RBXScriptSignal,
	IsPerformanceMode: boolean,
	Visible: boolean,
}

local WHITE_COLOR3 = Color3.fromRGB(255, 255, 255)

--[=[
	An example hook that uses a rainbow color sequence.

	@tag UI
	@tag Effects
	@within Hooks
	@param parameters? IParameters -- The parameters for the hook.
	@return Binding<ColorSequence> -- The rainbow color sequence.
]=]
local function useRainbowColorSequence(parameters: IRainbowColorSequenceParameters?)
	local trueParameters = React.useMemo(function()
		local value: IRainbowColorSequenceParametersPatched = {
			Event = RunService.Heartbeat,
			IsPerformanceMode = false,
			Visible = true,
		}

		if parameters then
			if parameters.Event then
				value.Event = parameters.Event
			end

			if parameters.IsPerformanceMode ~= nil then
				value.IsPerformanceMode = parameters.IsPerformanceMode
			end

			if parameters.Visible ~= nil then
				value.Visible = parameters.Visible
			end
		end

		return value
	end, GetDependencies(parameters))

	local colorSequenceArray = assert(
		React.useRef(table.create(TOTAL_POINTS + 1) :: {ColorSequenceKeypoint}).current,
		"Failed to get current? This shouldn't be happening."
	)

	local colorSequence, setColorSequence = React.useBinding(ColorSequence.new(WHITE_COLOR3))
	local increment, setIncrement = React.useBinding(0)
	local phaseShift, setPhaseShift = React.useBinding(0)

	local isPerformanceMode = trueParameters.IsPerformanceMode
	local visible = trueParameters.Visible

	local performanceModeDependency = GetDependencies(isPerformanceMode)

	local updateValues = React.useCallback(function()
		local currentIncrement = increment:getValue()
		if not isPerformanceMode and currentIncrement % 2 == 0 then
			local currentPhaseShift = phaseShift:getValue()
			for index = 0, TOTAL_POINTS do
				colorSequenceArray[index + 1] = ColorSequenceKeypoint.new(
					index / TOTAL_POINTS,
					Color3.fromRGB(
						127 * math.sin(FREQUENCY * index + currentPhaseShift) + 128,
						127 * math.sin(FREQUENCY * index + 2 * 1.0471975511966 + currentPhaseShift) + 128,
						127 * math.sin(FREQUENCY * index + 4 * 1.0471975511966 + currentPhaseShift) + 128
					)
				)
			end

			setColorSequence(ColorSequence.new(colorSequenceArray))
			table.clear(colorSequenceArray)

			currentPhaseShift += PI_DIV_40
			if currentPhaseShift >= TAU then
				currentPhaseShift = 0
			end

			setPhaseShift(currentPhaseShift)
			if currentIncrement >= 1000 then
				currentIncrement = 0
			end
		end

		setIncrement(currentIncrement + 1)
	end, performanceModeDependency)

	local onEvent = React.useCallback(function()
		if visible then
			updateValues()
		end
	end, GetDependencies(updateValues, visible))

	React.useEffect(function()
		if isPerformanceMode then
			updateValues()
		end
	end, GetDependencies(isPerformanceMode, updateValues))

	React.useEffect(function(): nil | () -> ()
		if visible then
			local connection = trueParameters.Event:Connect(onEvent)
			return function()
				connection:Disconnect()
			end
		end

		return nil
	end, GetDependencies(visible, onEvent))

	return colorSequence
end

return useRainbowColorSequence
