--!optimize 2
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local Promise = require(script.Parent.Parent.Promise)
local React = require(script.Parent.Parent.RoactCompat)

local useAsync = require(script.Parent.useAsync)

local function useAsyncToState<T>(asyncFunction: () -> Promise.Promise<T>, defaultValue: T?, dependencies: {unknown}?)
	local state, setState = React.useState(defaultValue)
	local data = useAsync(asyncFunction)

	React.useEffect(function()
		if not data.IsLoading then
			if data.IsCancelled then
				warn("promise was cancelled!")
			elseif data.Error ~= nil then
				warn(`promise errored! - {data.Error}`)
			elseif data.Value ~= nil then
				setState(data.Value)
			else
				warn("This shouldn't ever be reached...", data)
			end
		end
	end, if dependencies then GetDependencies(data.Error, data.IsLoading, data.Value, data.IsCancelled, table.unpack(dependencies)) else GetDependencies(data.Error, data.IsLoading, data.Value, data.IsCancelled))

	return state
end

return useAsyncToState
