--!optimize 2
--!strict
local RunService = game:GetService("RunService")
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local React = require(script.Parent.Parent.RoactCompat)
local Sift = require(script.Parent.Parent.Sift)
local useBinding = require(script.Parent.useBinding)

local FREQUENCY = math.pi/12
local PI_DIV_40 = math.pi/40
local TAU = math.pi*2
local TOTAL_POINTS = 15

export type IParameters = {
	IsPerformanceMode: boolean?,
	Visible: boolean?,
}

type IParametersFixed = {
	IsPerformanceMode: boolean,
	Visible: boolean,
}

local Sift_Dictionary_merge = Sift.Dictionary.merge
local DEFAULT = {
	IsPerformanceMode = false,
	Visible = true,
}

local useRef = (React.useRef :: any) :: <T>(value: T) -> {current: T}

local function useRainbowColorSequence(parameters: IParameters?): React.ReactBinding<ColorSequence>
	local trueParameters: IParametersFixed = Sift_Dictionary_merge(parameters, DEFAULT)

	local colorSequenceArray = useRef(table.create(TOTAL_POINTS + 1) :: {ColorSequenceKeypoint}).current
	local colorSequence, setColorSequence = useBinding(ColorSequence.new(Color3.fromRGB(255, 255, 255)))
	local increment, setIncrement = useBinding(0)
	local phaseShift, setPhaseShift = useBinding(0)

	local isPerformanceMode = not not trueParameters.IsPerformanceMode
	local visible = not not trueParameters.Visible

	local onHeartbeat = React.useCallback(function()
		if visible then
			local currentIncrement = increment:getValue()
			if not isPerformanceMode and currentIncrement%2 == 0 then
				local currentPhaseShift = phaseShift:getValue()
				for index = 0, TOTAL_POINTS do
					colorSequenceArray[index + 1] = ColorSequenceKeypoint.new(
						index/TOTAL_POINTS,
						Color3.fromRGB(
							127*math.sin(FREQUENCY*index + currentPhaseShift) + 128,
							127*math.sin(FREQUENCY*index + 2*1.0471975511966 + currentPhaseShift) + 128,
							127*math.sin(FREQUENCY*index + 4*1.0471975511966 + currentPhaseShift) + 128
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
		end
	end, GetDependencies(isPerformanceMode, visible))

	React.useEffect(function()
		if isPerformanceMode then
			onHeartbeat()
		end
	end, GetDependencies(isPerformanceMode))

	React.useEffect(function()
		if visible then
			local connection = RunService.Heartbeat:Connect(onHeartbeat)
			return function()
				connection:Disconnect()
			end
		end

		return function() end
	end, GetDependencies(visible))

	return colorSequence
end

return useRainbowColorSequence
