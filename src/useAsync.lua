--!optimize 2
local Promise = require(script.Parent.Packages.Promise)
local React = require(script.Parent.Packages.React)

type Promise<T> = any
type UseAsyncState<T> = {
	Exception: unknown?,
	Result: T?,
	Status: typeof(Promise.Status),
}

--[=[
	`useAsync` wraps a Promise to a state.

	@tag State Management
	@within Hooks
	@param promise Promise<T> | () -> Promise<T> -- The Promise to wrap.
	@return T? -- The result of the Promise.
	@return unknown? -- The error message of the Promise.
	@return Promise.Status -- The status of the Promise.
]=]
local function useAsync<T>(promiseOrGetPromise: Promise<T> | () -> Promise<T>, dependencies: {unknown}?)
	local state, setState = React.useState({
		Status = Promise.Status.Started,
	} :: UseAsyncState<T>)

	local exception = state.Exception
	local result = state.Result
	local status = state.Status

	React.useEffect(function()
		if status ~= Promise.Status.Started then
			setState({
				Status = Promise.Status.Started,
			})
		end

		local promise = if type(promiseOrGetPromise) == "function"
			then (promiseOrGetPromise :: () -> Promise<T>)()
			else promiseOrGetPromise

		assert(Promise.is(promise), "Not a promise!")

		promise:andThen(function(value)
			setState({
				Exception = exception,
				Result = value,
				Status = promise:getStatus(),
			})
		end, function(errorMessage)
			setState({
				Exception = errorMessage,
				Result = result,
				Status = promise:getStatus(),
			})
		end)

		return function()
			promise:cancel()
		end
	end, dependencies or {})

	return result, exception, status
end

return useAsync
