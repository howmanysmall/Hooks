--!optimize 2
local GetDependencies = require(script.Parent.Utility.GetDependencies)
local Promise = require(script.Parent.Parent.Promise)
local React = require(script.Parent.Parent.RoactCompat)

local useAsync = require(script.Parent.useAsync)
local useBinding = require(script.Parent.useBinding)

local function useAsyncToBinding<T>(asyncFunction: () -> Promise.Promise<T>, defaultValue: T)
	local binding, setBinding = useBinding(defaultValue)
	local data = useAsync(asyncFunction)

	React.useEffect(function()
		if not data.IsLoading then
			if data.IsCancelled then
				warn("promise was cancelled!")
			elseif data.Error ~= nil then
				warn(`promise errored! - {data.Error}`)
			elseif data.Value ~= nil then
				setBinding(data.Value)
			else
				warn("This shouldn't ever be reached...", data)
			end
		end
	end, GetDependencies(data.Error, data.IsLoading, data.Value, data.IsCancelled))

	return binding
end

return useAsyncToBinding
