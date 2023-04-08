--!optimize 2
--!strict
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local React = require(script.Parent.Packages.React)

type IIncomingUpdate = {
	ResolveTime: number,
	Thread: thread,
}

local function ClearUpdates(updates: {IIncomingUpdate}, laterThan: number?)
	for id, update in updates do
		if laterThan == nil or update.ResolveTime > laterThan then
			updates[id] = nil
			task.cancel(update.Thread)
		end
	end
end

local nextId = 0

--[=[
	A hook used for delaying a value.

	@tag State Management
	@within Hooks
	@param value T -- The value to delay.
	@param delayInSeconds number -- The amount of time to delay the value by.
	@return T -- The delayed value.
]=]
local function useDelayedValue<T>(value: T, delayInSeconds: number)
	local delayedValue, setDelayedValue = React.useState(value)
	local updates = React.useMemo(function()
		local values: {IIncomingUpdate} = {}
		return values
	end, {})

	React.useEffect(function()
		local id = nextId
		nextId += 1

		local update: IIncomingUpdate = {
			ResolveTime = os.clock() + delayInSeconds,
			Thread = task.delay(delayInSeconds, function()
				setDelayedValue(value)
				updates[id] = nil
			end),
		}

		ClearUpdates(updates, update.ResolveTime)
		updates[id] = update
	end, GetDependencies(delayInSeconds, value))

	React.useEffect(function()
		return function()
			ClearUpdates(updates)
		end
	end, {})

	return delayedValue
end

return useDelayedValue
