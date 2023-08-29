--!optimize 2
local Promise = require(script.Parent.Parent.Promise)
local React = require(script.Parent.Parent.RoactCompat)

export type UseAsyncResults<T = any> = {
	IsLoading: boolean,
	IsCancelled: boolean?,
	Error: string?,
	Value: T?,
}

local function useAsync<T>(asyncFunction: () -> Promise.Promise<T>): UseAsyncResults<T>
	local promise = React.useMemo(asyncFunction, {})
	if not Promise.Is(promise) then
		error("Value is not an async function!", 3)
	end

	local result, setResult = React.useState({
		IsLoading = true,
	})

	React.useEffect(function()
		local thread = task.spawn(function()
			local status, value = promise:WaitStatus()
			setResult({
				IsLoading = false,
				IsCancelled = status == Promise.Status.Cancelled,
				Error = if status == Promise.Status.Rejected then value else nil,
				Value = if status == Promise.Status.Resolved then value else nil,
			})
		end)

		return function()
			task.cancel(thread)
		end
	end, {})

	return result
end

return useAsync
